import Foundation
import SwiftUI
import SettingsAccess

class AppMenu: NSObject {
    private let windowManager = WindowManager.shared

    let menu = NSMenu()
    
    func createMenu() -> NSMenu {
        let viewMain = Main.shared.contentView.openSettingsAccess()
        let topView = NSHostingController(rootView: viewMain)
        topView.view.frame.size = CGSize(width: 225, height: 150)
     
        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view

        menu.addItem(customMenuItem)
        menu.addItem(NSMenuItem.separator())

        let settingsMenuItem = NSMenuItem(title: "Settings",
                                                  action: #selector(settings),
                                                  keyEquivalent: "u")
        settingsMenuItem.target = self
        menu.addItem(settingsMenuItem)

        let quitMenuItem = NSMenuItem(title: "Quit",
                                                  action: #selector(quit),
                                                  keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        
        return menu
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }

    @objc func settings(sender: NSMenuItem) {
        NSApplication.shared.activate(ignoringOtherApps: true)
        try? Main.shared.contentView.openSettings()
    }

    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
