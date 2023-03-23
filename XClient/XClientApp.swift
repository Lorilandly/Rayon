//
//  XClientApp.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//


/*
 * Current issues:
 * 1. outbound object needs to implement equatable properly. currently `any` is stopping this
 * 2. unselecting row in list cases crash
 * 3. pressing save unselects row, and saving is not updated to the row
 * 4. 
 */

import SwiftUI

@main
struct XClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
