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
    
    init(tag: String, sendThrough: IPAddress? = nil, proxySettings: ProxySettings, streamSettings: StreamSettingsObject) {
        self.tag = tag
        self.sendThrough = sendThrough
        self.proxySettings = proxySettings
        self.streamSettings = streamSettings
    }
}

extension OutboundObject {
    // the user edits Outbound.Data; Outbound gets updated only when "ok" is pressed
    struct Data {
        var tag: String = "New Server"
        var sendThrough: IPAddress? = IPv4Address("0.0.0.0")
        var proxyProtocol: Proxy = Proxy.vless
        var proxySettings: ProxySettings = VlessSettingsObject()
        var streamSettings: StreamSettingsObject = StreamSettingsObject()
    }
    
    var data: Data {
        Data(tag: tag, sendThrough: sendThrough, proxySettings: proxySettings, streamSettings: streamSettings)
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

protocol ProxySettings { }

struct VlessSettingsObject: ProxySettings {
    var address: String = ""
    var port: UInt16?
    var ID: String = ""
    var encryption: String = ""
    var flow: String = ""
}

struct VmessSettingsObject: ProxySettings {
    var address = String()
    var port: UInt16?
    var ID = String()
    var alterid = String()
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
