//
//  OutboundObject.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import Foundation
import Network

struct OutboundObject: Identifiable {
    //var id: Self { self }
    let id = UUID()
    var tag: String
    var sendThrough: String?
    var proxyProtocol: Proxy { proxySettings.proxyProtocol }
    var proxySettings: any ProxySettings
    var streamSettings: StreamSettingsObject
}

extension OutboundObject: Codable {
    enum CodingKeys: String, CodingKey {
        case tag
        case sendThrough
        case proxyProtocol = "protocol"
        case proxySettings = "settings"
        case streamSettings
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tag, forKey: .tag)
        try container.encodeIfPresent(sendThrough, forKey: .sendThrough)
        try container.encode(proxySettings, forKey: .proxySettings)
        try container.encode(proxyProtocol, forKey: .proxyProtocol)
        try container.encode(streamSettings, forKey: .streamSettings)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decode(String.self, forKey: .tag)
        sendThrough = try values.decodeIfPresent(String.self, forKey: .sendThrough)
        let proxyProtocol = try values.decode(Proxy.self, forKey: .proxyProtocol)
        switch proxyProtocol {
        case .vless:
            proxySettings = try values.decode(VlessSettingsObject.self, forKey: .proxySettings)
        case .vmess:
            proxySettings = try values.decode(VmessSettingsObject.self, forKey: .proxySettings)
        default:
            proxySettings = try values.decode(VlessSettingsObject.self, forKey: .proxySettings)
        }
        streamSettings = try values.decode(StreamSettingsObject.self, forKey: .streamSettings)
    }
}

extension OutboundObject: Hashable{
    // hashable is the criminal!!!
    // when hashable is configured, equatable checks if the struct is altered.
    // previously, equitable only checks the tag
    static func == (lhs: Self, rhs: Self) -> Bool {
        let proxyEqual: Bool = {
            if lhs.proxyProtocol == rhs.proxyProtocol {
                switch lhs.proxyProtocol {
                case .vmess:
                    return isEqual(type: VmessSettingsObject.self, lhs: lhs.proxySettings, rhs: rhs.proxySettings)
                case .vless:
                    return isEqual(type: VlessSettingsObject.self, lhs: lhs.proxySettings, rhs: rhs.proxySettings)
                default:
                    return false
                }
            } else {
                return false
            }
        }()
        
        return lhs.tag == rhs.tag && lhs.id == rhs.id && lhs.sendThrough == rhs.sendThrough && proxyEqual && lhs.streamSettings == rhs.streamSettings
    }
    
    // hashable probably isn't working right currently
    func hash(into hasher: inout Hasher) {
        hasher.combine(tag)
    }
}
    
extension OutboundObject {
    // the user edits Outbound.Data; Outbound gets updated only when "ok" is pressed
    struct Data: Hashable {
        var tag: String = "New Server"
        var sendThrough: String?
        var proxyProtocol: Proxy = Proxy.vless
        var allProxySettings: AllProxySettings = AllProxySettings()
        var streamSettings: StreamSettingsObject = StreamSettingsObject()
    }
    
    // `data` struct and the stored struct is different. The conversion is done here
    var data: Data {
        var allProxySettings = AllProxySettings()
        switch proxySettings.proxyProtocol {
        case .vless:
            allProxySettings.vlessSettings = proxySettings as! VlessSettingsObject
        case .vmess:
            allProxySettings.vmessSettings = proxySettings as! VmessSettingsObject
        default:
            break
        }
        return Data(tag: tag, sendThrough: sendThrough, proxyProtocol: proxySettings.proxyProtocol, allProxySettings: allProxySettings, streamSettings: streamSettings)
    }
    
    mutating func update(from data: Data) {
        tag = data.tag
        sendThrough = data.sendThrough
        switch data.proxyProtocol {
        case .vless:
            proxySettings = data.allProxySettings.vlessSettings
        case .vmess:
            proxySettings = data.allProxySettings.vmessSettings
        default:
            break
        }
        streamSettings = data.streamSettings
    }
}

var outboundExample: [OutboundObject] = [
    OutboundObject(tag: "server0", proxySettings: VlessSettingsObject(address: "hello.com", port: 1234, id: "dachang", flow: VlessSettingsObject.Flow.xtls_rprx_vision), streamSettings: StreamSettingsObject()),
    OutboundObject(tag: "server1", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(security: Security.tls)),
    OutboundObject(tag: "server2", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(network: StreamNetwork.ws, security: Security.tls)),
]

