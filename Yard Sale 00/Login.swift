//
//  Login.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-10-17.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import AWSDynamoDB
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
        viewPassword.backgroundColor = UIColor.white
        //lblPasswordRequired.isHidden = true

        
        
    }
    @IBAction func txtPasswordChanged(_ sender: Any) {
        
        lblPasswordPlaceholder.isHidden = true
        lblPasswordHeading.isHidden = false
        viewPassword.backgroundColor = UIColor.white
        lblPasswordRequired.isHidden = true
//
//        if txtPassword.text == "" {
//            lblPasswordHeading.isHidden = true
//            
//            lblPasswordPlaceholder.isHidden = false
//            
//        }
        
        
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
            
        else if (txtPassword.text?.characters.count)! <= 8{
            
            viewPassword.backgroundColor = UIColor(red: 216, green: 41, blue: 47)
            lblPasswordRequired.isHidden = false
        }else{
            //   if "call is going through" {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                
                self.view.lock(headingText:"Air Canada mobile+",loadingText:"Signing in...", lowerLoadingText: nil)
                // self.view.unlock()
                
                let objectMapper = AWSDynamoDBObjectMapper.default()
                let scanExpression = AWSDynamoDBScanExpression()
                
                scanExpression.filterExpression = "#BusinessEmail = :BusinessEmail AND #password = :password"
                scanExpression.expressionAttributeNames = ["#BusinessEmail": "BusinessEmail","#password": "password"]
                scanExpression.expressionAttributeValues = [":BusinessEmail": self.txtEmail.text! ,":password": self.txtPassword.text!, ]
                
                objectMapper.scan(Businesses.self, expression: scanExpression) { (response: AWSDynamoDBPaginatedOutput?, error: Error?) in
                    DispatchQueue.main.async(execute: {
                        if response != nil{
                            self.view.unlock(statusCode: 200)
                            if response?.items.count == 1{
                               AppController.shared.isCustomLogin = true
                               AppController.shared.usersBusiness?._password = self.txtPassword.text!

                                
                                for item in (response?.items)!{
                                  if let pulledBusiness = item as? Businesses{
                                        AppController.shared.usersBusiness = pulledBusiness
                                    
                                    }
                                }
                                self.performSegue(withIdentifier: "homeVCSegue", sender: nil)
                            }else{
                                self.view.unlock(statusCode: 500)
                                LoginAlerts.genericAlert(viewController: self, title: "Invalid Email or Password", message: "We could not find an account linked to that email and password.")
                            }

                        }else{
                            self.view.unlock(statusCode: 500)
                            print(error)
                            LoginAlerts.genericAlert(viewController: self, title: "Invalid Email or Password", message: "We could not find an account linked to that email and password.")
                        }
                    })
                }
                
                
            }
        }
    }

    //MARK REGISTERING
    @IBAction func btnRegisterClicked(_ sender: Any) {
        
        if  (txtEmail.text?.isEmail() == false){
            
            viewEmail.backgroundColor = UIColor(red: 216, green: 41, blue: 47)
            lblEmailRequired.isHidden = false
        }
            
        else if (txtPassword.text?.characters.count)! <= 8{
            viewPassword.backgroundColor = UIColor(red: 216, green: 41, blue: 47)
            lblPasswordRequired.isHidden = false
        }else{
            self.view.lock(headingText: nil, loadingText: "Registering", lowerLoadingText: nil)
       
            AppController.shared.usersBusiness?._password = self.txtPassword.text!
            AppController.shared.usersBusiness?._businessEmail = self.txtEmail.text!
            
            NoSqlManager.saveBusiness(businessName:nil, businessCategory: nil, businessDescription: nil, businessEmail: txtEmail.text, businessImage: nil, businessLatidude: nil, businessLongitude: nil, businessPhone: nil, businessWebsite: nil, mondayHours: nil, tuesdayHours: nil, wednesdayHours: nil, thusdayHours: nil, fridayHours: nil, saturdayHours: nil, sundayHours: nil, isBusinessActive: false, firstName: AppController.shared.usersBusiness?._firstName,lastName:AppController.shared.usersBusiness?._lastName,password:txtPassword.text, completion: { (status) in
                DispatchQueue.main.async {
                    AppController.shared.usersBusiness?._activeBusiness = true
                    AppController.shared.isCustomLogin = true
    
                self.view.unlock(statusCode: 200)
                }
                LoginAlerts.genericAlert(viewController: self, title: "Congradulations", message: "You are registered")

                print(status)
            })
        }
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
