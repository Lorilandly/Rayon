//
//  TCP.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct TCP: View {
    var body: some View {
        Form {
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("HTTP Header")
            }
            TextField("Host:", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            TextField("Path:", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TCP_Previews: PreviewProvider {
    static var previews: some View {
        TCP()
    }
}
