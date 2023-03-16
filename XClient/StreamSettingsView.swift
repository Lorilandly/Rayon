//
//  StreamSettings.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import SwiftUI

struct StreamSettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Stream Settings").font(.headline)
                Spacer()
                Picker("Network", selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                    Text("TCP").tag(1)
                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                }.frame(width: 120)
                Picker("Security", selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                    Text("TLS").tag(1)
                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                }.frame(width: 120)
            }
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                TCP().padding(.horizontal).tabItem { Text("Network") }.tag(1)
                TLS().padding(.horizontal).tabItem { Text("Security") }.tag(2)
            }
            .frame(height: 120)
        }
    }
}

struct StreamSettings_Previews: PreviewProvider {
    static var previews: some View {
        StreamSettingsView()
    }
}
