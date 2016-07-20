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
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application


    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    //Added this method so that the app will quit when the main window is closed.
    //This prevents the user from having to click on icon on the dock or from the menu bar in order to quit the app.
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true;
    }
    
    func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) ->  Void {

     
    }

    @IBAction func viewStats(sender: AnyObject) {
        let viewC: MainViewController = NSStoryboard(name: "Main", bundle: nil).instantiateInitialController() as! MainViewController;
        let s = NSStoryboardSegue.init(identifier: "StatsSegue", source: viewC, destination: StatiticsController());
        self.prepareForSegue(s, sender: viewC);

        
    }
}

