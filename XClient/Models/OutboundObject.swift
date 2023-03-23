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
    var sendThrough: IPv4Address?
    var proxySettings: any ProxySettings
    var streamSettings: StreamSettingsObject
}

var outboundExample: [OutboundObject] = [
    OutboundObject(tag: "server1", proxySettings: VlessSettingsObject(address: "hello.com", port: 1234, ID: "dachang", flow: VlessFlow.xtls_rprx_vision), streamSettings: StreamSettingsObject()),
    OutboundObject(tag: "server2", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(security: Security.tls)),
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
        var sendThrough: IPv4Address? = IPv4Address("0.0.0.0")
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

enum Proxy: String, CaseIterable, Identifiable, Hashable {
    case vless
    case vmess
    case trojan
    case shadowsocks
    case socks
    case http
    case wireguard
    
    var id: Self { self }
}

// only store the used protocol
protocol ProxySettings: Hashable {
    var proxyProtocol: Proxy {get}
}

// store all the protocol settings
struct AllProxySettings: Hashable {
    var vlessSettings: VlessSettingsObject = VlessSettingsObject()
    var vmessSettings: VmessSettingsObject = VmessSettingsObject()
}

struct VlessSettingsObject: ProxySettings {
    let proxyProtocol = Proxy.vless
    var address: String = ""
    var port: UInt16?
    var ID: String = ""
    var encryption: VlessEncryption = VlessEncryption.none
    var flow: VlessFlow = VlessFlow.none
    
}

enum VlessFlow: String, CaseIterable, Identifiable {
    case none
    case xtls_rprx_vision
    
    var id: Self { self }
}

enum VlessEncryption: String, CaseIterable, Identifiable {
    case none
    
    var id: Self { self }
}

struct VmessSettingsObject: ProxySettings {
    let proxyProtocol = Proxy.vmess
    var address = String()
    var port: UInt16?
    var ID = String()
    var alterid = String()
}

struct StreamSettingsObject: Hashable {
    var network: StreamNetwork = StreamNetwork.tcp
    var tcpSettings: TcpObject = TcpObject()
    // add more settings
    
    var security: Security = Security.none
    var tlsSettings: TlsObject = TlsObject()
    // add more settings
}

enum StreamNetwork: String, CaseIterable, Identifiable {
    case tcp
    case kcp
    case ws
    case http
    case domainsocket
    case quic
    case grpc
    
    var id: Self { self }
    var name: String {
        rawValue.uppercased()
    }
}

struct TcpObject: Hashable {
    var http: Bool = false
    var host: String = ""
    var path: String = ""
}

enum Security: String, CaseIterable, Identifiable {
    case none
    case tls
    case reality
    
    var id: Self { self }
    var name: String {
        rawValue.uppercased()
    }
}

struct TlsObject: Hashable {
    var allowInsecure: Bool = false
    var disableSystemRoot: Bool = false
    var fingerprint: TlsFingerprint = TlsFingerprint.none
}

enum TlsFingerprint: String, CaseIterable {
    // careful none case is an empty string in the config file
    case none
    case chrome
    case firefox
    case safari
    case ios
    case android
    case edge
    case qq
    case random
    case randomized
    
    var name: String {
        rawValue.capitalized
    }
}
