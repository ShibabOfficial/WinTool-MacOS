import Foundation
import Cocoa
import SwiftUI

class SnapOverlay: NSWindow {
    var view = NSBox()
    
    init() {
        super.init(contentRect: NSRect(x: 0, y: 0, width: 0, height: 0), styleMask: .titled, backing: .buffered, defer: false)
        title = Main.shared.appName + "Overlay"
        level = .modalPanel
        
        isOpaque = false
        styleMask.insert(.fullSizeContentView)
        alphaValue = 0
        
        isReleasedWhenClosed = false
        ignoresMouseEvents = true
        hasShadow = false
        collectionBehavior.insert(.transient)
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
        standardWindowButton(.toolbarButton)?.isHidden = true
        
        view.boxType = .custom
        updateSettings()
        view.wantsLayer = true
        contentView = view
    }
    
    override func orderFront(_ sender: Any?) {
        super.orderFront(sender)
        animator().alphaValue = SettingsManager.shared.overlayAlpha.value / 100
    }
    
    override func orderOut(_ sender: Any?) {
        NSAnimationContext.runAnimationGroup { change in
            animator().alphaValue = 0.0
        } completionHandler: {
            super.orderOut(sender)
        }
    }
    
    func updateSettings() {
        alphaValue = SettingsManager.shared.overlayAlpha.value
        view.fillColor = NSColor(Color(rgb: SettingsManager.shared.overlayBackgroundColor.value, a: 1))
        view.borderColor = NSColor(Color(rgb: SettingsManager.shared.overlayBorderColor.value, a: 1))
        view.cornerRadius = SettingsManager.shared.overlayCornerRadius.value
    }
}
