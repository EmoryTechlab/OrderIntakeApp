//
//  ViewController1.swift
//  TechLab
//
//  Created by template on 1/12/16.
//  Copyright © 2016 template. All rights reserved.
//

import Foundation
import Cocoa

class ViewController1: NSViewController{
    
    var allMyContent = "";
    var allMyInfo = [String]();
    var arrayOfFileNames = [String]();
    var arrayOfFileLocations = [String]();
    var arrayOfUsages = [String]();
    var arrayOfPrices = [String]();
    var arrayOfEstTimes = [String]();
    
    var projectName: NSString = "";
    var name: NSString = "";
    var netId: NSString = "";
    var dateString: NSString = "";
    var estMaterial: NSString = "";
    var estTime: NSString = "";
    var price: NSString = "";
    var fileLocation: NSString = "";
    var unitsInGrams: Bool = false;
    var unitsInML: Bool = false;
    
    var previousWindow: ViewController?;
    var mainWindow: MainViewController?;
    var printOrderArray = [PrintOrder]();
 
    //------------------------------------View Did Load------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        previousWindow?.dismissController(self);

        
    }
    
    //------------------------------------Clear All Instance Arrays------------------------------------------
    
    func clearAllInstanceArrays() -> Void{
        self.allMyInfo.removeAll(keepCapacity: true);
        self.arrayOfFileLocations.removeAll(keepCapacity: true);
        self.arrayOfFileNames.removeAll(keepCapacity: true);
        self.arrayOfPrices.removeAll(keepCapacity: true);
        self.arrayOfUsages.removeAll(keepCapacity: true);
        self.arrayOfEstTimes.removeAll(keepCapacity: true);
        
    }
    
    //------------------------------------Package------------------------------------------------------
    
    @IBAction func package(sender: AnyObject) {
        
        //Uses the current date to determine the corresponding academic term for data storing purposes.
        let today: NSDate = NSDate();
        let dateFormat: NSDateFormatter = NSDateFormatter();
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
        let dateString = dateFormat.stringFromDate(today);
        
        var temp = dateString.componentsSeparatedByString("/");
        let month: String = temp[0];
        let day: String = temp[1];
        let year: String = temp[2];
        
        var term: String = "";
        
        
       // var termWithoutSpace: String = "";
        
        let m = Int(month);
        let d = Int(day);
        
        if( m >= 1 && m <= 5){
            if( m == 5){
                if( d <= 10 ){ term = "Spring";}
                else         { term = "Summer";}
            }
            else{
                term =  "Spring";
            }
            
        }
        else if( m >= 5 && m <= 8){
            if( m == 8){
                if(d <= 11){ term = "Summer"; }
                else       { term = "Fall";   }
            }
            else{
                term = "Summer";
            }
            
        }
        else if( m >= 8 && m <= 12){
            term = "Fall";
        }
       // termWithoutSpace = term + year;
        term += " \(year)";
        
        
        
        
        // Build our various save paths and folders necessary to do such
       // let desktopDirectory: NSURL = NSURL(fileURLWithPath: NSHomeDirectory()).URLByAppendingPathComponent("Desktop/" + term + " Projects");
        let desktopDirectory: NSURL = NSURL(fileURLWithPath: NSHomeDirectory()).URLByAppendingPathComponent("Desktop/TempProjects");

        let netIdDirectory: NSURL  = desktopDirectory.URLByAppendingPathComponent(netId as String);
        let projectDirectory: NSURL = netIdDirectory.URLByAppendingPathComponent(projectName as String);
        let originalFilesDirectory: NSURL = projectDirectory.URLByAppendingPathComponent("File Repository");
        let fileSpecsDirectory: NSURL = projectDirectory.URLByAppendingPathComponent("File Specs");
        let photoDirectory: NSURL = projectDirectory.URLByAppendingPathComponent("Photos of finished project");
        
        //create the folder and filepath for our project
        var arrayOfFileSpecs = [String]();
        
        for item in arrayOfFileNames{
            
            arrayOfFileSpecs.append("File specs for \(item).text");
            
        }
        
        var filePath = [NSURL]();
        for item in arrayOfFileSpecs{
            
            filePath.append(fileSpecsDirectory.URLByAppendingPathComponent(item));
            
        }
        
        
        //create the folder structure necessary
        let manager: NSFileManager = NSFileManager.defaultManager();
        
        if( !(manager.fileExistsAtPath(netIdDirectory.path!)) ){
            
            do{
                try manager.createDirectoryAtURL(netIdDirectory, withIntermediateDirectories: true, attributes: nil);
                
            } catch {
                
            }
        }
        
        
        //create project folder
        if( !(manager.fileExistsAtPath(projectDirectory.path!)) ){
            do{
                try manager.createDirectoryAtURL(projectDirectory, withIntermediateDirectories: true, attributes: nil);
                
                
            } catch{
                
            }
            
            
        }
        
        
        //create file container in project folder
        if( !(manager.fileExistsAtPath(originalFilesDirectory.path!)) ){
            do{
                try manager.createDirectoryAtURL(originalFilesDirectory, withIntermediateDirectories: true, attributes: nil);
                
            }
            catch{
            }
            
            
        }
        //create file specs container in project folder
        if( !(manager.fileExistsAtPath(fileSpecsDirectory.path!)) ){
            do{
                try manager.createDirectoryAtURL(fileSpecsDirectory, withIntermediateDirectories: true, attributes: nil);
                
            }catch{
                
            }
            
            
        }
        //create photo folder in project folder
        if( !(manager.fileExistsAtPath(photoDirectory.path!)) ){
            
            do{
                try manager.createDirectoryAtURL(photoDirectory, withIntermediateDirectories: true, attributes: nil);
                
            }catch{
                
            }
            
        }
        
        //write everything out
        for i in 0...(arrayOfFileSpecs.count - 1){
            do{
                try allMyInfo[i].writeToFile(filePath[i].path!, atomically: true, encoding: NSUTF8StringEncoding);
                
            } catch{
                
            }
            
        }
        
        //check for waitlist
        let desktopDirectoryForQueue: NSURL = NSURL(fileURLWithPath: NSHomeDirectory()).URLByAppendingPathComponent("Desktop");
        //let waitList: String = "3D_Printing_Request_Queue_" + termWithoutSpace + ".xls";
        let waitList: String = "3D_Printing_Request_Queue_Temp.xls";
        let waitListLocation:NSURL = desktopDirectoryForQueue.URLByAppendingPathComponent(waitList);
        let waitListInitialContent: String = "Name \t Date \t File \t Job Paid For \t Print Completed \t Photo Taken \t Email Sent \t Est. Material \t Est. Time \t Price";
        
//        if( manager.fileExistsAtPath(waitListLocation.path!)){
//            print("The List already exists");
//        }
//        else{
//            do{
//                try waitListInitialContent.writeToFile(waitListLocation.path!, atomically: true, encoding: NSUTF8StringEncoding);
//            }catch{
//                
//            }
//            
//            
//        }
        if( !manager.fileExistsAtPath(waitListLocation.path!)){
            do{
                try waitListInitialContent.writeToFile(waitListLocation.path!, atomically: true, encoding: NSUTF8StringEncoding);
            }catch{
                
            }
        }
        
        var destinationFileLocation = [String]();
        for item in arrayOfFileNames{
            
            destinationFileLocation.append((originalFilesDirectory.URLByAppendingPathComponent(item)).path!)
        }
        
        
        
        //Determines whether or not the queue is open in excel or not. If it is open, an alert will pop up and prompt the user to save and close the queue before continuing.
        let task: NSTask = NSTask();
        task.launchPath = "/usr/sbin/lsof";
//        let filepath = "/Users/template/Desktop/3D_Printing_Request_Queue_" + termWithoutSpace + ".xls";
        let filepath = "/Users/template/Desktop/3D_Printing_Request_Queue_Temp.xls";

        
        let pipe:NSPipe = NSPipe();
        task.arguments = [filepath];
        
        task.standardOutput = pipe;
        var h:NSFileHandle = NSFileHandle();
        h = pipe.fileHandleForReading;
        var data: NSData = NSData();
        task.launch();
        data = h.readDataToEndOfFile();
        
        let response = NSString.init(data: data, encoding: NSUTF8StringEncoding);
        
        if( response?.length > 0){
            let fileIsOpenError = NSAlert()
            fileIsOpenError.messageText = "\t\t\t\t😱\n\t\tFile Open Error:\n\nThe printing request queue is open in Excel. Please save and close it before continuing.";
            fileIsOpenError.runModal();
            return;
        }
        
        
        
        for i in 0...(arrayOfFileLocations.count - 1){
            
//            //if there is no file to copy
//            if(arrayOfFileLocations[i].characters.count == 0){
//                
//                print("No file to copy");
//                
//            }
//            else{
//                
//                do{
//                    try manager.copyItemAtPath(arrayOfFileLocations[i], toPath: destinationFileLocation[i]);
//                }catch{
//                    
//                }
//                
//            }
            
            
            if(arrayOfFileLocations[i].characters.count != 0){
                
                do{
                    try manager.copyItemAtPath(arrayOfFileLocations[i], toPath: destinationFileLocation[i]);
                }catch{
                    
                }
                
            }
            
            
        }
        
        
        //appends users to the waitlist
        var waitListContent = [String]();
        for i in 0...(arrayOfFileNames.count - 1){
            let temp = "\n\(name)\t\(dateString)\t\(arrayOfFileNames[i])\t\t\t\t\t\(arrayOfUsages[i])\t\(arrayOfEstTimes[i])\t\(arrayOfPrices[i])";
            waitListContent.append(temp);
        }
        
        //let handle: NSFileHandle = NSFileHandle(forUpdatingAtPath: waitListLocation)!;
        var handle: NSFileHandle;
        do{
            try handle = NSFileHandle(forUpdatingURL: waitListLocation);
            handle.seekToEndOfFile();
            
            for item in waitListContent{
                handle.writeData(item .dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!);
            }
            handle.closeFile();
            
            
        }catch{
            
        }
        
        
        insertToTable();
        
    }

    //------------------------------------Add Order Segue------------------------------------------------------
    
     func insertToTable() ->  Void {
        
        let tableCount : Int = (self.mainWindow?.mainTable.numberOfRows)!;
        let arrayCount: Int = printOrderArray.count;
        self.mainWindow?.printOrderArray = self.printOrderArray;
        
        //Insert new row in the table view
        let newRowIndex = mainWindow!.printOrderArray.count;
        for _ in tableCount...arrayCount-1 {
            self.mainWindow?.mainTable.insertRowsAtIndexes(NSIndexSet(index: newRowIndex), withAnimation: NSTableViewAnimationOptions());
        }
        
        
        //clears all the info from the info window so that another project may be added
        previousWindow?.clearAll(self);
        self.clearAllInstanceArrays();
        
        //closes the window
        self.dismissController(self);
    }
    
    

}

