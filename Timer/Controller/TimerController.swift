//
//  TimerController.swift
//  Timer
//
//  Created by Thomas Maier on 06.11.19.
//  Copyright © 2019 TinkeringAround. All rights reserved.
//

import Cocoa

class TimerController  {
    
    // Components
    var statusBarButton: NSStatusBarButton? = nil
    var statusBarMenu: NSMenu? = nil
    var timer : Timer? = nil
    let progressBar: ProgressBar = ProgressBar(frame: CGRect(x: 0, y: 0, width: 30, height: 22))
    let notification: NSUserNotification = NSUserNotification()
    
    // Attributes:
    var seconds: Int = 1
    var maxSeconds: Int = 1
    var steps : Int = 10
    let numberUpdates : Int = 60
    
    // ===================================================================
    func initialize(statusBarButton: NSStatusBarButton, statusBarMenu: NSMenu) -> Void {
        self.statusBarButton = statusBarButton
        self.statusBarMenu = statusBarMenu
        
        notification.title = "Tinkering Timer"
        notification.setValue(NSImage(named: "AppIcon"), forKey: "_identityImage")
        notification.setValue(true, forKey: "_ignoresDoNotDisturb")
        notification.setValue(true, forKey: "_clearable")
        notification.soundName = NSUserNotificationDefaultSoundName
    }
    
    func start(minutes: Int) -> Void {
        if(self.timer != nil) { self.timer!.invalidate() }
        
        // Set Values
        self.seconds = minutes * 60
        self.maxSeconds = seconds
        self.steps = Int(CGFloat(seconds) / CGFloat(numberUpdates))
        
        // Start
        progressBar.start(seconds: seconds)
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(steps), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        // Show Progress Bar
        statusBarButton?.image = nil
        statusBarButton?.addSubview(progressBar)
        
        // Add Menu Item with Time
        let menuItem : NSMenuItem = statusBarMenu!.items[0]
        menuItem.title = remainingTime()
        menuItem.isHidden = false
    }
    
    func stop() -> Void {
        self.timer?.invalidate()
        
        // Remove MenuItem
        statusBarMenu!.items[0].isHidden = true
        
        // Reset StatusBar Image
        progressBar.removeFromSuperview()
        statusBarButton?.image = NSImage(named:NSImage.Name("clock"))
    }
    
    func showNotification() -> Void {
        notification.identifier = String(NSDate().timeIntervalSince1970)
        var message = String(maxSeconds / 60) + " Minuten sind "
        if(maxSeconds / 60 == 1) {
            message = "1 Minute ist "
        }
        notification.informativeText = message + "abgelaufen."
        
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }
    
    func secondsToMinutes(seconds: Int) -> Int {
        return Int(CGFloat(seconds) / 60)
    }
    
    func remainingTime() -> String {
        let minutes = secondsToMinutes(seconds: seconds)
        var message = "Noch " + String(minutes) + " Minuten..."
        if(minutes == 0) {
            message = "Weniger als 1 Minute..."
        }
        return message
    }
    
    // ===================================================================
    @objc func update(_ sender: Timer) {
        seconds -= steps
        if(seconds <= 0) {
            showNotification()
            stop()
        } else {
            statusBarMenu!.items[0].title = remainingTime()
            progressBar.update(seconds: seconds)
        }
    }
}
