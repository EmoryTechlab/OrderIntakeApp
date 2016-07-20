//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var a = false;

!a;

str.characters.last;

var test = "2552fsf25";


var value: String = "";

var stringWithoutDigit = (test.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet()) as NSArray).componentsJoinedByString("");


var tempName = ("Jon S").stringByTrimmingCharactersInSet( NSCharacterSet.whitespaceAndNewlineCharacterSet());

tempName.containsString(" ");


var t: NSString = "e0";
var y = t.substringToIndex(1);
var h: Int = Int(t.characterAtIndex(0));


let timeString = String(format: "%02d:%02d:00", 12, 6);

test.substringToIndex(test.startIndex.advancedBy(1))


var tt: Double = 4.00;

var sf = String(format: "$%.2f", tt);


var eli: NSString = NSString(string: "$4.00");
Int(eli.substringFromIndex(1))


var map = NSMapTable();

map.setObject(3, forKey: "Test");

var bo = "52:26:00";

bo.componentsSeparatedByString(":");


var dateString = "05/11/2016";



var ttt = dateString.componentsSeparatedByString("/");
var month: String = ttt[0];
var day: String = ttt[1];
var year: String = ttt[2];

var term: String = "";
// var termWithoutSpace: String = "";

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
// termWithoutSpace = term + year;
term += " \(year)";
        