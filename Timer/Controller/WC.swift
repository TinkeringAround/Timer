//
//  WC.swift
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
    var isVisible : Bool = false
    
    // ===================================================================
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Setup Popover
        let storyboard = NSStoryboard(name: "Popover", bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: "popover") as! NSViewController
        
        popover.contentViewController = vc
        popover.behavior = .transient
        
        // Setup Window
        self.window?.isOpaque = false
        self.window?.backgroundColor  = NSColor(calibratedRed: 255, green: 0, blue: 0, alpha: 0)
        self.window?.setAccessibilityModal(true)
        self.window?.level = .statusBar
    }
    
    override func close() {
        isVisible = false
        super.close()
    }
    
    // ===================================================================
    func update(minutes: Int, height: Int) {
        let view = self.window!.contentView! as! Main
        
        view.setHeight(height: height)
        let customPopover = popover.contentViewController!.view as! Popover
        customPopover.LText.integerValue = minutes
        
        if(isVisible && minutes < 1) {
            isVisible = false
            popover.close()
        }
        
        if(!isVisible && minutes > 0) {
            isVisible = true
            popover.show(relativeTo: view.IVIcon.bounds, of: view, preferredEdge: .minX)
        }
    }
}
