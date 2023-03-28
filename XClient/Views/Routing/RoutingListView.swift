//
//  RoutingListView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/28.
//

import SwiftUI

struct RoutingListView: View {
    var body: some View {
        List() {
        }
        .listStyle(.bordered(alternatesRowBackgrounds: true))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button{} label: {
                    Image(systemName: "plus")
                }
                Button{} label: {
                    Image(systemName: "square.on.square")
                }
                Spacer()
            }
            .buttonStyle(.plain)
            .padding(5)
            .background(.background)
            .border(.tertiary)
        }
        .frame(width: 100)
    }
}

struct RoutingListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingListView()
    }
}
