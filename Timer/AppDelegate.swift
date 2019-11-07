//
//  AppDelegate.swift
//  Timer
//
//  Created by Thomas Maier on 24.10.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Components:
    let statusbarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var panRecognizer = NSPanGestureRecognizer(target: self, action: #selector(setTimer(_:)))
    var wc : WC? = nil
    var Timer : TimerController = TimerController()
    
    // Attributes:
    let statusBarHeight : Int = 22
    let windowSize : Int = 40
    
    let timeSteps : Int = 120 // 2h a 60 Min
    
    let minHeight : Int = 100
    let heightLimiter : Int = 100
    let adjustment : Int = 4
    
    // ===================================================================
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Setup Menu
        statusbarItem.menu = constructMenu()
        
        // Setup StatusBar Item Button
        if let button = statusbarItem.button {
            button.image = NSImage(named:NSImage.Name("clock"))
            
            // Configure Events
            button.target = self
            button.addGestureRecognizer(panRecognizer)
            
            // Initialize Button for Timer
            Timer.initialize(statusBarButton: button, statusBarMenu: statusbarItem.menu!)
        }
        
        // Window Setup
        let sb = NSStoryboard(name: "Main", bundle: nil)
        wc = sb.instantiateController(withIdentifier: "Classic") as? WC;
        
        // Starting App
        print("Starting App...")
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        Timer.stop()
    }
    
    
    // ===================================================================
    @objc func setTimer(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        let position : NSPoint = NSEvent.mouseLocation
        
        if(event.type == NSEvent.EventType.leftMouseUp) {
            let minutes : Int = yToMinutes(y: position.y)
            if(minutes > 0) {
                self.Timer.start(minutes: yToMinutes(y: position.y))
            }
            
            // Close Window
            wc?.close()
        } else if (event.type == NSEvent.EventType.leftMouseDragged) {
            // If hidden then Show Window
            if(!(wc?.window!.isVisible)!) {
                wc?.showWindow(self)
            }
            
            // Update Window
            updateWindow(point: position)
        }
    }
    
    // ===================================================================
    func constructMenu() -> NSMenu {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Stoppen", action: #selector(stopTimer), keyEquivalent: "x"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Beenden", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        menu.items[0].isHidden = true
        
        return menu
    }
    
    @objc func stopTimer() {
        self.Timer.stop()
    }
    
    // ===================================================================
    func getScreenHeight() -> Int {
        return Int(NSScreen.deepest!.frame.height) - statusBarHeight
    }
    
    func yToHeight(y: CGFloat) -> Int {
        let screenHeight = getScreenHeight()
        var height : Int = screenHeight + statusBarHeight - Int(y)
        
        if (height > (screenHeight - heightLimiter)) {
            height = screenHeight - heightLimiter
        }
        return height
    }
    
    func yToMinutes(y: CGFloat) -> Int {
        let screenHeight : Int = getScreenHeight()
        var height : Int = screenHeight + statusBarHeight - Int(y) - minHeight
        if(height > screenHeight + statusBarHeight - minHeight - heightLimiter) {
            height = screenHeight + statusBarHeight - heightLimiter - minHeight
        }
        
        var minutes = Int(CGFloat(height) / CGFloat(screenHeight - heightLimiter - minHeight) * CGFloat(timeSteps))
        if(minutes > 120) {minutes = 120}
        else if(minutes < 0) {minutes = 0}
        
        return minutes
    }
    
    func updateWindow(point: NSPoint) -> Void {
        // Adjust Window Size
        let height : Int = yToHeight(y: point.y)
        if let button = statusbarItem.button {
            let buttonLocationX : CGFloat = button.window!.frame.origin.x
            let x : Int = Int(buttonLocationX - ((CGFloat(windowSize) - button.frame.width) / 2))
            let y : Int = getScreenHeight() - height + adjustment
            wc?.window?.setFrame(NSRect(x: x, y: y, width: windowSize, height: height), display: true)
            
            // Update Popover Text
            wc?.update(minutes: yToMinutes(y: point.y), height: height)
        }
    }
}

