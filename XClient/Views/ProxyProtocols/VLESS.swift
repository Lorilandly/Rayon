//
//  VLESS.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//

import SwiftUI

struct VLESS: View {
    @Binding var protocol_config: VlessSettingsObject
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
                TextField("placeholder", text: $protocol_config.ID)
            }
            HStack {
                Text("Flow:")
                    .frame(width: leading_text_width, alignment: .trailing)
                // this should use drop down
                TextField("flow", text: $protocol_config.flow)
                Text("Decryption:")
                // this should use drop down
                TextField("security", text: $protocol_config.encryption)
            }
        }
        //.fixedSize(horizontal: false, vertical: true)
    }
}

struct VLESS_Previews: PreviewProvider {
    static var previews: some View {
        VLESS(protocol_config: .constant(VlessSettingsObject()))
    }
}
