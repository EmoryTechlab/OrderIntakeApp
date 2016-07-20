//
//  StatisticsController.swift
//  TechLab
//
//  Created by template on 2/9/16.
//  Copyright © 2016 template. All rights reserved.
//

import Foundation
import Cocoa

class StatiticsController: NSViewController{
    
    
    @IBOutlet var semester: NSTextField!
    @IBOutlet var totalGram: NSTextField!
    @IBOutlet var totalML: NSTextField!
    @IBOutlet var totalPrice: NSTextField!
    @IBOutlet var uniqueUsers: NSTextField!
    @IBOutlet var totalTime: NSTextField!
  
    var map = NSMapTable();
    var timeArr = [0, 0, 0];
  

    
    //------------------------------------View Did Load------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        semester.stringValue = "Spring 2016";
        let mainVC = NSApplication.sharedApplication().mainWindow?.contentViewController as! MainViewController;
        
        var price = 0.0;
        var gram = 0.0;
        var mL = 0.0;
        
        for x in mainVC.printOrderArray{
            var isGram = true;
            let tempStr:NSString = NSString(string: x.price!);
            price = price + Double(tempStr.substringFromIndex(1))!;
            let type = x.materialType;
            if( type!.hasSuffix("mL") ){
                isGram = false;
            }
        
            if(isGram){
                gram  = gram + x.materialValue!;
            }
            else{
                mL = mL + x.materialValue!;
            }
            
            
            let tempArr = x.time!.componentsSeparatedByString(":");

            for i in 0...tempArr.count-1{
                timeArr[i] = timeArr[i] + Int(tempArr[i])!;
            }
            
            
   
    
        }
        
        
        totalGram.stringValue = "\(gram)";
        totalML.stringValue = "\(mL)";
        totalPrice.stringValue = String(format: "$%.2f", price);
        uniqueUsers.stringValue = "";
        
        var h = timeArr[0];
        var m = timeArr[1];
        let s = timeArr[2];
        
        h = h + (m/60);
        m = m%60;
        totalTime.stringValue = String(format: "%02d:%02d:%02d", h , m, s);
     
        
    }
    
    @IBAction func export(sender: AnyObject) {
        
    }
    
    
    
}