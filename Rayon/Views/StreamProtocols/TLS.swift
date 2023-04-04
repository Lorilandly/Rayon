//
//  tls.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/16.
//

import SwiftUI

struct TLS: View {
    @Binding var tlsSettings: TlsObject
    var body: some View {
        Form {
            Toggle(isOn: $tlsSettings.allowInsecure ?? false) {
                Text("Allow Insecure")
            }
            Toggle(isOn: $tlsSettings.disableSystemRoot ?? false) {
                Text("Disable System Root")
            }
            Picker(selection: $tlsSettings.fingerprint, label: Text("Fingerprint:")) {
                Text("None").tag(nil as TlsObject.Fingerprint?)
                ForEach(TlsObject.Fingerprint.allCases, id: \.self) { fingerprint in
                    Text(fingerprint.name)
                        .tag(fingerprint as TlsObject.Fingerprint?)
                }
            }
        }
        .frame(width: 300)
    }
}

struct TLS_Previews: PreviewProvider {
    static var previews: some View {
        TLS(tlsSettings: .constant(TlsObject()))
    }
}
