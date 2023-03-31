//
//  RayonApp.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/15.
//


/*
 * Current issues:
 * 1. outbound object needs to implement equatable properly. currently `any` is stopping this
 * 2. in server pane, pressing save unselects row
 * 3. from the second time preference is pressed in the menu, preference pane appear in background
 * 4. index out of range when removing server
 *
 * TODO
 * 1. Check server configuration correctness
 * 2. Routing save button/model
 * 3. Backend
 * 4. Menu
 * 5. use swiftui for menu item (maybe after I finally decide to upgrade to macos 13)
 
 focused binding
 */

import SwiftUI

@main
struct RayonApp: App {
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
