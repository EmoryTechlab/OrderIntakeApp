//
//  SettingsTabController.swift
//  TechLab
//
//  Created by template on 9/1/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa

/*
 This file contains multiple classes, one for the actual Tab View Controller and one for each of the individual tab views.
 This may not be a standard way of doing things, but it seemed a bit unnecesary to create a separate file for each of the tabs.
 That being said, a separate file may be created for each tab if it is determined that this way is bad practice.
 
 */


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
    
    var mainVC: MainViewController? = NSApplication.shared().mainWindow?.contentViewController as? MainViewController;

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
        
        seasonButton.addItems(withTitles: ["Fall", "Spring", "Summer"]);
        
    }
    
    //------------------------------------Add Year List-------------------------------------------------------
    func addItemsToYearList() -> Void{
        
        let today: Date = Date();
        let dateFormat: DateFormatter = DateFormatter();
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
        let dateString = dateFormat.string(from: today);
        let year = Int(dateString.components(separatedBy: "/")[2]);
        
        let incr = 2;
        let lowerLimit = year! - incr;
        let upperLimit = year! + incr;
        
        yearButton.addItem(withTitle: String(year!));
        for i in lowerLimit...upperLimit {
            yearButton.addItem(withTitle: String(i));
        }
        
    }
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    //updates the semester string in the main controller so that updates from settings view correctly propagate
    @IBAction func changeSemester(_ sender: AnyObject) {
        
        seasonStr = seasonButton.titleOfSelectedItem!;
        yearStr = yearButton.titleOfSelectedItem!;
        mainVC!.semester = seasonStr + yearStr;
        
        //alert so that user know that changes where actually made
        let alert = NSAlert();
        alert.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
        alert.messageText = " \t\t\t\t\t\u{1F44D}\n\n Semester has been changed.";
        alert.runModal();
    }

    
}

//============================================================================================================================================================================================================================================================
//MARK: Color Tab

class ColorTab: NSViewController{
    
    var mainVC: MainViewController? = NSApplication.shared().mainWindow?.contentViewController as? MainViewController;
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
        colorList.isEditable = true;
        colors = mainVC!.colorList;
        //colorList.insertText(colors.joined(separator: "\n"));
        colorList.insertText(colors.joined(separator: "\n"), replacementRange: NSRange());
        colorList.isEditable = false;
        
    }
    //------------------------------------Validate Input-------------------------------------------------------
    func validateInput(_ input:String)->Bool{
        var valid = true;
        
        //if empty
        if(input.characters.count == 0){
            valid = false;
        }
        //deals with the case of a bunch of spaces
        if(input.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions(), range: nil).characters.count == 0){
            valid = false;
        }
        
        
        return valid;
    }
    //------------------------------------Add Color-------------------------------------------------------
    @IBAction func addColor(_ sender: AnyObject) {
        
        let colorToAdd = colorInput.stringValue.lowercased().trimmingCharacters(in: CharacterSet.whitespaces);
        
        if(!validateInput(colorToAdd)){ //if invalid input
            colorInput.stringValue = "";
            return;
        }
        
        if( colors.contains(colorToAdd) ){ //if color already exists
            colorErrorLabel.stringValue = colorToAdd + "\n already exists!"
        }
        else{ //else add colors
            colorList.isEditable = true;
            
            colors.append(colorToAdd);
            colorList.insertText(colorToAdd + "\n", replacementRange: NSRange());
            colorErrorLabel.stringValue = "";
            
            colorList.isEditable = false;
            
            self.sendUpdatedValues();
        }
        
        colorInput.stringValue = "";
    }
    //------------------------------------Delete Color-------------------------------------------------------
    @IBAction func deleteColor(_ sender: AnyObject) {
        
        let colorToDel = colorInput.stringValue.lowercased().trimmingCharacters(in: CharacterSet.whitespaces);
        
        if(!validateInput(colorToDel)){ //if invalid input
            colorInput.stringValue = "";
            return;
        }
        
        
        if( colors.contains(colorToDel)){ //delete color
            colorList.isEditable = true;
            
            colors.remove(at: colors.index(of: colorToDel)!);
            colorList.string = "";
            colorList.insertText(colors.joined(separator: "\n"), replacementRange: NSRange());
            colorErrorLabel.stringValue = "";
            
            colorList.isEditable = false;
            
            self.sendUpdatedValues();
        }
        else{ //if color does not exit
            colorErrorLabel.stringValue = colorToDel + "\n does not exist!";
        }
        
        colorInput.stringValue = "";
    }
    
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    //updates the color list in the main controller so that updates from settings view correctly propagate
    func sendUpdatedValues() -> Void{
        mainVC!.colorList = colors;
    }
}


//============================================================================================================================================================================================================================================================
//MARK: Printer Tab

class PrinterTab: NSViewController{
    
