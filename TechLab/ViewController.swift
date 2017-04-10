//
//  ViewController.swift
//  TechLab
//
//  Created by template on 1/12/16.
//  Copyright © 2016 template. All rights reserved.
//
import Cocoa

class ViewController: NSViewController{
    
    //Instance variables
    
    //MARK: - Text Fields
    @IBOutlet var projectName: NSTextField!
    @IBOutlet var name: NSTextField!
    @IBOutlet var phoneNumber: NSTextField!
    @IBOutlet var netId: NSTextField!
    @IBOutlet var usage: NSTextField!
    @IBOutlet var fileLocation: NSTextField!
    
    //MARK: - Pop Up Buttons
    @IBOutlet var printer: NSPopUpButton!
    @IBOutlet var color: NSPopUpButton!
    @IBOutlet var resolution: NSPopUpButton!
    @IBOutlet var infill: NSPopUpButton!
    @IBOutlet var supports: NSPopUpButton!
    @IBOutlet var raft: NSPopUpButton!
    @IBOutlet var schoolList: NSPopUpButton!
    @IBOutlet var hours: NSComboBox!
    @IBOutlet var minutes: NSComboBox!
    @IBOutlet var purpose: NSPopUpButton!
    
    //MARK: - Instances for right side of window
    @IBOutlet var infoTable: NSTableView!
    @IBOutlet var rightSideTitle: NSTextField!
    @IBOutlet var totalNumberOfFiles: NSTextField!
    @IBOutlet var totalUsage: NSTextField!
    @IBOutlet var totalPrice: NSTextField!
    var numberArray = [Double]();
    
    //MARK: - Arrays to store the info of the different files
    var fileCol = [String]()
    var usageCol = [String]()
    var priceCol = [String]()
    var timeCol = [String]()
    var allMyInfo = [String]();
    var arrayOfFileLocations = [String]();
    
    //MARK: - Other useful intance variables
    var printFileName: NSString = "";
    
    //MARK: - User inputted values
    var projectNameSelection: String = "";
    var nameSelection: String = "";
    var phoneNumberSelection: String = "";
    var netIdSelection: String = "";
    var schoolSelection: String = "";
    var printerSelection: String = "";
    var colorSelection: String = "";
    var resolutionSelection = "";
    var raftSelection: String = "";
    var supportSelection: String = "";
    var infillSelection: String = "";
    
    var usageValue: Double = 0.0;
    var usageType: String = "";
    var usageSelection: String = "";
    
    
    var gramSelection: Bool = true;
    var mLSelection: Bool = false;
    var timeSelection: String = "";
    var awarenessSelection: String = "";
    var orientationSelection: String = "";
    var baseSelection: String = "";
    var purposeSelection: String = "";
    var fileLocationSelection: NSString = "";
    var dateString: String = "";
    
    //MARK: - Labels for text fields used for input validation
    @IBOutlet weak var usageLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var fileLabel: NSTextField!
    @IBOutlet var netIdLabel: NSTextField!
    @IBOutlet var nameLabel: NSTextFieldCell!
    @IBOutlet var printerLabel: NSTextField!
    
    //MARK: - Array for holding print order objects
    var printOrderArray = [PrintOrder]();
    
    //MARK: - Reference to main controller queue
    var mainWindow: MainViewController?;
    var semester: String?;
    var colorList = [String]();
    var printerList = [String]();
    var printerFileDict = [String: [String]]();
    
    
    //MARK: - methods for populating the drop down menu buttons on the main window
    //------------------------------------Add Printer List-------------------------------------------------------
    func doAddItemsToPrintList() -> Void{
        printer.addItems(withTitles: self.printerList);
    }
    //------------------------------------Add Color List---------------------------------------------------------
    
    func doAddItemsToColorList() -> Void{
        color.addItems(withTitles: self.colorList);
    }
    //------------------------------------Add Infill List----------------------------------------------------------
    func doAddItemsToInfillList() -> Void{
        infill.addItems(withTitles: ["10%", "20%", "30%", "40%", "50%", "60%","70%", "80%","90%", "100%"]);
    }
    