/// The available proxy protocols
enum Proxy: String, CaseIterable, Identifiable, Hashable, Codable {
    case vless
    case vmess
    case trojan
    case shadowsocks
    case socks
    case http
    case wireguard
    
    var id: Self { self }
}

/// only store the in use protocol
protocol ProxySettings: Hashable, Codable {
    var proxyProtocol: Proxy {get}
}

/// store all the protocol settings
struct AllProxySettings: Hashable {
    var vlessSettings: VlessSettingsObject = VlessSettingsObject()
    var vmessSettings: VmessSettingsObject = VmessSettingsObject()
}

struct VlessSettingsObject: ProxySettings {
    enum Encryption: String, CaseIterable, Identifiable, Codable {
        case none
        
        var id: Self { self }
    }
    
    enum Flow: String, CaseIterable, Identifiable, Codable {
        case xtls_rprx_vision = "xtls-rprx-vision"
        case xtls_rprx_vision_udp443 = "xtls-rprx-vision-udp443"
        
        var id: Self { self }
    }
    
    var proxyProtocol: Proxy { .vless }
    var address: String = ""
    var port: UInt16?
    var id: String = ""
    var encryption: Encryption = .none
    var flow: Flow?
    var level: Int?
}
    
extension VlessSettingsObject {
    enum Container: String, CodingKey {
        case vnext
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case port
        case users
    }
    
    enum Users: String, CodingKey {
        case id, encryption, flow, level
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Container.self)
        var vnexts = try container.nestedUnkeyedContainer(forKey: .vnext)
        let vnext = try vnexts.nestedContainer(keyedBy: CodingKeys.self)
        address = try vnext.decode(String.self, forKey: .address)
        port = try vnext.decodeIfPresent(UInt16.self, forKey: .port)
        var users = try vnext.nestedUnkeyedContainer(forKey: .users)
        let user = try users.nestedContainer(keyedBy: Users.self)
        id = try user.decode(String.self, forKey: .id)
        encryption = try user.decode(Encryption.self, forKey: .encryption)
        flow = try user.decodeIfPresent(Flow.self, forKey: .flow)
        level = try user.decodeIfPresent(Int.self, forKey: .level)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Container.self)
        var vnexts = container.nestedUnkeyedContainer(forKey: .vnext)
        var vnext = vnexts.nestedContainer(keyedBy: CodingKeys.self)
        try vnext.encode(address, forKey: .address)
        try vnext.encodeIfPresent(port, forKey: .port)
        var users = vnext.nestedUnkeyedContainer(forKey: .users)
        var user = users.nestedContainer(keyedBy: Users.self)
        try user.encode(id, forKey: .id)
        try user.encode(encryption, forKey: .encryption)
        try user.encodeIfPresent(flow, forKey: .flow)
        try user.encodeIfPresent(level, forKey: .level)
    }
}
    
struct VmessSettingsObject: ProxySettings {
    var proxyProtocol: Proxy { .vmess }
    var address = String()
    var port: UInt16?
    var id = String()
    var alterid: Int?
    var security = "auto"
    var level: Int?
}
    
extension VmessSettingsObject {
    enum Container: String, CodingKey {
        case vnext
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case port
        case users
    }
    
    enum Users: String, CodingKey {
        case id, alterid, security, level
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Container.self)
        var vnexts = try container.nestedUnkeyedContainer(forKey: .vnext)
        let vnext = try vnexts.nestedContainer(keyedBy: CodingKeys.self)
        address = try vnext.decode(String.self, forKey: .address)
        port = try vnext.decodeIfPresent(UInt16.self, forKey: .port)
        var users = try vnext.nestedUnkeyedContainer(forKey: .users)
        let user = try users.nestedContainer(keyedBy: Users.self)
        id = try user.decode(String.self, forKey: .id)
        alterid = try user.decodeIfPresent(Int.self, forKey: .alterid)
        security = try user.decode(String.self, forKey: .security)
        level = try user.decodeIfPresent(Int.self, forKey: .level)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Container.self)
        var vnexts = container.nestedUnkeyedContainer(forKey: .vnext)
        var vnext = vnexts.nestedContainer(keyedBy: CodingKeys.self)
        try vnext.encode(address, forKey: .address)
        try vnext.encodeIfPresent(port, forKey: .port)
        var users = vnext.nestedUnkeyedContainer(forKey: .users)
        var user = users.nestedContainer(keyedBy: Users.self)
        try user.encode(id, forKey: .id)
        try user.encodeIfPresent(alterid, forKey: .alterid)
        try user.encode(security, forKey: .security)
        try user.encodeIfPresent(level, forKey: .level)
    }
}
