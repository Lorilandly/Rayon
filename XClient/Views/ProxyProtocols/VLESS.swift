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
                // TODO: this overflows when the given number is too big
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
                Picker("Flow:", selection: $protocol_config.flow) {
                    ForEach(VlessFlow.allCases) { flow in
                        Text(flow.rawValue)
                    }
                }
                .labelsHidden()
                Picker("Encryption:", selection: $protocol_config.encryption) {
                    ForEach(VlessEncryption.allCases) { option in
                        Text(option.rawValue)
                    }
                }
            }
        }
    }
}

struct VLESS_Previews: PreviewProvider {
    static var previews: some View {
        VLESS(protocol_config: .constant(VlessSettingsObject()))
    }
}
