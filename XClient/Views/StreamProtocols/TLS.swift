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
            Toggle(isOn: $tlsSettings.allowInsecure) {
                Text("Allow Insecure")
            }
            Toggle(isOn: $tlsSettings.disableSystemRoot) {
                Text("Disable System Root")
            }
            Picker(selection: $tlsSettings.fingerprint, label: Text("Fingerprint:")) {
                ForEach(TlsFingerprint.allCases, id: \.self) { fingerprint in
                    Text(fingerprint.name)
                }
            }
            .frame(width: 200)
        }
    }
}

struct TLS_Previews: PreviewProvider {
    static var previews: some View {
        TLS(tlsSettings: .constant(TlsObject()))
    }
}
