//
//  ContentView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ServerView: View {
    @StateObject private var store = Store()
    @State var serverList: [OutboundObject] = outboundExample
    // TODO: take this index from currently applied server
    @State private var selectedServer: OutboundObject? = nil
    var body: some View {
        HStack {
            ServerListView(serverList: $serverList, selectedServer: $selectedServer)
            
            //ServerSettingsView(server: $selectedServer)
            
            if let server = Binding<OutboundObject>($selectedServer) {
                ServerSettingsView(server: server)
            } else {
                //ServerSettingsView(server: Binding(outboundExample[0]))
                Text("select a server")
            }
        }
        .padding()
        .onAppear {
            //updateSelected()
        }
    }
    /*
    func updateSelected() {
        if let idx = selectedServerIndex {
            selectedServer = serverList[idx]
        } else {
            selectedServer = OutboundObject(tag: "New Server", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())
        }
    }
     */
}

struct ServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerView(serverList: outboundExample)
    }
}
