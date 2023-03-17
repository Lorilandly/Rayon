//
//  ContentView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ContentView: View {
    @State private var outbound = OutboundObject.Data()
    var body: some View {
        HStack {
            List {}
                .frame(width: 100.0)
            VStack(spacing: 20) {
                ProxySettingsView(proxyProtocol: $outbound.proxyProtocol, settings: $outbound.allProxySettings)
                StreamSettingsView(streamSettings: $outbound.streamSettings)
                HStack {
                    Spacer()
                    Button("Save") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Cancel") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}