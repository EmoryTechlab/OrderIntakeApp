//
//  SettingsTabController.swift
//  TechLab
//
//  Created by template on 9/1/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa


//============================================================================================================================================================================================================================================================
class SettingsTabController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

//============================================================================================================================================================================================================================================================
//MARK: Semester Tab

class SemesterTab: NSViewController{
    
    var mainVC: MainViewController? = NSApplication.sharedApplication().mainWindow?.contentViewController as? MainViewController;

    @IBOutlet weak var seasonButton: NSPopUpButton!
    @IBOutlet weak var yearButton: NSPopUpButton!
    
    var seasonStr: String = "";
    var yearStr: String = "";
    
    //------------------------------------View Did Load-------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addItemsToSeasonList();
        self.addItemsToYearList();
    }
    
    //methods for populating the drop down menu buttons
    //------------------------------------Add Season List-------------------------------------------------------
    func addItemsToSeasonList() -> Void {
        
        seasonButton.addItemsWithTitles(["Fall", "Spring", "Summer"]);
        
    }
    
    //------------------------------------Add Year List-------------------------------------------------------
    func addItemsToYearList() -> Void{
        
        let today: NSDate = NSDate();
        let dateFormat: NSDateFormatter = NSDateFormatter();
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
        let dateString = dateFormat.stringFromDate(today);
        let year = Int(dateString.componentsSeparatedByString("/")[2]);
        
        let incr = 2;
        let lowerLimit = year! - incr;
        let upperLimit = year! + incr;
        
        yearButton.addItemWithTitle(String(year!));
        for i in lowerLimit...upperLimit {
            yearButton.addItemWithTitle(String(i));
        }
        
    }
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    func sendUpdatedValues() -> Void{
        seasonStr = seasonButton.titleOfSelectedItem!;
        yearStr = yearButton.titleOfSelectedItem!;
        mainVC!.semester = seasonStr + yearStr;
    }
    
}

//============================================================================================================================================================================================================================================================
//MARK: Color Tab

class ColorTab: NSViewController{
    
    var mainVC: MainViewController? = NSApplication.sharedApplication().mainWindow?.contentViewController as? MainViewController;
    var colors = [String]();
    
    @IBOutlet weak var colorInput: NSTextField!
    @IBOutlet var colorList: NSTextView!
    @IBOutlet weak var colorErrorLabel: NSTextField!

    
    //---------------------------------View Did Load-------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addInitialColorsToList();
    }
    
    //---------------------------------Add Initial Values-------------------------------------------------------
    func addInitialColorsToList() -> Void{
        colorList.editable = true;
        colors = mainVC!.colorList;
        colorList.insertText(colors.joinWithSeparator("\n"));
        colorList.editable = false;
        
    }
    //------------------------------------Validate Input-------------------------------------------------------
    func validateInput(input:String)->Bool{
        var valid = true;
        
        if(input.characters.count == 0){
            valid = false;
        }
        if(input.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions(), range: nil).characters.count == 0){
            valid = false;
        }
        
        
        return valid;
    }
    //------------------------------------Add Color-------------------------------------------------------
    @IBAction func addColor(sender: AnyObject) {
        
        let colorToAdd = colorInput.stringValue.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        
        if(!validateInput(colorToAdd)){
            colorInput.stringValue = "";
            return;
        }
        
        if( colors.contains(colorToAdd) ){
            colorErrorLabel.stringValue = colorToAdd + "\n already exists!"
        }
        else{
            colorList.editable = true;
            
            colors.append(colorToAdd);
            colorList.insertText("\n"+colorToAdd);
            colorErrorLabel.stringValue = "";
            
            colorList.editable = false;
            
            self.sendUpdatedValues();
        }
        
        colorInput.stringValue = "";
    }
    //------------------------------------Delete Color-------------------------------------------------------
    @IBAction func deleteColor(sender: AnyObject) {
        
        let colorToDel = colorInput.stringValue.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        
        if(!validateInput(colorToDel)){
            colorInput.stringValue = "";
            return;
        }
        
        
        if( colors.contains(colorToDel)){
            colorList.editable = true;
            
            colors.removeAtIndex(colors.indexOf(colorToDel)!);
            colorList.string = "";
            colorList.insertText(colors.joinWithSeparator("\n"));
            colorErrorLabel.stringValue = "";
            
            colorList.editable = false;
            
            self.sendUpdatedValues();
        }
        else{
            colorErrorLabel.stringValue = colorToDel + "\n does not exist!";
        }
        
        colorInput.stringValue = "";
    }
    
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    func sendUpdatedValues() -> Void{
        mainVC!.colorList = colors;
    }
}


//============================================================================================================================================================================================================================================================
//MARK: Printer Tab

class PrinterTab: NSViewController{
    
