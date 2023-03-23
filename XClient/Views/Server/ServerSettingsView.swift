//
//  ServerSettingsView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import SwiftUI

struct ServerSettingsView: View {
    @Binding var server: OutboundObject
    @State var serverData: OutboundObject.Data
    
    init(server: Binding<OutboundObject>) {
        _server = server
        _serverData = State(initialValue: server.wrappedValue.data)
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            ProxySettingsView(proxyProtocol: $serverData.proxyProtocol, settings: $serverData.allProxySettings)
            StreamSettingsView(streamSettings: $serverData.streamSettings)
            HStack {
                Spacer()
                Button("Save") {
                    // when save is pressed, new object is generated instead of changing the original
                    print(server.streamSettings.network)
                    print(serverData.streamSettings.network)
                    server.update(from: serverData)
                    print(server.streamSettings.network)
                    print(serverData.streamSettings.network)
                }
                .buttonStyle(.borderedProminent)
                Button("Cancel") {
                    //serverData = server.data
                    flush()
                }
                .buttonStyle(.bordered)
            }
        }
        /*
        .onChange(of: server) { newServer in
            //serverData = newServer.data
            flush()
        }
        .onAppear{
            flush()
        }
         */
    }
    
    func save(){
        //server?.update(from: serverData)
    }
    func flush(){
        serverData = server.data
    }
}

struct ServerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ServerSettingsView(server: .constant(OutboundObject(tag: "server1", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())))
    }
}
