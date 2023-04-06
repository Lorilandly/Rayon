//
//  Vmess.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct Vmess: View {
    @Binding var protocol_config: VmessSettingsObject
    let leading_text_width: CGFloat = 55
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Address:")
                    .frame(width: leading_text_width, alignment: .trailing)
                TextField("hostname, IPv4, or IPv6", text: $protocol_config.address)
                Text(":")
                TextField("port", value: $protocol_config.port, format: .number)
                    .frame(width: 120)
            }
            HStack {
                Text("ID:")
                    .frame(width: leading_text_width, alignment: .trailing)
                TextField("placeholder", text: $protocol_config.id)
            //}
            //HStack {
                Text("AlterID:")
                    .frame(width: leading_text_width, alignment: .trailing)
                // this should use drop down
                TextField("0", value: $protocol_config.alterid, format: .number)
                    .frame(width: 70)
            }
        }
    }
}

struct Vmess_Previews: PreviewProvider {
    static var previews: some View {
        Vmess(protocol_config: .constant(VmessSettingsObject()))
    }
}
