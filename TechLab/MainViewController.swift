//
//  MainViewController.swift
//  TechLab
//
//  Created by template on 1/14/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa
import Foundation
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

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}



class MainViewController: NSViewController {
    
    var printOrderArray = [PrintOrder]();
    var semester: String = "";
    
    //These are hard coded initial values for the colors, printers, and the applicable file types for each of these printers
    var colorList = ["white", "black", "clear", "grey", "red", "blue", "green", "gold"];
    var printerList = ["Replicator", "Form1+", "TAZ"];
    var printerFileDict = ["Replicator": ["thing"], "Form1+": ["form"], "TAZ": ["amf"] ];
    
    @IBOutlet var mainTable: NSTableView!;
    
    //------------------------------------View Did Load------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.initSemester();
    }

    //------------------------------------Add Print Job Order------------------------------------------------------

    @IBAction func addOrder(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "addOrderSegue", sender: sender);
        
        
    }
    
    
    //------------------------------------Add Order Segue------------------------------------------------------

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) ->  Void {
        let infoWindow: ViewController = segue.destinationController as! ViewController;
        
        infoWindow.printOrderArray = self.printOrderArray;
        infoWindow.mainWindow = self;
        
    }
   
    //------------------------------------Initialize Semester------------------------------------------------------
    //Logic that gets the current date and finds the corresponding current semester
    func initSemester() -> Void {
        
        let today: Date = Date();
        let dateFormat: DateFormatter = DateFormatter();
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
        let dateString = dateFormat.string(from: today);
        
        var temp = dateString.components(separatedBy: "/");
        let month: String = temp[0];
        let day: String = temp[1];
        let year: String = temp[2];
        
        var term: String = "";
        
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
        else{
            term = "Error";
        }
        term += "\(year)";
        
        self.semester = term;
    }
    
}

// MARK: - NSTableViewDataSource
extension MainViewController: NSTableViewDataSource{
    
    
    //------------------------------------Number of rows in table view-------------------------------------------------------
    
    func numberOfRows(in tableView: NSTableView) -> Int {

        return printOrderArray.count;
        
    }

    //------------------------------------Table View-------------------------------------------------------
    
    func tableView(_ tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        let view: NSTableCellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
       //Inserting the print order data into the main view table
        let x = printOrderArray[row];

        switch tableColumn!.identifier {
            case "queueNumberColumn" : view.textField!.stringValue = "\(x.orderNumber!)";
            case "customerNameColumn" : view.textField!.stringValue = x.customerName!;
            case "customerNetIDColumn" : view.textField!.stringValue = x.netID!;
            case "dateColumn" : view.textField!.stringValue = x.date!;
            case "fileNameColumn" : view.textField!.stringValue = x.file!;
            case "colorColumn" : view.textField!.stringValue = x.materialColor!;
            case "paidColumn" : view.textField!.stringValue = "\(x.paidFor)";
            case "completedColumn" : view.textField!.stringValue = "\(x.completed)";
            case "emailSentColumn" : view.textField!.stringValue = "\(x.emailSent)";
            case "materialColumn" : view.textField!.stringValue = x.material!;
            case "timeColumn" : view.textField!.stringValue = x.time!;
            case "priceColumn" : view.textField!.stringValue = x.price!;
            case "locationColumn" : view.textField!.stringValue = "";
            default : view.textField!.stringValue = "Error";
        }
        return view;
        
    }
}
