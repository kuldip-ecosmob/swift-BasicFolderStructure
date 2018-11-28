//
//  StringExtension.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    //To get the length of the String
    var length : Int{
        return count
    }
    
    //To check String is empty or not
    var isEmpty: Bool {
        
        let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmed.length > 0
        {
            return false
        }
        return true
    }
    
    //To check Email is valid or not
    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.length)) != nil
        } catch {
            return false
        }
    }
    
    //To check Phone is valid or not
    
    var isValidaPhone : Bool{
        do{
            let PHONE_REGEX = "^([0-9-() ]+)?(\\.([0-9]{1,2})?)?$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            return phoneTest.evaluate(with: self)
        }
    }
    var isValidaPhoneLength : Bool{
        do{
            return self.length == 10
        }
    }
    var isValidaIndianPhoneNumber : Bool{
        do{

            let char: Character = self.first!
            if let number = Int(String(char)) {
                // use number
                if number > 5{
                    return true
                }
            }
            return false
        }
    }
    
    //To check Email is valid or not
    var isValidUserName: Bool {
        if self.length >= 3{
            return true
        }
        return false
    }
    
    //To validate Password between 6 to 20 valid character
    var isValidaSimplePassword : Bool{
        do{
            return self.length > 5
        }
    }
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.length)) != nil){
                
                if(self.length>=4 && self.length<=20 ){
                    
                    let specialCharRegEx  = ".*[!&^%$#@*()/]+.*"
                    let predicateSpecChar = NSPredicate(format:"SELF MATCHES %@", specialCharRegEx)
                    let containsSpecialChar = predicateSpecChar.evaluate(with: self)
                    
                    let numberRegEx  = ".*[0-9]+.*"
                    let predicateNumber = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
                    let containsNumber = predicateNumber.evaluate(with: self)
                    
                    return true && containsSpecialChar && containsNumber
                }
            }
            return false
        } catch {
            return false
        }
    }
    
    //Validate Expiry date of card
    var isValidateCardExpiryDate: Bool{
        
        let date = self.getDate(pStrFormate: "MM/yyyy")
        if date < Date(){
            return true
        }
        return false
    }
    
    //Validate Decimal value like product price
    func allowOnlyDecimalValue(range: NSRange,string: String) -> Bool{
        
        if string == ""{
            return true
        }
        if self.length == 0 && Int(string) == 0{
            return false
        }
        let textFieldString = self as NSString
        let newString = textFieldString.replacingCharacters(in: range, with:string)
        let floatRegEx = "^([0-9]+)?(\\.([0-9]+)?)?$"
        let floatExPredicate = NSPredicate(format:"SELF MATCHES %@", floatRegEx)
        return floatExPredicate.evaluate(with: newString)
    }
    
    /// To get index of given string
    ///
    /// - Parameters:
    ///   - string: string to get index
    ///   - options: string compare options
    /// - Returns: returns Index value of string
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    /// For getting date from string with given formate
    ///
    /// - Parameter pStrFormate: pStrFormate formate to set
    /// - Returns: returns date value
    func getDate(pStrFormate : String? = DATEFORMATE.WEBSERVICEFORMDATETIME) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pStrFormate
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    /// For getting date from string with given formate
    ///
    /// - Parameter pStrFormate: pStrFormate formate to set
    /// - Returns: returns string date value
    func getDateStringFromString(pStrFormate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pStrFormate
        let date = dateFormatter.date(from: self)
        return dateFormatter.string(from: date!)
    }
    
    // (UTC TO LOCAL) String to string
    var convertUTCStringToLocalDate: Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = timeZone
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    //Convert string from Formated Phone to Simple Phone String (EX. (xxx) xxx-xxxx  ->  xxxxxxxxxx )
    var convertToSimplePhoneString:String{
        return self.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
    }
    //Convert string from Formated Phone to Simple Phone String (EX. xxxxxxxxxx -> (xxx) xxx-xxxx )
    var convertToFormatedPhoneString:String{
        var strUpdated = self.convertToSimplePhoneString
        strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 3))
        strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 7))
        return strUpdated
    }
    
    //Convert string to secure string like (ex: 9999999999 -> 99******99, test@gmail.com -> te**********om)
    var secureStringText : String  {
        
        if self.length > 0{
            return /*self.prefix(2) +*/ String(repeating: "*", count: self.length-4) + self.suffix(4)
        }
        return ""
    }
    
    //Convert 24 Hour time to 12 Hour Time
    var timeTo12Hour : String {
        if self.length == 0{
           return ""
        }
        //let dateAsString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "hh:mm a"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
    }
    
    //Convert 24 Hour time to 12 Hour Time
    var timeTo24Hour : String {
        if self.length == 0{
            return ""
        }
        
        //let dateAsString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "HH:mm"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
    }
    
    func countryCode(code : String) -> String {
        var tempCode = code
        tempCode.remove(at: tempCode.startIndex)
        return tempCode
    }
    
}
