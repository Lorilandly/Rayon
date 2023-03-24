//
//  AppDelegate.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/23.
//

import Foundation
import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var menuExtrasConfigurator: MacExtrasConfigurator?
    
    final private class MacExtrasConfigurator: NSObject {
        
        private var statusBar: NSStatusBar
        private var statusItem: NSStatusItem
        private var mainView: NSView
        
        private struct MenuView: View {
            var body: some View {
                HStack {
                    Text("Hello from SwiftUI View")
                    Spacer()
                }
                .background(Color.blue)
                .padding()
            }
        }
        
        // MARK: - Lifecycle
        
        override init() {
            statusBar = NSStatusBar.system
            statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
            mainView = NSHostingView(rootView: MenuView())
            mainView.frame = NSRect(x: 0, y: 0, width: 300, height: 250)
            
            super.init()
            
            createMenu()
            
            //
        }
        
        // MARK: - Private
        
        // MARK: - MenuConfig
        
        private func createMenu() {
            if let statusBarButton = statusItem.button {
                statusBarButton.image = NSImage(
                    systemSymbolName: "paperplane",
                    accessibilityDescription: "an app"
                )
                
                let serverMenuGroup = NSMenuItem()
                serverMenuGroup.title = "Servers"
                
                let groupDetailsMenuItem = NSMenuItem()
                groupDetailsMenuItem.view = mainView
                
                let groupSubmenu = NSMenu()
                groupSubmenu.addItem(groupDetailsMenuItem)
                
                let routingMenuGroup = NSMenuItem()
                routingMenuGroup.title = "Routings"
                
                let secondSubMenuItem = NSMenuItem()
                secondSubMenuItem.title = "SubItem"
                secondSubMenuItem.target = self
                secondSubMenuItem.action = #selector(Self.onItemClick(_:))
                
                let secondSubMenu = NSMenu()
                secondSubMenu.addItem(secondSubMenuItem)
                
                let preferenceItem = NSMenuItem()
                preferenceItem.title = "Preferences..."
                preferenceItem.target = self
                preferenceItem.action = #selector(Self.preferenceAction(_:))
                
                let quitItem = NSMenuItem()
                quitItem.title = "Quit"
                quitItem.target = self
                quitItem.action = #selector(Self.quitAction(_:))
                
                let mainMenu = NSMenu()
                mainMenu.addItem(serverMenuGroup)
                mainMenu.setSubmenu(groupSubmenu, for: serverMenuGroup)
                mainMenu.addItem(routingMenuGroup)
                mainMenu.setSubmenu(secondSubMenu, for: routingMenuGroup)
                mainMenu.addItem(preferenceItem)
                mainMenu.addItem(quitItem)
                
                statusItem.menu = mainMenu
            }
        }
        
        // MARK: - Actions
        
        @objc private func onItemClick(_ sender: Any?) {
            print("Hi from action")
        }
        
        @objc private func preferenceAction(_ sender: Any?) {
            if #available(macOS 13, *) {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            } else {
                NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
            }
        }
        @objc private func quitAction(_ sender: Any?) {
            NSApp.terminate(nil)
        }
    }
    
    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuExtrasConfigurator = .init()
            
        /*
         * TODO:
         * desired behavior: show app icon when any window is showed.
         * issue: app icon can't be hidden when windows are closed.
         * current solution: just make window show up on top, do not do anything else.
        let settingsView = SettingsView()
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView: settingsView)
        window.delegate = settingsView.settingsWindowDelegate
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.makeKeyAndOrderFront(nil)
         */
    }
}

extension NSApplication {
    
    static func show(ignoringOtherApps: Bool = true) {
        //NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: ignoringOtherApps)
    }
    
    /*
    static func hide() {
        NSApp.hide(self)
        NSApp.setActivationPolicy(.accessory)
    }
     */
}
