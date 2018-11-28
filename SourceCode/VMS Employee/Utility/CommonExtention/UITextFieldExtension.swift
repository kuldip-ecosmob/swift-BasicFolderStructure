//
//  UITextFieldExtension.swift
//  VMS Employee
//
//  Created by Ronak on 04/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    //Input Validations : Mobile Number
    func isShouldChangeMobile(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard let text = self.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        let NUMERIC = "1234567890"
        
        if self.text?.count == 0 && string == "0" {
            return false
        }
        
        var unacceptedInput: NSCharacterSet? = nil
        unacceptedInput = NSCharacterSet(charactersIn: NUMERIC).inverted as NSCharacterSet
        // If there are any characters that I do not want in the text field, return NO.
        if newLength > 10
        {
            return false
        }
        return (string.components(separatedBy: (unacceptedInput as CharacterSet?)!).count <= 1)
    }
    
}
