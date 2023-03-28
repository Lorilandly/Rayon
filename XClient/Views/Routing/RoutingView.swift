//
//  Routing.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/22.
//

import SwiftUI

struct RoutingView: View {
    // @State routingList:
    // @State selectedRoute
    var body: some View {
        HStack(spacing: 20) {
            // routing rules list
            RoutingListView()
            // routing rule setting
            RoutingSettingsView()
        }
        .padding()
    }
}

struct RoutingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingView()
    }
}
