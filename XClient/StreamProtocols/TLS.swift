//
//  TLS.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import SwiftUI

struct TLS: View {
    var body: some View {
        Form {
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("Allow Insecure")
            }
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("Disable System Root")
            }
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Fingerprint:")) {
                Text("random").tag(1)
                /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct TLS_Previews: PreviewProvider {
    static var previews: some View {
        TLS()
    }
}
