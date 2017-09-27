//
//  Login.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-10-17.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreData
class Login: UIViewController{
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblEmailRequired: UILabel!
    @IBOutlet weak var lblPasswordRequired: UILabel!
    @IBOutlet weak var lblEmailHeading: UILabel!
    @IBOutlet weak var lblPasswordHeading: UILabel!
    @IBOutlet weak var lblEmailPlaceHolder: UILabel!
    @IBOutlet weak var lblPasswordPlaceholder: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //Dont show the heading unless the keyboard is up
        
        //Hide the error messages and the heading placeholders
        lblEmailRequired.isHidden = true
        lblPasswordRequired.isHidden = true
        lblEmailHeading.isHidden = true
        lblPasswordHeading.isHidden = true
    }
    
    
    func show_hideErros(){
        
        if  lblEmailRequired.isHidden == true || lblPasswordRequired.isHidden == true{
            lblEmailRequired.isHidden = false
            lblPasswordRequired.isHidden = false
            
        }else{
            lblEmailRequired.isHidden = true
            lblPasswordRequired.isHidden = true
        }
        
    }
    
    
    
    @IBAction func txtPasswordClicked(_ sender: Any) {
        lblPasswordPlaceholder.isHidden = true
        lblPasswordHeading.isHidden = false
        
        
    }
    @IBAction func txtPasswordChanged(_ sender: Any) {
        
        lblPasswordPlaceholder.isHidden = true
        lblPasswordHeading.isHidden = false
        
        if txtPassword.text == "" {
            lblPasswordHeading.isHidden = true
            
            lblPasswordPlaceholder.isHidden = false
            
        }
        
        
    }
    
    @IBAction func txtEmailClicked(_ sender: Any) {
        lblEmailRequired.isHidden = true
        lblEmailPlaceHolder.isHidden = true
        lblEmailHeading.isHidden = false
        viewEmail.backgroundColor = UIColor(red: 184, green: 184, blue: 184)
    }
    
    @IBAction func txtEmailChanged(_ sender: Any) {
        
        lblEmailPlaceHolder.isHidden = true
        lblEmailHeading.isHidden = false
        if txtEmail.text == "" {
            lblEmailHeading.isHidden = true
            
            lblEmailPlaceHolder.isHidden = false
            
            
        }
    }
    
    @IBAction func btnSeePassword(_ sender: Any) {
        
        if txtPassword.isSecureTextEntry == false{
            
            txtPassword.isSecureTextEntry = true
            
        }else{
            txtPassword.isSecureTextEntry = false
        }
        
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - btnSignUp.frame.height
                
                
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
                
                
            }
            
        }
    }
    
    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        
        if  (txtEmail.text?.isEmail() == false){
            
            viewEmail.backgroundColor = UIColor(red: 216, green: 41, blue: 47)
            lblEmailRequired.isHidden = false
        }
            
        else if txtPassword.text?.isValidPassword() == false{
            
            
        }
            
        else{
            //   if "call is going through" {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                
                self.view.lock(headingText:"Air Canada mobile+",loadingText:"Signing in...", lowerLoadingText: nil)
                // self.view.unlock()
            }
        }
        //DO THE Logic, use a closure in the http call and when it returns unlock the screen
        
        //        DispatchQueue.main.async {
        //            self.view.unlock()
        //        }
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

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


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
