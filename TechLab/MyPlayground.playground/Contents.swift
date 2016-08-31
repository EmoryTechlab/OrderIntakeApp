//: Playground - noun: a place where people can play

import Cocoa








//let today: NSDate = NSDate();
//let dateFormat: NSDateFormatter = NSDateFormatter();
//dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
//let dateString = dateFormat.stringFromDate(today);
//
//var temp = Int(dateString.componentsSeparatedByString("/")[2]);


let today: NSDate = NSDate();
let dateFormat: NSDateFormatter = NSDateFormatter();
dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/yyyy");
let dateString = dateFormat.stringFromDate(today);

var temp = dateString.componentsSeparatedByString("/");
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

var test = "TestMe"
var lower = test.lowercaseString;