    //------------------------------------Add Support Option------------------------------------------------------
    func doAddItemsToSupportList() -> Void{
        supports.addItems(withTitles: ["Yes", "No"]);
    }
    
    //------------------------------------Add Raft Option---------------------------------------------------------
    func doAddItemsToRaftList() -> Void{
        raft.addItems(withTitles: ["Yes", "No"]);
    }
    
    //------------------------------------Add Resolution List-----------------------------------------------------
    func doAddItemsToResolutionList() -> Void{
        resolution.addItems(withTitles: [".3", ".2", ".1", ".05", ".025"]);
    }
    //------------------------------------Add Schools List-----------------------------------------------------
    func doAddItemsToSchoolList() -> Void{
        schoolList.addItems(withTitles: ["Emory College", "Staff", "Oxford College", "Business", "Law", "Medicine", "Nursing", "Public Health", "Theology", "Laney"]);
    }
    //------------------------------------Add Purpose List-----------------------------------------------------
    
    func doAddItemsToPurposeList() -> Void{
        purpose.addItems(withTitles: ["Personal Use","Academic Use"]);
    }
    //------------------------------------Add Minutes List-----------------------------------------------------
    
    func doAddItemsToMinutesList()-> Void {
        for i in 0...59{
            minutes.addItems(withObjectValues: [i]);
        }
    }
    //------------------------------------Add Hours List-----------------------------------------------------
    
