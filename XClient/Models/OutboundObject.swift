//
//  OutboundObject.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import Foundation
import Network

/*
outbound
    sendthrough
    tag
    proxy protocol
    proxy setting
    stream setting
*/

struct OutboundObject {
    var tag: String
    var sendThrough: IPAddress?
    var proxySettings: ProxySettings
    var streamSettings: StreamSettingsObject
}

var outboundExample: [OutboundObject] = [
    OutboundObject(tag: "server1", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject()),
    OutboundObject(tag: "server2", proxySettings: VmessSettingsObject(), streamSettings: StreamSettingsObject(security: Security.tls)),
]

extension OutboundObject: Hashable {
    static func == (lhs: OutboundObject, rhs: OutboundObject) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tag)
    }
    
    // the user edits Outbound.Data; Outbound gets updated only when "ok" is pressed
    struct Data {
        var tag: String = "New Server"
        var sendThrough: IPAddress? = IPv4Address("0.0.0.0")
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
}

enum Proxy: String, CaseIterable, Identifiable {
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
protocol ProxySettings {
    var proxyProtocol: Proxy {get}
    mutating func unwrap() -> Self
}

// store all the protocol settings
struct AllProxySettings {
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
    
    mutating func unwrap() -> Self {
        self
    }
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
    
    mutating func unwrap() -> Self {
        self
    }
}

struct StreamSettingsObject {
    var network: Network = Network.tcp
    var tcpSettings: TcpObject = TcpObject()
    // add more settings
    
    var security: Security = Security.none
    var tlsSettings: TlsObject = TlsObject()
    // add more settings
}

enum Network: String, CaseIterable, Identifiable {
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

struct TcpObject {
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

struct TlsObject {
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
