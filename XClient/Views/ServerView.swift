//
//  ContentView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ServerView: View {
    @State private var outbound = OutboundObject.Data()
    var body: some View {
        HStack {
            List(outboundExample, id: \.tag) { outboundObject in
                Text(outboundObject.tag)
            }
            .navigationTitle("Servers:")
            .listStyle(.bordered(alternatesRowBackgrounds: true))
            .moveDisabled(false)
            .frame(width: 100.0)
            .padding()
            //.toolbar()
            //.environment(\.editMode, EditMode.active)
            
            
            
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

struct ServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerView()
    }
}
