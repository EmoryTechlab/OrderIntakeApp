//
//  SettingsController.swift
//  TechLab
//
//  Created by template on 8/25/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa


class SettingsController: NSViewController {


    @IBOutlet weak var seasonButton: NSPopUpButton!
    @IBOutlet weak var yearButton: NSPopUpButton!
    
    var mainVC: MainViewController? = NSApplication.sharedApplication().mainWindow?.contentViewController as? MainViewController;
    var seasonStr: String = "";
    var yearStr: String = "";
    
    var colors = [String]();
      @IBOutlet weak var colorInput: NSTextField!
        @IBOutlet var colorList: NSTextView!
        @IBOutlet weak var colorErrorLabel: NSTextField!
    
    var printers = [String]();
    var printerFileDict = [String: [String]]();
    
  
    @IBOutlet weak var printerInput: NSTextField!

    @IBOutlet var printerList: NSTextView!

    @IBOutlet weak var printerErrorLabel: NSTextField!
    //------------------------------------View Did Load-------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doAddItemsToSeasonList();
        self.doAddItemsToYearList();
        self.addInitialColorsToList();
        self.addInitialPrintersToList();
//        mainVC = NSApplication.sharedApplication().mainWindow?.contentViewController as? MainViewController;
        
    }
    
    //MARK: - methods for populating the drop down menu buttons
    //------------------------------------Add Season List-------------------------------------------------------
    func doAddItemsToSeasonList() -> Void {
    
        seasonButton.addItemsWithTitles(["Fall", "Spring", "Summer"]);
        
    }
    
    //------------------------------------Add Year List-------------------------------------------------------
    func doAddItemsToYearList() -> Void{
        
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
    
    //------------------------------------Add Initial Values to Lists-------------------------------------------------------
    func addInitialColorsToList() -> Void{
        colorList.editable = true;
        colors = mainVC!.colorList;
        colorList.insertText(colors.joinWithSeparator("\n"));
        colorList.editable = false;
        
    }
    
    func addInitialPrintersToList() -> Void{
        printerList.editable = true;
        printers = mainVC!.printerList;
        printerList.insertText(printers.joinWithSeparator("\n"));
        printerList.editable = false;
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
    
    
    //------------------------------------Add/Delete For Colors-------------------------------------------------------
    //---Add
    @IBAction func addColor(sender: AnyObject) {

        let colorToAdd = colorInput.stringValue.lowercaseString;
        
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
        }
        
        colorInput.stringValue = "";
    }
    //---Delete
    @IBAction func deleteColor(sender: AnyObject) {
        
        let colorToDel = colorInput.stringValue.lowercaseString;
        
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
        }
        else{
            colorErrorLabel.stringValue = colorToDel + "\n does not exist!";
        }
        
        colorInput.stringValue = "";
    }
    
    //------------------------------------Add/Delete For Printers-------------------------------------------------------
    //------------Add
    @IBAction func addPrinter(sender: AnyObject) {
        
        let printerToAdd = printerInput.stringValue;
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
            
            addFileTypeForPrinter(printerToAdd);
            printerList.editable = true;
            printers.append(printerToAdd);
            printerList.insertText("\n"+printerToAdd);
            printerErrorLabel.stringValue = "";

            printerList.editable = false;
        }
        else{
            printerErrorLabel.stringValue = printerToAdd + "\n already exists!";
        }
        
        printerInput.stringValue = "";
    }
    
    //--------Add file type(s) for printer
    func addFileTypeForPrinter(printerName: String) -> (fileExts: [String], hasError:Bool){
        
        let msg = NSAlert()
        msg.addButtonWithTitle("OK")      // 1st button
        msg.addButtonWithTitle("Cancel")  // 2nd button
        msg.messageText = "Enter the compatible file extension(s) for the " + printerName;
        msg.informativeText = "You may enter multiple extentions separated by commas.";
        
        let extInput = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
        extInput.placeholderString = "obj";
        
        msg.accessoryView = extInput;
        let response: NSModalResponse = msg.runModal()
        
        if (response == NSAlertFirstButtonReturn) {
            let valid = validateInput(extInput.stringValue);
            if(valid){
                return (extInput.stringValue.componentsSeparatedByString(","), false);
            }
            else{
                return ([String](), true);
            }
        }
        
        return ([String](), false);
        
        
    }
    //---Delete
    @IBAction func deletePrinter(sender: AnyObject) {
        
        let printerToDel = printerInput.stringValue;
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

        }
        else{
            printerErrorLabel.stringValue = printerToDel + "\n does not exist!";
            
        }
        
        
        printerInput.stringValue = "";
    }
    
    
    
    //------------------------------------Apply All Changes-------------------------------------------------------
    @IBAction func applyChanges(sender: AnyObject) {
        seasonStr = seasonButton.titleOfSelectedItem!;
        yearStr = yearButton.titleOfSelectedItem!;
        mainVC!.semester = seasonStr + yearStr;
        mainVC!.colorList = colors;
        mainVC!.printerList = printers;
        self.dismissController(self);
    }


    
}
