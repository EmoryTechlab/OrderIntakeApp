//
//  PrintOrder.swift
//  TechLab
//
//  Created by template on 1/19/16.
//  Copyright © 2016 template. All rights reserved.
//

import Cocoa

class PrintOrder: NSObject {
    
    var orderNumber: Int?;
    var customerName: String?;
    var netID: String?;
    var date : String?;
    var file : String?;
    
    var printer: String?;
    var schoolAssociation: String?;
    
    var paidFor = false;
    var completed = false;
    var emailSent = false;
    
    var materialValue: Double?;
    var materialType: String?;
    var materialColor: String?;
    var material: String?;
    
    var time : String?;
    var price : String?;
    var location : String?;
    
    
    
    //-----Constructor
    init(name: String, netID: String, date: String){
       
        self.customerName = name;
        self.netID = netID;
        self.date = date;
        
    }
    
    
    ///-----Set Functions
    func setOrderNumber(_ input: Int) -> Void{
        self.orderNumber = input;
    }
    
    func setfile(_ input: String)-> Void {
        self.file = input;
    }
    func setMaterialValue( _ input: Double) -> Void{
        self.materialValue = input;
    }
    
    func setTypeOfMaterial( _ input: String) -> Void{
        self.materialType = input;
        
    }
    func setColorOfMaterial( _ input: String) -> Void{
        self.materialColor = input;
    }
    func setSchoolAssocation( _ input: String) -> Void{
        self.schoolAssociation = input;
    }
    
    
    
    //-----Update Functions
    func updatePaidFor() ->Void{
        self.paidFor = !self.paidFor;
    }
    func updateCompleted() -> Void{
        self.completed = !self.completed;
    }
    
    func updateEmailSent() -> Void{
        self.emailSent = !self.emailSent;
    }
    
    func updateMaterial(_ input: String) -> Void{
        self.material = input;
    }
    
    func updateTime( _ input: String) -> Void{
        self.time = input;
    }
    
    func updatePrice( _ input: String) -> Void{
        self.price = input;
    }
    
    func updateLocation( _ input: String) -> Void{
        self.location = input;
    }
    

}
