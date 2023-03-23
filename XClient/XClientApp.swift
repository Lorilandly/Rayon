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
 *
 * TODO
 * 1. multilanguage support
 * 2. run as agent -> WIP
 * 3. use swiftui for menu item (maybe after I finally decide to upgrade to macos 13)
 */

import SwiftUI

@main
struct XClientApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        /*
        WindowGroup {
            ContentView()
        }
         */
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
        //MenuBarExtra("Rayon", systemImage: "gear") {}
    }
}