    var mainVC: MainViewController? = NSApplication.shared().mainWindow?.contentViewController as? MainViewController;
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
        
        printerList.isEditable = true;
        printers = mainVC!.printerList;
        printerList.insertText(printers.joined(separator: "\n"), replacementRange: NSRange());
        printerList.isEditable = false;
        
        printerFileDict = mainVC!.printerFileDict;
    }
    
    //------------------------------------Validate Input-------------------------------------------------------
    func validateInput(_ input:String)->Bool{
        var valid = true;
        
        if(input.characters.count == 0){
            valid = false;
        }
        if(input.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions(), range: nil).characters.count == 0){
            valid = false;
        }
        
        
        return valid;
    }
    
    //------------------------------------Add/Delete For Printers-------------------------------------------------------
    //------------Add
    @IBAction func addPrinter(_ sender: AnyObject) {
        
        let printerToAdd = printerInput.stringValue.trimmingCharacters(in: CharacterSet.whitespaces);
        
        if(!validateInput(printerToAdd)){ //if invalid input
            printerInput.stringValue = "";
            return;
        }
        
        
        let testStr = printerToAdd.lowercased();
        
        var found = false;
        for item in printers{
            if(item.lowercased() == testStr){
                found = true;
                break;
            }
        }
        
        if(!found){ //if printer does not exit, add it
            
            let val = addFileTypeForPrinter(printerToAdd);
            if(!val.hasError){
                
                printerFileDict[printerToAdd] = [];
                for item in val.fileExtentions{
                    printerFileDict[printerToAdd]?.append(item);
                }
                
                printerList.isEditable = true;
                printers.append(printerToAdd);
                printerList.insertText(printerToAdd + "\n", replacementRange: NSRange());
                printerErrorLabel.stringValue = "";
                printerList.isEditable = false;
                
                self.sendUpdatedValues();
            }

        }
        else{ //if printer already exists
            printerErrorLabel.stringValue = printerToAdd + "\n already exists!";
        }
        
        printerInput.stringValue = "";
    }
    
    //--------Add file type(s) for printer
    func addFileTypeForPrinter(_ printerName: String) -> (fileExtentions: [String], hasError:Bool){
        
        let msg = NSAlert()
        msg.addButton(withTitle: "OK")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = "Enter the compatible file extension(s) for the " + printerName;
        msg.informativeText = "You may enter multiple extentions separated by commas.";
        
        let extInput = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
        extInput.placeholderString = "Example: amf";
        
        msg.accessoryView = extInput;
        let response: NSModalResponse = msg.runModal()
        
        if (response == NSAlertFirstButtonReturn) {
            let valid = validateInput(extInput.stringValue);
            if(valid){
                var arrOfExtensions = extInput.stringValue.components(separatedBy: ",");
                for i in 0...arrOfExtensions.count-1{
                    arrOfExtensions[i] = formatStringInput(arrOfExtensions[i])
                }
                
                return (arrOfExtensions, false);
            }
        }

        return ([String](), true);
        
        
    }
    
    //---Helper function that strips spaces and punctuations from user input incase the user typed .amf instead of just amf for file extension
    func formatStringInput(_ input: String) -> String {
        
        var cleanInput = input;
        cleanInput = cleanInput.trimmingCharacters(in: CharacterSet.whitespaces);
        cleanInput = cleanInput.trimmingCharacters(in: CharacterSet.punctuationCharacters);
        
        return cleanInput
        
    }
    //---Delete
    @IBAction func deletePrinter(_ sender: AnyObject) {
        
        let printerToDel = printerInput.stringValue.trimmingCharacters(in: CharacterSet.whitespaces);
        if(!validateInput(printerToDel)){
            printerInput.stringValue = "";
            return;
        }
        
        let testStr = printerToDel.lowercased();
        var index = 0;
        
        var found = false;
        for item in printers{
            if(item.lowercased() == testStr){
                index = printers.index(of: item)!;
                
                found = true;
                break;
            }
        }
        
        if(found){
            printerList.isEditable = true;
            
            printers.remove(at: index);
            printerList.string = "";
            printerList.insertText(printers.joined(separator: "\n"), replacementRange: NSRange());
            printerErrorLabel.stringValue = "";
            
            printerList.isEditable = false;
            
            
            printerFileDict.removeValue(forKey: printerToDel);
            self.sendUpdatedValues();
            
        }
        else{
            printerErrorLabel.stringValue = printerToDel + "\n does not exist!";
            
        }
        
        
        printerInput.stringValue = "";
    }
    
    
    
    //------------------------------------Send Updated Values-------------------------------------------------------
    //updates the printer and printer-file_extension lists in the main controller so that updates from settings view correctly propagate
    func sendUpdatedValues() -> Void{
        
        mainVC!.printerList = printers;
        mainVC!.printerFileDict = printerFileDict;
    }
    
}
