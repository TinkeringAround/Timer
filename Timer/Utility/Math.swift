//
//  Math.swift
//  Timer
//
//  Created by Thomas Maier on 07.11.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

class Math {
    static public func map(minRange:Int, maxRange:Int, minDomain:Int, maxDomain:Int, value:Int) -> Int {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
}
