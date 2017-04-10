//
//  AppDelegate.swift
//  TechLab
//
//  Created by template on 1/12/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var pArray : [PrintOrder] = [];
    var semester : String?;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application


    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    //Added this method so that the app will quit when the main window is closed.
    //This prevents the user from having to click on icon on the dock or from the menu bar in order to quit the app.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true;
    }

}

