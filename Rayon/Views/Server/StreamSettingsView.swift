//
//  StreamSettings.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import SwiftUI

struct StreamSettingsView: View {
    @Binding var streamSettings: StreamSettingsObject
    @State private var selectedStreamMenu = 0
    var body: some View {
        VStack {
            HStack {
                Text("Stream Settings").font(.headline)
                Spacer()
                Picker("Network", selection: $streamSettings.network) {
                    ForEach(StreamNetwork.allCases) {network in
                        Text(network.name)
                    }
                }.frame(width: 125)
                Picker("Security", selection: $streamSettings.security) {
                    ForEach(Security.allCases) { security in
                        Text(security.name)
                    }
                }.frame(width: 140)
            }
            TabView(selection: $selectedStreamMenu) {
                networkView().padding(.horizontal).tabItem { Text("Network") }.tag(0)
                securityView().padding(.horizontal).tabItem { Text("Security") }.tag(1)
            }
            .tabViewStyle(.automatic)
            .frame(height: 120)
        }
        .onChange(of: streamSettings.network) { _ in
            selectedStreamMenu = 0
        }
        .onChange(of: streamSettings.security) { _ in
            selectedStreamMenu = 1
        }
    }
    
    @ViewBuilder
    func networkView() -> some View {
        switch streamSettings.network {
        case .tcp:
            TCP(tcpSettings: $streamSettings.tcpSettings)
        default:
            Text("Not implemented")
        }
    }
    
    @ViewBuilder
    func securityView() -> some View {
        switch streamSettings.security {
        case .tls:
            TLS(tlsSettings: $streamSettings.tlsSettings)
        default:
            Text("Not implemented")
        }
    }
}

struct StreamSettings_Previews: PreviewProvider {
    static var previews: some View {
        StreamSettingsView(streamSettings: .constant(StreamSettingsObject()))
    }
}
