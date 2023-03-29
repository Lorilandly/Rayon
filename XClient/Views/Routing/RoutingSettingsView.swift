//
//  RoutingSettingsView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/28.
//

import SwiftUI

struct RoutingSettingsView: View {
    private let tabs = [
        TabItem(title: "Block", explain: "explain block"),
        TabItem(title: "Direct", explain: "explain direct"),
        TabItem(title: "Proxy", explain: "explain proxy"),
        ]
    
    var body: some View {
        VStack(alignment: .leading) {
            TabView {
                ForEach(tabs) { tab in
                    VStack(alignment: .leading) {
                        RoutingTable()
                            .tableStyle(.inset)
                        
                        tab.explain
                            .padding([.leading, .bottom], 3.0)
                            .font(.footnote)
                    }
                    .tabItem {tab.title}
                }
            }
            .tabViewStyle(.automatic)
        }
    }
}

private struct TabItem: Identifiable {
    let id = UUID()
    let title: Text
    let explain: Label<Text, Image>
    
    init(title: String, explain: String) {
        self.title = Text(NSLocalizedString(title, comment: title))
        self.explain = Label(NSLocalizedString(explain, comment: explain), systemImage: "info.circle")
    }
}

struct RoutingSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingSettingsView()
    }
}
