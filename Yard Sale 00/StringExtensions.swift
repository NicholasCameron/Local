//
//  StringExtensions.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-01.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit


extension String {
    
    /**
     Funtion to determine if a given string is a valid email address.
     
     - Returns: true indicating valid email address or false for invalid email address.
     */
    func isEmail() -> Bool {
        
        let emailRegex = "[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
        
        let matchPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return matchPredicate.evaluate(with: self) == true ? true : false
    }
    
    /**
     Funtion to determine if a given string is a valid Canadian Postal Code.
     
     - Returns: true indicating valid Canadian Postal Code or false for invalid Canadian Postal Code.
     */
    func isPostalCode() -> Bool {
        
        let postalCodeRegex = "^[ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1} *\\d{1}[A-Z]{1}\\d{1}$"
        
        let matchPredicate = NSPredicate(format: "SELF MATCHES %@", postalCodeRegex)
        
        return matchPredicate.evaluate(with: self) == true ? true : false
    }
    
    /**
     Funtion to determine if a given string is a valid US Zip Code.
     
     - Returns: true indicating valid US Zip Code or false for invalid US Zip Code.
     */
    func isZipCode() -> Bool {
        
        let zipCodeRegex = "^\\d{5}(-\\d{4})?$"
        
        let matchPredicate = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        
        return matchPredicate.evaluate(with: self) == true ? true : false
    }
    
    /**
     Funtion to determine if a given string is a valid password.
     
     - Returns: true indicating valid password or false for invalid password.
     */
    func isValidPassword() -> Bool {
        
        let passcodeRegex = "^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$"
        
        let matchPredicate = NSPredicate(format: "SELF MATCHES %@", passcodeRegex)
        
        return matchPredicate.evaluate(with: self) == true ? true : false
    }
    
    func isCity() -> Bool {
        
        let cityRegex = "^([A-Za-z'._#& -])+"
        
        let matchPredicate = NSPredicate(format: "SELF MATCHES %@", cityRegex)
        
        return matchPredicate.evaluate(with: self) == true ? true : false
    }
    
    func isAddress() -> Bool {
        if (!isEmpty) {
            let accentedCharacters = "àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ"
            let addressRegex = "^([A-Za-z0-9"+accentedCharacters+"'._#& -])+"
            
            let matchPredicate = NSPredicate(format: "SELF MATCHES %@", addressRegex)
            
            return matchPredicate.evaluate(with: self) == true ? true : false
        } else {
            return true
        }
        
    }
    
    
}


