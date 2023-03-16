//
//  ConnectionSetting.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ProxySettingsView: View {
    enum OutboundProtocol: String, CaseIterable, Identifiable {
        // these should be obtained from somewhere else instead of hard coded
        case Vmess, VLESS, Trojan, ShadowSocks, Socks, HTTP
        var id: Self { self }
    }
    @State private var selected_protocol: OutboundProtocol = .VLESS
    @State private var protocol_config_vless = OutboundVLESSConfig()
    @State private var protocol_config_vmess = OutboundVmessConfig()
    
    var body: some View {
        VStack {
            HStack {
                Text("Connection Settings")
                    .font(.headline)
                Spacer()
                Picker("Protocol", selection: $selected_protocol) {
                    ForEach(OutboundProtocol.allCases) {
                        a_protocol in Text(a_protocol.rawValue.capitalized)
                    }
                }
                .frame(width: 170.0)
            }
            GroupBox {
                switch selected_protocol {
                    case .VLESS:
                        VLESS(protocol_config: $protocol_config_vless)
                case .Vmess:
                    Vmess(protocol_config: $protocol_config_vmess)
                default:
                    Text("not implemented")
                }
            }
        }
    }
}

struct ConnectionSetting_Previews: PreviewProvider {
    static var previews: some View {
        ProxySettingsView()
    }
}
