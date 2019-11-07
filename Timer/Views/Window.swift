//
//  Window.swift
//  Timer
//
//  Created by Thomas Maier on 02.11.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    override func constrainFrameRect(_ frameRect: NSRect, to screen: NSScreen?) -> NSRect {
        return frameRect
    }
}
