//
//  AppDelegate.swift
//  Musix
//
//  Created by Thomas Ricouard on 30/06/2017.
//  Copyright © 2017 Thomas Ricouard. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MainController.shared.initialConfiguration()
    }

}

