//
//  XClientApp.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//


/*
 * Current issues:
 * 1. outbound object needs to implement equatable properly. currently `any` is stopping this
 * 2. in server pane, pressing save unselects row
 * 3. from the second time preference is pressed in the menu, preference pane appear in background
 *
 * TODO
 * 1. multilanguage support
 * 2. use swiftui for menu item (maybe after I finally decide to upgrade to macos 13)
 
 focused binding
 */

import SwiftUI

@main
struct XClientApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        /*
        WindowGroup {
            ContentView()
        }
         */
        #if os(macOS)
        Settings {
            SettingsView()
                .onAppear {
                    NSApplication.show()
                }
        }
        #endif
        //MenuBarExtra("Rayon", systemImage: "gear") {}
    }
}
