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
    var photoTaken = false;
    var emailSent = false;
    
    var materialValue: Double?;
    var materialType: String?;
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
    
    
    ///-----Update/Set Functions
    func setOrderNumber(input: Int) -> Void{
        self.orderNumber = input;
    }
    
    func setfile(input: String)-> Void {
        self.file = input;
    }
    
    
    func updatePaidFor() ->Void{
        
        self.paidFor = !self.paidFor;
        
    }
    
    
    func updateCompleted() -> Void{
        
        self.completed = !self.completed;
        
    }
    
    func updatePhotTaken() -> Void{
        
        self.photoTaken = !self.photoTaken;
        
    }
    
    func updateEmailSent() -> Void{
        
        self.emailSent = !self.emailSent;
        
    }
    
    func setMaterialValue( input: Double) -> Void{
        self.materialValue = input;
    }
    
    func setTypeOfMaterial( input: String) -> Void{
        self.materialType = input;
        
    }
    
    func updateMaterial(input: String) -> Void{
        
        self.material = input;
        
    }
    
    func updateTime( input: String) -> Void{
        
        self.time = input;
        
    }
    
    func updatePrice( input: String) -> Void{
        
        self.price = input;
        
    }
    
    func updateLocation( input: String) -> Void{
        
        self.location = input;
        
    }
    

}