    var mainVC: MainViewController? = NSApplication.sharedApplication().mainWindow?.contentViewController as? MainViewController;
    var printers = [String]();
    var printerFileDict = [String: [String]]();
    
    
    @IBOutlet weak var printerInput: NSTextField!
    @IBOutlet var printerList: NSTextView!
    @IBOutlet weak var printerErrorLabel: NSTextField!
    
    //------------------------------------View Did Load-------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addInitialPrintersToList();
    }
    
    //------------------------------------Add Initial Printers and File Extensions-------------------------------------------------------
    func addInitialPrintersToList() -> Void{
        printerList.editable = true;
        printers = mainVC!.printerList;
        printerList.insertText(printers.joinWithSeparator("\n"));
        printerList.editable = false;
        
        printerFileDict = mainVC!.printerFileDict;
    }
    
    //------------------------------------Validate Input-------------------------------------------------------
    func validateInput(input:String)->Bool{
        var valid = true;
        
        if(input.characters.count == 0){
            valid = false;
        }
        if(input.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions(), range: nil).characters.count == 0){
            valid = false;
        }
        
        
        return valid;
    }
    
    //------------------------------------Add/Delete For Printers-------------------------------------------------------
    //------------Add
    @IBAction func addPrinter(sender: AnyObject) {
        
        let printerToAdd = printerInput.stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        if(!validateInput(printerToAdd)){
            printerInput.stringValue = "";
            return;
        }
        
        
        let testStr = printerToAdd.lowercaseString;
        
        var found = false;
        for item in printers{
            if(item.lowercaseString == testStr){
                found = true;
                break;
            }
        }
        
        if(!found){
            
            let val = addFileTypeForPrinter(printerToAdd);
            if(!val.hasError){
                printerFileDict[printerToAdd] = [];
                for item in val.fileExtentions{
                    printerFileDict[printerToAdd]?.append(item);
                }
                print(printerFileDict)
                printerList.editable = true;
                printers.append(printerToAdd);
                printerList.insertText("\n"+printerToAdd);
                printerErrorLabel.stringValue = "";
                printerList.editable = false;
                
                self.sendUpdatedValues();
            }

        }
        else{
            printerErrorLabel.stringValue = printerToAdd + "\n already exists!";
        }
        
        printerInput.stringValue = "";
    }
    
    //--------Add file type(s) for printer
    func addFileTypeForPrinter(printerName: String) -> (fileExtentions: [String], hasError:Bool){
        
        let msg = NSAlert()
        msg.addButtonWithTitle("OK")      // 1st button
        msg.addButtonWithTitle("Cancel")  // 2nd button
        msg.messageText = "Enter the compatible file extension(s) for the " + printerName;
        msg.informativeText = "You may enter multiple extentions separated by commas.";
        
        let extInput = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
        extInput.placeholderString = "Example: thing, amf, form";
        
        msg.accessoryView = extInput;
        let response: NSModalResponse = msg.runModal()
        
        if (response == NSAlertFirstButtonReturn) {
            let valid = validateInput(extInput.stringValue);
            if(valid){
                var arrOfExtensions = extInput.stringValue.componentsSeparatedByString(",");
                for i in 0...arrOfExtensions.count-1{
                    arrOfExtensions[i] = formatStringInput(arrOfExtensions[i])
                }
                
                return (arrOfExtensions, false);
            }
        }

        return ([String](), true);
        
        
    }
    
    //---Helper function
    func formatStringInput(input: String) -> String {
        
        var cleanInput = input;
        cleanInput = cleanInput.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        cleanInput = cleanInput.stringByTrimmingCharactersInSet(NSCharacterSet.punctuationCharacterSet());
        
        return cleanInput
        
    }
    //---Delete
    @IBAction func deletePrinter(sender: AnyObject) {
        
        let printerToDel = printerInput.stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        if(!validateInput(printerToDel)){
            printerInput.stringValue = "";
            return;
        }
        
        let testStr = printerToDel.lowercaseString;
        var index = 0;
        
        var found = false;
        for item in printers{
            if(item.lowercaseString == testStr){
                index = printers.indexOf(item)!;
                
                found = true;
                break;
            }
        }
        
        if(found){
            printerList.editable = true;
            
            printers.removeAtIndex(index);
            printerList.string = "";
            printerList.insertText(printers.joinWithSeparator("\n"));
            printerErrorLabel.stringValue = "";
            
            printerList.editable = false;
            
            
            printerFileDict.removeValueForKey(printerToDel);
            self.sendUpdatedValues();
            
        }
        else{
            printerErrorLabel.stringValue = printerToDel + "\n does not exist!";
            
        }
        
        
        printerInput.stringValue = "";
    }
    
    
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    func sendUpdatedValues() -> Void{
        
        mainVC!.printerList = printers;
        mainVC!.printerFileDict = printerFileDict;
    }
    
}