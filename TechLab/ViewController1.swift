//
//  ViewController1.swift
//  TechLab
//
//  Created by template on 1/12/16.
//  Copyright © 2016 template. All rights reserved.
//

import Foundation
import Cocoa
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
        previousWindow?.dismiss(self);

        
    }
    
    //------------------------------------Clear All Instance Arrays------------------------------------------
    
    func clearAllInstanceArrays() -> Void{
        self.allMyInfo.removeAll(keepingCapacity: true);
        self.arrayOfFileLocations.removeAll(keepingCapacity: true);
        self.arrayOfFileNames.removeAll(keepingCapacity: true);
        self.arrayOfPrices.removeAll(keepingCapacity: true);
        self.arrayOfUsages.removeAll(keepingCapacity: true);
        self.arrayOfEstTimes.removeAll(keepingCapacity: true);
        
    }
    
    //------------------------------------Package------------------------------------------------------
    
    @IBAction func package(_ sender: AnyObject) {
        
      
        // Build our various save paths and folders necessary to do such
        let desktopDirectory: URL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Desktop/" + (mainWindow?.semester)! + " Projects");
        let netIdDirectory: URL  = desktopDirectory.appendingPathComponent(netId as String);
        let projectDirectory: URL = netIdDirectory.appendingPathComponent(projectName as String);
        let originalFilesDirectory: URL = projectDirectory.appendingPathComponent("File Repository");
        let fileSpecsDirectory: URL = projectDirectory.appendingPathComponent("File Specs");
        
        //create the folder and filepath for our project
        var arrayOfFileSpecs = [String]();
        
        
        
        for item in arrayOfFileNames{
            
            arrayOfFileSpecs.append("File specs for \(item).txt");
            
        }
        
        var filePath = [URL]();
        for item in arrayOfFileSpecs{
            
            filePath.append(fileSpecsDirectory.appendingPathComponent(item));
            
        }
        
        
        //create the folder structure necessary
        let manager: FileManager = FileManager.default;
        
        if( !(manager.fileExists(atPath: netIdDirectory.path)) ){
            
            do{
                try manager.createDirectory(at: netIdDirectory, withIntermediateDirectories: true, attributes: nil);
                
            } catch {
                
            }
        }
        
        //create project folder
        if( !(manager.fileExists(atPath: projectDirectory.path)) ){
            do{
                try manager.createDirectory(at: projectDirectory, withIntermediateDirectories: true, attributes: nil);
                
                
            } catch{
                
            }
            
            
        }
        
        
        //create file container in project folder
        if( !(manager.fileExists(atPath: originalFilesDirectory.path)) ){
            do{
                try manager.createDirectory(at: originalFilesDirectory, withIntermediateDirectories: true, attributes: nil);
                
            }
            catch{
            }
            
            
        }
        //create file specs container in project folder
        if( !(manager.fileExists(atPath: fileSpecsDirectory.path)) ){
            do{
                try manager.createDirectory(at: fileSpecsDirectory, withIntermediateDirectories: true, attributes: nil);
                
            }catch{
                
            }
            
            
        }
        
        //write everything out
        for i in 0...(arrayOfFileSpecs.count - 1){
            do{
                try allMyInfo[i].write(toFile: filePath[i].path, atomically: true, encoding: String.Encoding.utf8);
                
            } catch{
                
            }
            
        }
        
        //check for waitlist
        let desktopDirectoryForQueue: URL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Desktop");
        let waitList: String = "3D_Printing_Request_Queue_" + (mainWindow?.semester)! + ".xls";
        let waitListLocation:URL = desktopDirectoryForQueue.appendingPathComponent(waitList);
        let waitListInitialContent: String = "Name \t Date \t File \t Job Paid For \t Print Completed \t Email Sent \t Est. Material \t Est. Time \t Price";
        

        if( !manager.fileExists(atPath: waitListLocation.path)){
            do{
                try waitListInitialContent.write(toFile: waitListLocation.path, atomically: true, encoding: String.Encoding.utf8);
            }catch{
                
            }
        }
        
        var destinationFileLocation = [String]();
        for item in arrayOfFileNames{
            
            destinationFileLocation.append((originalFilesDirectory.appendingPathComponent(item)).path)
        }
        
        
        
        //Determines whether or not the queue is open in excel or not. If it is open, an alert will pop up and prompt the user to save and close the queue before continuing.
        let task: Process = Process();
        task.launchPath = "/usr/sbin/lsof";
        let filepath = "/Users/template/Desktop/3D_Printing_Request_Queue_" + (mainWindow?.semester)! + ".xls";
        
        let pipe:Pipe = Pipe();
        task.arguments = [filepath];
        
        task.standardOutput = pipe;
        var h:FileHandle = FileHandle();
        h = pipe.fileHandleForReading;
        var data: Data = Data();
        task.launch();
        data = h.readDataToEndOfFile();
        
        let response = NSString.init(data: data, encoding: String.Encoding.utf8.rawValue);
        
        if( response?.length > 0){
            let fileIsOpenError = NSAlert()
            fileIsOpenError.messageText = "\t\t\t\t😱\n\t\tFile Open Error:\n\nThe printing request queue is open in Excel. Please save and close it before continuing.";
            fileIsOpenError.runModal();
            return;
        }
        
        
        //copying print files from thier locations into the file repository folders
        for i in 0...(arrayOfFileLocations.count - 1){
            
            if(arrayOfFileLocations[i].characters.count != 0){
                
                do{
                    try manager.copyItem(atPath: arrayOfFileLocations[i], toPath: destinationFileLocation[i]);
                }catch{
                    
                }
                
            }
            
            
        }
        
        
        //appends users to the waitlist
        var waitListContent = [String]();
        for i in 0...(arrayOfFileNames.count - 1){
            let temp = "\n\(name)\t\(dateString)\t\(arrayOfFileNames[i])\t\t\t\t\(arrayOfUsages[i])\t\(arrayOfEstTimes[i])\t\(arrayOfPrices[i])";
            waitListContent.append(temp);
        }
        
        var handle: FileHandle;
        do{
            try handle = FileHandle(forUpdating: waitListLocation);
            handle.seekToEndOfFile();
            
            for item in waitListContent{
                handle.write(item .data(using: String.Encoding.utf8, allowLossyConversion: true)!);
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
            self.mainWindow?.mainTable.insertRows(at: IndexSet(integer: newRowIndex), withAnimation: NSTableViewAnimationOptions());
        }
        
        
        //clears all the info from the info window so that another project may be added
        previousWindow?.clearAll(self);
        self.clearAllInstanceArrays();
        
        //closes the window
        self.dismiss(self);
    }
    
    

}

