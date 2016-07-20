//
//  MainViewController.swift
//  TechLab
//
//  Created by template on 1/14/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa
import Foundation


class MainViewController: NSViewController{
    
    
    var printOrderArray = [PrintOrder]();
    
    @IBOutlet var mainTable: NSTableView!;
    
    //------------------------------------View Did Load------------------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        
    }

    //------------------------------------Add Print Job Order------------------------------------------------------

    @IBAction func addOrder(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addOrderSegue", sender: sender);
        
        
    }
    
    
    //------------------------------------Add Order Segue------------------------------------------------------

    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) ->  Void {
        let infoWindow: ViewController = segue.destinationController as! ViewController;
        
        infoWindow.printOrderArray = self.printOrderArray;
        infoWindow.mainWindow = self;
        
    }
   
}

// MARK: - NSTableViewDataSource
extension MainViewController: NSTableViewDataSource{
    
    
    //------------------------------------Number of rows in table view-------------------------------------------------------
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {

        return printOrderArray.count;
        
    }

    //------------------------------------Table View-------------------------------------------------------
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        let view: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
       //Inserting the print order data into the main view table
        let x = printOrderArray[row];

        switch tableColumn!.identifier {
            case "queueNumberColumn" : view.textField!.stringValue = "\(x.orderNumber!)";
            case "customerNameColumn" : view.textField!.stringValue = x.customerName!;
            case "customerNetIDColumn" : view.textField!.stringValue = x.netID!;
            case "dateColumn" : view.textField!.stringValue = x.date!;
            case "fileNameColumn" : view.textField!.stringValue = x.file!;
            case "paidColumn" : view.textField!.stringValue = "\(x.paidFor)";
            case "completedColumn" : view.textField!.stringValue = "\(x.completed)";
            case "photoColumn" : view.textField!.stringValue = "\(x.photoTaken)";
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
