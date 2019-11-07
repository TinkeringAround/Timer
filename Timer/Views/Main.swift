//
//  Main.swift
//  Timer
//
//  Created by Thomas Maier on 07.11.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

class Main: NSView {
    
    // Components:
    @IBOutlet weak var IVIcon: NSImageView!

    // Attributes:
    var height: Int = 0
    
    // ===================================================================
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawLine()
    }

    // ===================================================================
    func setHeight(height: Int)  {
        self.height = height
        self.display()
    }
    
    func drawLine() {
        NSColor.white.set()
        let figure = NSBezierPath()
        figure.move(to: NSMakePoint(self.bounds.midX, 0))
        figure.line(to: NSMakePoint(self.bounds.midX, CGFloat(height)))
        figure.lineWidth = 2
        figure.stroke()
    }
}
