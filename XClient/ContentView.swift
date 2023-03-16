//
//  ContentView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct ContentView: View {
    @State var outboundobj = Outbound.Data()
    var body: some View {
        HStack {
            List {}
                .frame(width: 100.0)
            VStack(spacing: 20) {
                ProxySettingsView()
                StreamSettingsView()
                
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(outboundobj: Outbound.Data())
    }
}
