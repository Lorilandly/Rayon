//
//  ContentView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ServerView: View {
    @State private var serverList = outboundExample
    // TODO: take this index from currently applied server
    @State private var selectedServerIndex: Int? = 0
    @State private var selectedServer = OutboundObject(tag: "", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())
    var body: some View {
        HStack {
            ServerListView(serverList: $serverList, selectedServerIndex: $selectedServerIndex)
                .onChange(of: selectedServerIndex) { _ in
                    updateSelected()
                }
            
            ServerSettingsView(server: $selectedServer, serverData: selectedServer.data)
        }
        .padding()
        .onAppear {
            updateSelected()
        }
    }
    func updateSelected() {
        if let idx = selectedServerIndex {
            selectedServer = serverList[idx]
        } else {
            selectedServer = OutboundObject(tag: "New Server", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())
        }
    }
}

struct ServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerView()
    }
}
