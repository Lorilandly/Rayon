//
//  RoutingSettingsView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/28.
//

import SwiftUI

struct RoutingSettingsView: View {
    struct User: Identifiable {
        let id: Int
        var name: String
        var score: Int
    }
    private var users = [
            User(id: 1, name: "Taylor Swift", score: 95),
            User(id: 2, name: "Justin Bieber", score: 80),
            User(id: 3, name: "Adele Adkins", score: 85)
            ]
    var table: some View {
        Table(users) {
            TableColumn("name", value: \.name)
        }
    }
    
    var body: some View {
        TabView {
            table.tabItem{Text("Block")}
            Text("2").tabItem{Text("Direct")}
            Text("3").tabItem{Text("Proxy")}
        }
        .tabViewStyle(.automatic)
    }
}

struct RoutingSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingSettingsView()
    }
}
