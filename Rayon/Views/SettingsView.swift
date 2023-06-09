//
//  SettingsView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/17.
//

import SwiftUI

struct SettingsView: View {
    @State var tab = Tabs.server
    enum Tabs: Hashable {
        case general, server, routing, share
    }
    var body: some View {
        TabView(selection: $tab) {
            GeneralView().tabItem{Label("General", systemImage: "gear")}.tag(Tabs.general)
            ServerView().tabItem{Label("Server", systemImage: "paperplane.circle")}.tag(Tabs.server)
            RoutingView().tabItem{Label("Routing", systemImage: "point.topleft.down.curvedto.point.bottomright.up")}.tag(Tabs.routing)
        }
        .frame(width: 600)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
