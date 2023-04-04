//
//  tcp.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct TCP: View {
    @Binding var tcpSettings: TcpObject
    var body: some View {
        Form {
            Toggle(isOn: $tcpSettings.http ?? false) {
                Text("HTTP Header")
            }
            TextField("Host:", text: $tcpSettings.host ?? "")
                .disabled(tcpSettings.http ?? false)
            TextField("Path:", text: $tcpSettings.path ?? "")
                .disabled(tcpSettings.http ?? false)
        }
        .frame(width: 300)
    }
}

struct TCP_Previews: PreviewProvider {
    static var previews: some View {
        TCP(tcpSettings: .constant(TcpObject()))
    }
}
