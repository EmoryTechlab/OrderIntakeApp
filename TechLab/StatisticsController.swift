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
    @IBOutlet weak var totalPrints: NSTextField!
    @IBOutlet var colors: NSTextField!
    
    var timeArr = [0, 0, 0];
    var usersMap = [String: Int]();
    var colorsMap = [String: Int]();
    var usersSet = Set<String>();
    var uniqueUsersString: String = "";
    var colorsString: String = "";
    
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
            
            //unique users
            if(usersMap[x.schoolAssociation!] == nil){
                usersMap[x.schoolAssociation!] = 1;
                usersSet.insert(x.netID!);
            }
            else{
                if(!usersSet.contains(x.netID!)){
                    usersMap.updateValue(usersMap[x.schoolAssociation!]! + 1, forKey: x.schoolAssociation!);
                }
            }
            
            //colors
            if(colorsMap[x.materialColor!] == nil){
                colorsMap[x.materialColor!] = 1;
            }
            else{
                colorsMap.updateValue(colorsMap[x.materialColor!]! + 1, forKey: x.materialColor!);
            }
            
    
        }
        
        totalPrints.stringValue = "\(mainVC.printOrderArray.count)";
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
        
        uniqueUsersString = buildString(usersMap);
        colorsString = buildString(colorsMap);
        uniqueUsers.stringValue = uniqueUsersString;
        colors.stringValue = colorsString;
        
        
    }
    
    func buildString( inputMap: Dictionary<String, Int>) -> String{
        
        var str: String = "";
        for(key, value) in inputMap{
            str += key + ": " + String(value) + "\n";
        }
        return str;
        
    }
    
    @IBAction func export(sender: AnyObject) {
        
        let str = semester.stringValue + "\n\n" +
                    "Total Prints: " + totalPrints.stringValue + "\n\n" +
                    "Total Usage(g) : " + totalGram.stringValue + "\n" +
                    "Total Usage(mL) : " + totalML.stringValue + "\n\n" +
                    "Total Price : " + totalPrice.stringValue + "\n" +
                    "Total Time: " + totalTime.stringValue + "\n\n" +
                    "Unique Users by School Association : " + "\n\t" +
                        uniqueUsersString + "\n\n" +
                    "Colors: " +  "\n\t" +
                        colorsString;
        
        
        let path: NSURL = NSURL(fileURLWithPath: NSHomeDirectory()).URLByAppendingPathComponent("Downloads/" + semester.stringValue + "TechLabData.txt");
    
        do{
            try str.writeToFile(path.path!, atomically: true, encoding: NSUTF8StringEncoding);
            
        } catch{
            
        }
        
        let alert = NSAlert();
        alert.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
        alert.messageText = " \t\t\t\t\t\u{1F44D}\n\n File successfully exported to Downloads folder.";
        alert.runModal();
        
    }
    
    
    
}