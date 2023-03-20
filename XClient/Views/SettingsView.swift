//
//  SettingsView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/17.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, server, routing, share
    }
    var body: some View {
        TabView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).frame(width: 200, height: 200).tabItem{Label("General", systemImage: "gear")}.tag(Tabs.server)
            ServerView().frame(width: 600, height: 400).tabItem{Label("Server", systemImage: "paperplane.circle")}.tag(Tabs.server)

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
