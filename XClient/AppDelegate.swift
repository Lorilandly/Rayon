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
                    systemSymbolName: "paperplane.circle",
                    accessibilityDescription: "an app"
                )
                
                let groupMenuItem = NSMenuItem()
                groupMenuItem.title = "Group"
                
                let groupDetailsMenuItem = NSMenuItem()
                groupDetailsMenuItem.view = mainView
                
                let groupSubmenu = NSMenu()
                groupSubmenu.addItem(groupDetailsMenuItem)
                
                let secondMenuItem = NSMenuItem()
                secondMenuItem.title = "Another item"
                
                let secondSubMenuItem = NSMenuItem()
                secondSubMenuItem.title = "SubItem"
                secondSubMenuItem.target = self
                secondSubMenuItem.action = #selector(Self.onItemClick(_:))
                
                let secondSubMenu = NSMenu()
                secondSubMenu.addItem(secondSubMenuItem)
                
                let rootItem = NSMenuItem()
                rootItem.title = "Preferences..."
                rootItem.target = self
                rootItem.action = #selector(Self.rootAction(_:))
                
                let mainMenu = NSMenu()
                mainMenu.addItem(groupMenuItem)
                mainMenu.setSubmenu(groupSubmenu, for: groupMenuItem)
                mainMenu.addItem(secondMenuItem)
                mainMenu.setSubmenu(secondSubMenu, for: secondMenuItem)
                mainMenu.addItem(rootItem)
                
                statusItem.menu = mainMenu
            }
        }
        
        // MARK: - Actions
        
        @objc private func onItemClick(_ sender: Any?) {
            print("Hi from action")
        }
        
        @objc private func rootAction(_ sender: Any?) {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
    }
    
    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuExtrasConfigurator = .init()
    }
}
