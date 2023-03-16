//
//  ConnectionSetting.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ProxySettingsView: View {
    @State private var protocol_config_vless = VlessSettingsObject()
    @State private var protocol_config_vmess = VmessSettingsObject()
    @Binding var proxyProtocol: Proxy
    @Binding var settings: ProxySettings
    
    var body: some View {
        VStack {
            HStack {
                Text("Connection Settings")
                    .font(.headline)
                Spacer()
                Picker("Protocol", selection: $proxyProtocol) {
                    ForEach(Proxy.allCases) { proxyProtocol in
                        Text(proxyProtocol.rawValue.capitalized)
                    }
                }
                .frame(width: 170.0)
            }
            GroupBox {
                switch proxyProtocol {
                case .vless:
                    VLESS(protocol_config: $protocol_config_vless)
                case .vmess:
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
        ProxySettingsView(proxyProtocol: .constant(Proxy.vless), settings: .constant(VlessSettingsObject()))
    }
}
