//
//  GeneralView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/24.
//

import SwiftUI

struct GeneralView: View {
    @AppStorage("General.mode")
    private var mode: Mode = .simple
    
    enum Mode: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case simple
        case advanced
    }
    
    var body: some View {
        Form {
            Picker("Mode:", selection: $mode) {
                ForEach(Mode.allCases) { mode in
                    Text(mode.rawValue.capitalized)
                }
            }
            .pickerStyle(.inline)
            .padding()
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
