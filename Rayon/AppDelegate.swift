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
        
        private var statusItem: NSStatusItem
        
        // MARK: - Lifecycle
        
        override init() {
            statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
            
            super.init()
            
            createMenu()
        }
        
        // MARK: - Private
        
        // MARK: - MenuConfig
        
        private func createMenu() {
            if let statusBarButton = statusItem.button {
                statusBarButton.image = NSImage(
                    systemSymbolName: "paperplane",
                    accessibilityDescription: "an app"
                )
                
                let toggleXrayItem = NSMenuItem(title: "Turn on", action: #selector(onOffAction(_:)), keyEquivalent: "")
                toggleXrayItem.target = self
                
                let serverMenu = NSMenuItem(title: "Servers", action: nil, keyEquivalent: "")
                
                let serverSubmenu = NSMenu()
                serverMenu.submenu = serverSubmenu
                
                for server in outboundExample {
                    let serverMenuItem = NSMenuItem(title: server.tag, action: nil, keyEquivalent: "")
                    serverMenuItem.target = self
                    serverSubmenu.addItem(serverMenuItem)
                }
                serverSubmenu.addItem(NSMenuItem.separator())
                let serverConfigMenuItem = NSMenuItem(title: "Edit...", action: nil, keyEquivalent: "")
                serverConfigMenuItem.target = self
                serverSubmenu.addItem(serverConfigMenuItem)
                
                let routingMenu = NSMenuItem(title: "Routings", action: nil, keyEquivalent: "")
                
                let routingSubmenu = NSMenu()
                routingMenu.submenu = routingSubmenu

                let routingMenuItem = NSMenuItem(title: "SubItem", action: #selector(exampleAction(_:)), keyEquivalent: "")
                routingMenuItem.target = self
                routingSubmenu.addItem(routingMenuItem)
                
                let preferenceItem = NSMenuItem(title: "Preferences...", action: #selector(preferenceAction(_:)), keyEquivalent: ",")
                preferenceItem.target = self
                
                let quitItem = NSMenuItem(title: "Quit", action: #selector(quitAction(_:)), keyEquivalent: "q")
                quitItem.target = self
                
                let mainMenu = NSMenu()
                mainMenu.addItem(toggleXrayItem)
                mainMenu.addItem(NSMenuItem.separator())
                mainMenu.addItem(serverMenu)
                mainMenu.addItem(routingMenu)
                mainMenu.addItem(NSMenuItem.separator())
                mainMenu.addItem(preferenceItem)
                mainMenu.addItem(quitItem)
                
                statusItem.menu = mainMenu
            }
        }
        
        // MARK: - Actions
        
        @objc private func exampleAction(_ sender: Any?) {
            print("Hi from action")
        }
        
        @objc private func onOffAction(_ sender: Any?) {
            statusItem.button?.image = NSImage(
                systemSymbolName: "paperplane.fill",
                accessibilityDescription: "an app"
            )
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
