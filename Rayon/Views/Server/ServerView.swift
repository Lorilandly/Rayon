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
    @State private var selectedIndex: Int? = nil
    var body: some View {
        HStack(spacing: 20) {
            ServerListView(serverList: $serverList, selectedIndex: $selectedIndex)
                .frame(minHeight: 200)
            
            if selectedIndex != nil {
                ServerSettingsView(server: $serverList[selectedIndex!])
            } else {
                Spacer()
                Text("select server")
                Spacer()
            }
        }
        .padding()
    }
}

struct ServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerView(serverList: outboundExample)
    }
}