    func doAddItemsToHoursList()-> Void {
        for i in 0...100{
            hours.addItems(withObjectValues: [i])
        }
    }
    //------------------------------------View Did Load-------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //setting values passed in from settings tabs
        self.semester = self.mainWindow?.semester;
        self.colorList = (self.mainWindow?.colorList)!;
        self.printerList = (self.mainWindow?.printerList)!;
        self.printerFileDict = (self.mainWindow?.printerFileDict)!;
        
        
        self.doAddItemsToPrintList();
        self.doAddItemsToColorList();
        self.doAddItemsToInfillList();
        self.doAddItemsToResolutionList();
        self.doAddItemsToSupportList();
        self.doAddItemsToRaftList();
        self.doAddItemsToSchoolList();
        self.doAddItemsToPurposeList();
        self.doAddItemsToMinutesList();
        self.doAddItemsToHoursList();
        
    }
    
    
    //------------------------------------Clear All Selection------------------------------------------------------
    
    @IBAction func clearAll(_ sender: AnyObject) {
        
        projectName.stringValue = "";
        name.stringValue = "";
        phoneNumber.stringValue = "";
        netId.stringValue = "";
        usage.stringValue = "";
        fileLocation.stringValue = "";
        
        self.doAddItemsToPrintList();
        self.doAddItemsToColorList();
        self.doAddItemsToInfillList();
        self.doAddItemsToResolutionList();
        self.doAddItemsToSupportList();
        self.doAddItemsToRaftList();
        self.doAddItemsToSchoolList();
        self.doAddItemsToPurposeList();
        
        hours.stringValue = "0";
        minutes.stringValue = "0";
        
        usageLabel.textColor = NSColor.black;
        timeLabel.textColor = NSColor.black;
        fileLabel.textColor = NSColor.black;
        
        rightSideTitle.stringValue = "";
        totalNumberOfFiles.stringValue = "";
        totalPrice.stringValue = "";
        totalUsage.stringValue = "";
        
        fileCol.removeAll(keepingCapacity: true);
        usageCol.removeAll(keepingCapacity: false);
        priceCol.removeAll(keepingCapacity: true);
        timeCol.removeAll(keepingCapacity: true);
        numberArray.removeAll(keepingCapacity: true);
        arrayOfFileLocations.removeAll(keepingCapacity: true);
        allMyInfo.removeAll(keepingCapacity: true);
        
        infoTable.reloadData();
        
        
    }
    
    //------------------------------------Browse For File-------------------------------------------------------
    
    @IBAction func browse(_ sender: AnyObject) {
        
        let panel = NSOpenPanel();
        panel.allowsMultipleSelection = false;
        panel.canChooseFiles = true;
        panel.canChooseDirectories = false;
        panel.runModal();
        var filePath: URL?;
        
        
        if (!panel.urls.isEmpty){
            filePath = URL(fileURLWithPath: panel.urls[0].path)
        }
        
        let fileExtenion = filePath?.pathExtension;
        
        
        
        //Input validation for the file extension.
        var validFileExtension = false;
        
        for key in (self.mainWindow?.printerFileDict.keys)!{
            if( self.mainWindow?.printerFileDict[key]?.index(of: fileExtenion!) != nil){
                validFileExtension = true;
                break;
            }
        }
        if(validFileExtension){
            fileLocation.stringValue = filePath!.path// as String;
            fileLabel.textColor = NSColor.black;
        }
        else if (fileExtenion == ""){
            return
        }
        else{
            
            let fileExtensionErrorPopUp = NSAlert();
            fileExtensionErrorPopUp.messageText = "\tInvalid file extension error\n\nPlease choose a file with one of the appropriate file extensions for the 3D Printers: \n\nFor Example: \n\n .thing (Makerbot) \n .form (PreFrom) \n .amf   (Cura)"
            fileExtensionErrorPopUp.runModal();
            fileLabel.textColor = NSColor.red;
        }
        
        
    }
    //------------------------------------Name and NetId Validation-------------------------------------------------------
    
    //Checks whether the user entered their full name, first and last name and a "valid" netId
    func validateNameandNetId(_ name: String, netIdString: String)-> (errorExist: Bool, message: String){
        var errorMess = "";
        var hasError = false;
        let tempName = (name).trimmingCharacters( in: CharacterSet.whitespacesAndNewlines);
        
        if(!tempName.contains(" ")){
            hasError = true;
            nameLabel.textColor = NSColor.red;
            errorMess = "\n\tPlease enter your first and last name: \n\t\t ex: Daenerys Targaryen";
        }else{
            nameLabel.textColor = NSColor.black;
        }
        if(netIdString.characters.count == 0 || Int(netIdString.substring(to: netIdString.characters.index(netIdString.startIndex, offsetBy: 1))) != nil){
            hasError = true;
            errorMess += "\n\n\t Please enter your NetID: \n\t\t ex: dtarg34";
            netIdLabel.textColor = NSColor.red;
        }
        else{
            netIdLabel.textColor = NSColor.black;
            
        }
        
        return(hasError, errorMess);

    }
    
    //------------------------------------Usage Validation-------------------------------------------------------
    
    //Checks if the user inputted any non numeric inputs in the usage field as well as ensures the user did indeed input something
    func validateUsage(_ usageStr: String)->(errorExist: Bool, message: String){
        var hasError = false;
        var errorMess = "";
        for char in usageStr.characters{
            //If the character is not a number or a decimal point, an error message will be generated.
            if(  (char >= "\u{30}" && char <= "\u{39}") || char == "\u{2E}"){
                usageLabel.textColor = NSColor.black;
                continue;
            }
            else{
                hasError = true;
                errorMess = "--> Please enter only numbers or decimals into the usage section.";
                usage.stringValue = "";
                usageLabel.textColor = NSColor.red;
                break;
            }
            
        }
        //If the user did not enter any information in the usage section
        if(usageStr.isEmpty){
            hasError = true;
            errorMess = "--> Please input the estimated material usage.";
            usageLabel.textColor = NSColor.red;
        }
        
        return(hasError, errorMess);

    }
    
    //------------------------------------Time Validation-------------------------------------------------------
    
    //Checks if the user inputted any non numeric inputs in the time field as well as ensures the user did indeed input something
    func validateTime(_ hrs: String, min: String)->(errorExist: Bool, message: String){
        var hasError = false;
        var errorMess = "";
        
        let hoursAndMinutes = hrs + min;
        
        //If the user entered a non numeric number
        for char in hoursAndMinutes.characters{
                if( char >= "\u{30}" && char <= "\u{39}"){
                timeLabel.textColor = NSColor.black;
                continue;
            }
            else{
                hasError = true;
                errorMess = "--> Please enter only numbers in the time section.";
                hours.stringValue = "0";
                minutes.stringValue = "0";
                timeLabel.textColor = NSColor.red;
                break;
            }
        }
        
        //If the user entered 0 hours and 00 minutes
        if( Int(hoursAndMinutes) == 0){
            hasError = true;
            timeLabel.textColor = NSColor.red;
            errorMess = "--> The time of the print cannot be 0:00.";
            
        }
        
        
        //If the user did not enter any information in the time section
        if(hoursAndMinutes.characters.count == 0){
            hasError = true;
            errorMess = "--> Please enter the estimated time of the print.";
            hours.stringValue = "0";
            minutes.stringValue = "0";
            timeLabel.textColor = NSColor.red;
        }
        
        return(hasError, errorMess);
        
    }
    
    //------------------------------------File Exist Validation-------------------------------------------------------
    
    //Checks whether a file exists at the given inputted path
    func validateFile(_ filePath: String)->(errorExist: Bool, messgae: String){
        var hasError = false;
        var errorMess = "";
        
        let manager: FileManager = FileManager.default;
        
        //If the user did not enter or a file or entered an invalide file path, the error message will be generated
        if( (fileLocationSelection == "") || !(manager.fileExists(atPath: fileLocationSelection as String))){
            hasError = true;
            errorMess = "--> Please choose or enter a valid file.";
            fileLocation.stringValue = "";
            fileLabel.textColor = NSColor.red;
        }
        else{
            fileLabel.textColor = NSColor.black;
        }
    
        return(hasError, errorMess);
    }
    
    //------------------------------------Printer and File Type Match Validation-------------------------------------------------------
    
    //Checks whether the choosen file matches its corresponding printer
    func validatePrinterFileMatch(_ filePath: NSString, printer: String)->(errorExist: Bool, message: String){
        
        var hasError = false;
        var errorMess = "";
    
        let fileExtension = filePath.pathExtension;
        
        
        if( printerFileDict[printer]?.index(of: fileExtension) == nil ) {
            hasError = true;
            errorMess = "\t\t\t\t😱 \n\t \tPrinter and File Mismatch Error\n\nPlease make sure the file being loaded corresponds to the correct printer: \n\nFor Example:\n .thing (Replicator) \n .form (Form1+) \n .amf   (TAZ)";
            printerLabel.textColor = NSColor.red;
            fileLabel.textColor = NSColor.red;
        }

        
        
        return(hasError, errorMess);
        
    }
    
    //------------------------------------Add-------------------------------------------------------
    //gathers all the user entered information
    @IBAction func addFile(_ sender: AnyObject) {
        
        printerSelection = printer.titleOfSelectedItem!;
        nameSelection = name.stringValue;
        colorSelection = color.titleOfSelectedItem!;
        infillSelection = infill.titleOfSelectedItem!;
        supportSelection = supports.titleOfSelectedItem!;
        raftSelection = raft.titleOfSelectedItem!;
        resolutionSelection = resolution.titleOfSelectedItem!;
        schoolSelection = schoolList.titleOfSelectedItem!;
        netIdSelection = netId.stringValue;
        
        usageSelection = usage.stringValue;
        
        projectNameSelection = projectName.stringValue;
        phoneNumberSelection = phoneNumber.stringValue;
        fileLocationSelection = fileLocation.stringValue as NSString;
        purposeSelection = purpose.titleOfSelectedItem!;
        
        
        let today: Date = Date();
        let dateFormat: DateFormatter = DateFormatter();
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
        dateString = dateFormat.string(from: today);
 
        
        if ( (projectNameSelection as String).characters.count == 0) {
            projectNameSelection = "Please Choose a Project Name";
        }
 
        //---Name and NetId input validation
        let valName = validateNameandNetId(nameSelection, netIdString: netIdSelection);
        if(valName.errorExist){
            let nameError = NSAlert();
            nameError.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
            nameError.messageText = "\t\t\t\t\t😱" + valName.message;
            nameError.runModal();
            return;
        }
       

        
        let inputErrorPopUp = NSAlert();
        inputErrorPopUp.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
        var usageInputError = ""
        var timeInputError = "";
        var fileInputError = "";
        var inputErrorAlert = false;
        
        //---Usage input validation
        let valUsage = validateUsage(usageSelection);
        if(valUsage.errorExist){
            usageInputError = valUsage.message;
            inputErrorAlert = true;
        }

        //---Time input validation
        let valTime = validateTime(hours.stringValue, min: minutes.stringValue);
        if(valTime.errorExist){
            timeInputError = valTime.message;
            inputErrorAlert = true;
        }
        
        //---File input validaletion
        let valFile = validateFile(fileLocationSelection as String);
        if(valFile.errorExist){
            fileInputError = valFile.messgae;
            inputErrorAlert = true;
        }
  
        var tempArray = [usageInputError, timeInputError, fileInputError];
        var tempString = String();
        
        for i in 0...2{
            if( tempArray[i] == ""){
                continue;
            }
            else{
                tempString = tempString + tempArray[i] + "\n";
            }
        }
        //If any input error occured with usage, time, or file, an alert window will open with details about the error(s)
        if(inputErrorAlert){
            inputErrorPopUp.messageText = "\t\t\t\t😱\n\t\tCorrect the following:\n\n" + tempString;
            inputErrorPopUp.runModal();
            return;
        }
        
        if(hours.stringValue.characters.count == 0){
            hours.stringValue = "0";
        }
        if(minutes.stringValue.characters.count == 0){
            minutes.stringValue = "0";
        }
        
        timeSelection = String(format: "%02d:%02d:00", Int(hours.stringValue)!, Int(minutes.stringValue)!);
        usageValue = Double(usage.stringValue)!;
        
        //--Printer File Match validation
        let valPrintFileMatch = validatePrinterFileMatch(fileLocationSelection, printer: printerSelection);
        if(valPrintFileMatch.errorExist){
            let printerFileError = NSAlert();
            printerFileError.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
            printerFileError.messageText = valPrintFileMatch.message;
            printerFileError.runModal();
            return;
        }
        
        usageLabel.textColor = NSColor.black;
        timeLabel.textColor = NSColor.black;
        fileLabel.textColor = NSColor.black;
        printerLabel.textColor = NSColor.black;
        
        let temp = " Name: \(nameSelection) \n Phone number: \(phoneNumberSelection) \n Date: \(dateString) \n NetID: \(netIdSelection) \n School: \(schoolSelection) \n \n Printer Type: \(printerSelection) \n Color Preference: \(colorSelection) \n Infill Preference: \(infillSelection) \n Supports: \(supportSelection) \n Raft: \(raftSelection) \n Resolution: \(resolutionSelection) \n \n Estimated Material Usage: \((usageSelection as String) + getUsageUnits()) \n Estimated Time to print: \(timeSelection) \n \n What is this for: \(purposeSelection)";
        
        
        allMyInfo.append(temp);
        rightSideTitle.stringValue = projectNameSelection as String;
        printFileName = fileLocationSelection.lastPathComponent as NSString;
        
        fileCol.append(printFileName as String);
        arrayOfFileLocations.append(fileLocationSelection as String);
        priceCol.append("$\(calculatePrice()).00");
        timeCol.append(timeSelection as String);
        
        //logic to determine whether the usage type for the print is in grams or milliliters
        if( gramSelection){
            usageCol.append( (usageSelection as String) + "g");
            
        }
        else{
            usageCol.append( (usageSelection as String) + "mL");
           
        }
        
        
        updateVerificationInfo();
        
        
        //Insert new row in the table view
        let newRowIndex = self.fileCol.count - 1;
        self.infoTable.insertRows(at: IndexSet(integer: newRowIndex), withAnimation: NSTableViewAnimationOptions());
        
        
        //Clears the necesseary text fields and drop down menu items so that the user may add another file to the project
        usage.stringValue = "";
        fileLocation.stringValue = "";
        hours.stringValue = "0";
        minutes.stringValue = "0";
        
        self.doAddItemsToPrintList();
        self.doAddItemsToColorList();
        self.doAddItemsToInfillList();
        self.doAddItemsToResolutionList();
        self.doAddItemsToSupportList();
        self.doAddItemsToRaftList();
        self.doAddItemsToHoursList();
        self.doAddItemsToMinutesList();
        self.doAddItemsToPurposeList();
        
    }
    //------------------------------------Remove File-------------------------------------------------------
    @IBAction func removeSelectedFile(_ sender: AnyObject) {
        
        
        let indexOfObjectToRemove = self.infoTable.selectedRow;
        if(indexOfObjectToRemove >= 0 && indexOfObjectToRemove < fileCol.count){
            
            fileCol.remove(at: indexOfObjectToRemove);
            usageCol.remove(at: indexOfObjectToRemove);
            priceCol.remove(at: indexOfObjectToRemove);
            timeCol.remove(at: indexOfObjectToRemove);
            numberArray.remove(at: indexOfObjectToRemove);
            arrayOfFileLocations.remove(at: indexOfObjectToRemove);
            allMyInfo.remove(at: indexOfObjectToRemove);
            
            infoTable.removeRows(at: IndexSet(integer: indexOfObjectToRemove), withAnimation: NSTableViewAnimationOptions());
         
            updateVerificationInfo();
            
        }
        
    }
    
    //------------------------------------Duplicate File-------------------------------------------------------
    @IBAction func duplicateSelectedFile(_ sender: AnyObject) {
        
        let indexOfObjectToDuplicate = self.infoTable.selectedRow;
        
        if(indexOfObjectToDuplicate >= 0 && indexOfObjectToDuplicate < fileCol.count){
            
            fileCol.append(fileCol[indexOfObjectToDuplicate]);
            usageCol.append(usageCol[indexOfObjectToDuplicate]);
            priceCol.append(priceCol[indexOfObjectToDuplicate]);
            timeCol.append(timeCol[indexOfObjectToDuplicate]);
            numberArray.append(numberArray[indexOfObjectToDuplicate]);
            arrayOfFileLocations.append(arrayOfFileLocations[indexOfObjectToDuplicate]);
            allMyInfo.append(allMyInfo[indexOfObjectToDuplicate]);
            
            let newRowIndex = self.fileCol.count - 1;
            infoTable.insertRows(at: IndexSet(integer: newRowIndex), withAnimation: NSTableViewAnimationOptions());
            
            updateVerificationInfo();
            
            
        }
        
    }
    //------------------------------------Update Verification Info----------------------------------------------
    //writes out the info to the "verify" section of the right side of the window
    func updateVerificationInfo()-> Void{
        
        var totalgrams = 0.0;
        var totalmL = 0.0;
        var total2 = 0.0;
        
        totalNumberOfFiles.stringValue = "\(fileCol.count)";
        
        for item in usageCol{
            
            let temp = (item as NSString).doubleValue
            if(item.hasSuffix("g")){
                totalgrams = totalgrams + temp;
            }
            if(item.hasSuffix("mL")){
                totalmL = totalmL + temp;
            }
            
        }
        totalUsage.stringValue = "\(totalgrams)g, \(totalmL)mL";
        
        for item in numberArray{
            total2 = total2 + item;
        }
        
        totalPrice.stringValue = NSString( format: "$%.2f", total2) as String;
        
    }
    //------------------------------------Usage Units-------------------------------------------------------
    //Logic that determines whether the user selected grams of milliliters as their usage type
    @IBAction func gramUsage(_ sender: AnyObject) {
        
        gramSelection = true;
        mLSelection = false;
        usageType = "g";
        
    }
    @IBAction func mLUsage(_ sender: AnyObject) {
        
        mLSelection = true;
        gramSelection = false;
        usageType = "mL";
        
    }
    
    //------------------------------------Get Usage Units-------------------------------------------------------
    //Returns the correct units for the usage selection
    func getUsageUnits() -> String{
        if(gramSelection && !mLSelection){
            return "g";
        }
        else{
            return "mL";
        }
    }
    //------------------------------------Price Calculation--------------------------------------------------
    //calculates the price of the print job based on the amount of material used
    func calculatePrice() -> Int{
        
        let temp_usageSelection:NSString = usageSelection as NSString;
        let temp_price = temp_usageSelection.doubleValue;
        
        var temp_number = 0;
        
        if (gramSelection && !mLSelection){
            if(temp_price.truncatingRemainder(dividingBy: 100) == 0){
                temp_number =  2 *  Int(temp_price/100);
            }
            else{
                temp_number =  2 * ( 1 + Int(temp_price/100));
                
            }
        }
        else{
            if(temp_price.truncatingRemainder(dividingBy: 100) == 0){
                temp_number =  4 *  Int(temp_price/100);
            }
            else{
                temp_number =  4 * ( 1 + Int(temp_price/100));
                
            }
        }
        numberArray.append(Double(temp_number));
        
        return temp_number;
        
    }
    
    
    //------------------------------------Continue--------------------------------------------------
    
    @IBAction func continueToPackageWindow(_ sender: AnyObject) {
        
      
        
        self.performSegue(withIdentifier: "PackageSegue", sender: sender)
        
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(arrayOfFileLocations.count == 0){
            let notification = NSAlert();
            notification.accessoryView = NSView.init(frame: NSRect(x: 0, y: 0, width: 350, height: 0));
            notification.messageText = "Please choose at least one file.";
            notification.runModal();
            return false;
            
        }
        else{
            return true;
        }
        
        
        
    }
    //------------------------------------Segue------------------------------------------------------
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) ->  Void {
        
        shouldPerformSegue(withIdentifier: "PackageSegue", sender: self);
        
        
        let secondWindow: ViewController1 = segue.destinationController as! ViewController1;
        
        secondWindow.allMyInfo = allMyInfo;
        secondWindow.arrayOfFileNames = fileCol;
        secondWindow.arrayOfUsages = usageCol;
        secondWindow.arrayOfPrices = priceCol;
        secondWindow.arrayOfFileLocations = arrayOfFileLocations;
        secondWindow.arrayOfEstTimes = timeCol;
        
        secondWindow.netId = netIdSelection as NSString;
        secondWindow.projectName = projectNameSelection as NSString;
        secondWindow.name = nameSelection as NSString;
        secondWindow.dateString = dateString as NSString;
        secondWindow.estTime = timeSelection as NSString;
        
        secondWindow.previousWindow = self;
        
        
        
        for i in 0...fileCol.count-1{
            let x: PrintOrder = PrintOrder.init(name: nameSelection as String, netID: netIdSelection as String, date: dateString as String);
            x.setOrderNumber(printOrderArray.count + 1);
            x.setfile(fileCol[i]);
            
            let str: NSString = NSString(string: usageCol[i]);
            var end = 0;
            if(str.hasSuffix("g")){
                end = 1;
            }
            else{
                end = 2;
            }
            let type = str.substring(from: str.length-end);
            let value = Double(str.substring(to: str.length-end));

            x.setMaterialValue(value!);
            x.setTypeOfMaterial(type);
            x.updateMaterial(usageCol[i]);
            x.updateTime(timeCol[i]);
            x.updatePrice(priceCol[i]);
            x.setSchoolAssocation(schoolSelection);
            x.setColorOfMaterial(colorSelection);
            self.printOrderArray.append(x);
            
        }
        
        secondWindow.printOrderArray = self.printOrderArray;
        secondWindow.mainWindow = self.mainWindow;
        
        
        
    }
    
}



// MARK: - NSTableViewDataSource
extension ViewController: NSTableViewDataSource{
    
    
    //------------------------------------Number of rows in table view-------------------------------------------------------
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return self.fileCol.count
        
    }
    
    //------------------------------------Table View-------------------------------------------------------
    
    func tableView(_ tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        let view: NSTableCellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
        
        //Inserting the file name in the file name column
        if( tableColumn!.identifier == "fileNameColumn"){
            view.textField!.stringValue = fileCol[row]
            
        }
            
            //Inserting the usage amount in the usage column
        else if( tableColumn!.identifier == "usageColumn"){
            
            
            view.textField!.stringValue = usageCol[row];
            
        }
            
            //Inserting the price of the print in the price column
        else  if( tableColumn!.identifier == "priceColumn"){
            
            view.textField!.stringValue = priceCol[row];
            
        }
            
            //Inserting the time of the print in the time column
        else {
            
            view.textField!.stringValue = timeCol[row]
            
        }
        
        return view;
        
    }
}

