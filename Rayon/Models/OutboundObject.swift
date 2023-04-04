//
//  OutboundObject.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import Foundation
import Network

struct OutboundObject: Identifiable, Hashable {
    let id = UUID()
    var tag: String
    var sendThrough: String?
    var proxySettings: any ProxySettings
    var streamSettings: StreamSettingsObject
}

var outboundExample: [OutboundObject] = [
    OutboundObject(tag: "server0", proxySettings: VlessSettingsObject(address: "hello.com", port: 1234, users: [VlessSettingsObject.UserObject(id: "dachang", flow: VlessSettingsObject.Flow.xtls_rprx_vision)]), streamSettings: StreamSettingsObject()),
    OutboundObject(tag: "server1", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(security: Security.tls)),
    OutboundObject(tag: "server2", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(network: StreamNetwork.ws, security: Security.tls)),
]

extension OutboundObject {
    // hashable is the criminal!!!
    // when hashable is configured, equatable checks if the struct is altered.
    // previously, equitable only checks the tag
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.tag == rhs.tag && lhs.id == rhs.id && lhs.sendThrough == rhs.sendThrough && lhs.streamSettings == rhs.streamSettings
    }
    
    // hashable probably isn't working right currently
    func hash(into hasher: inout Hasher) {
        hasher.combine(tag)
    }
    
    //var id: Self { self }
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
    
    struct UserObject: Hashable, Codable {
        var id: String = ""
        var encryption: Encryption = .none
        var flow: Flow?
        var level: Int?
    }
    
    let proxyProtocol = Proxy.vless
    var address: String = ""
    var port: UInt16?
    var users: [UserObject] = [.init()]
    // if `users` is empty, provide a default
    
    enum CodingKeys: String, CodingKey {
        case address
        case port
        case users
    }
}
    
struct VmessSettingsObject: ProxySettings {
    struct UserObject: Hashable, Codable {
        var id = String()
        var alterid: Int?
        var security = "auto"
        var level: Int?
    }
    
    let proxyProtocol = Proxy.vmess
    var address = String()
    var port: UInt16?
    var users: [UserObject] = [.init()]
    
    enum CodingKeys: String, CodingKey {
        case address
        case port
        case users
    }
}
