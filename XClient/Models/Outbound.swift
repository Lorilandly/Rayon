//
//  Outbound.swift
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

struct Outbound {
    var tag: String
    var sendThrough: IPAddress?
    var proxySettings: ProxySettings
    var streamSettings: StreamSettings
    
    init(tag: String, sendThrough: IPAddress? = nil, proxySettings: ProxySettings, streamSettings: StreamSettings) {
        self.tag = tag
        self.sendThrough = sendThrough
        self.proxySettings = proxySettings
        self.streamSettings = streamSettings
    }
}

extension Outbound {
    struct Data {
        var tag: String = "New Server"
        var sendThrough: IPAddress? = IPv4Address("0.0.0.0")
        var proxySettings: ProxySettings = ProxySettings.VLESS(VLESSConfig())
        var streamSettings: StreamSettings = StreamSettings()
    }
    
    var data: Data {
        Data(tag: tag, sendThrough: sendThrough, proxySettings: proxySettings, streamSettings: streamSettings)
    }
}

enum ProxySettings {
    case VLESS(VLESSConfig)
    case Vmess(VmessConfig)
}

struct VLESSConfig {
    var address: String = ""
    var port: UInt16?
    var ID: String = ""
    var encryption: String = ""
    var flow: String = ""
    
    init(address: String = String(), port: UInt16? = nil, ID: String = String(), encryption: String = String(), flow: String = String()) {
        self.address = address
        self.port = port
        self.ID = ID
        self.encryption = encryption
        self.flow = flow
    }
}

struct VmessConfig {
    var address = String()
    var port: UInt16?
    var ID = String()
    var alterid = String()
}

struct StreamSettings {
    var network: NetworkSettings = NetworkSettings.TCP
    var security: SecuritySettings = SecuritySettings.TLS
}

enum NetworkSettings {
    case TCP
}
enum SecuritySettings {
    case TLS
}
