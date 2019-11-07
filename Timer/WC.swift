//
//  CustomWindowController.swift
//  Test
//
//  Created by Thomas Maier on 25.10.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

class WC: NSWindowController {
    
    // Components:
    var popover : NSPopover = NSPopover()
    
    // Attributes:
    var size : Int = 0
    var isVisible : Bool = false
    
    // ===================================================================
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Setup Popover
        setupPopover()
        
        // Setup Window
        self.window?.isOpaque = false
        self.window?.backgroundColor  = NSColor(calibratedRed: 255, green: 0, blue: 0, alpha: 0)
        self.window?.setAccessibilityModal(true)
        self.window?.level = .statusBar
        
        self.window?.setFrame(NSRect(x: 0, y: 0, width: size , height: size), display: true)
    }
    
    override func close() {
        super.close()
        isVisible = false
    }
    
    // ===================================================================
    func setupPopover() {
        let storyboard = NSStoryboard(name: "Popover", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "popover") as? NSViewController else {
            fatalError("No VC in Storyboard found.")
        }
        
        popover.contentViewController = vc
        popover.behavior = .transient
    }
    
    func updateTime(minutes: Int) {
        if(!isVisible) {
            isVisible = true
            guard let view = self.window!.contentView else {
                fatalError("No View in Window found.")
            }
            
            popover.show(relativeTo: view.bounds, of: view, preferredEdge: .minY)
        } else {
            guard let customPopover = popover.contentViewController?.view as? CustomPopover else {
                fatalError("No Label found.")
            }
            
            customPopover.LText.integerValue = minutes
        }
    }
    
    func setSize (size: Int) {
        self.size = size;
        self.window?.setFrame(NSRect(x: 0, y: 0, width: size , height: size), display: true)
    }
}
