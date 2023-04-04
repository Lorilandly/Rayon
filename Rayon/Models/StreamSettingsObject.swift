//
//  StreamSettingsObject.swift
//  Rayon
//
//  Created by 李浩安 on 2023/4/4.
//

import Foundation

struct StreamSettingsObject: Hashable, Codable {
    var network: StreamNetwork = .tcp
    var tcpSettings: TcpObject = TcpObject()
    // add more settings
    
    var security: Security = .none
    var tlsSettings: TlsObject = TlsObject()
    // add more settings
}

enum StreamNetwork: String, CaseIterable, Identifiable, Codable {
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

struct TcpObject: Hashable, Codable {
    // TODO: make json generation match xray conf
    var acceptProxyProtocol: Bool?
    var http: Bool?
    var host: String?
    var path: String?
}

enum Security: String, CaseIterable, Identifiable, Codable {
    case none
    case tls
    case reality
    
    var id: Self { self }
    var name: String {
        rawValue.uppercased()
    }
}

struct TlsObject: Hashable, Codable {
    enum Fingerprint: String, CaseIterable, Codable {
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
    
    var allowInsecure: Bool?
    var disableSystemRoot: Bool?
    var fingerprint: Fingerprint?
}
