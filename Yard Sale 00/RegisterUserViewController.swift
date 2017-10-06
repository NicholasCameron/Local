//
//  RegisterUserViewController.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-02.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import KeychainSwift

class RegisterUserViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lblWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageFish: UIImageView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblChangingHeader: UILabel!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var txtTextBox: UITextField!
    var middleLabel = CGPoint();
    var counterLabel = 1
    let screenSize: CGRect = UIScreen.main.bounds

    
    var firstName = String()
    var lastName = String()
    var emailAddress = String()
    var phoneNumber:String?
    var password = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animateFish()
        setupView()
        txtTextBox.delegate = self
    }
    
    
    func animateFish(){
       let r = self.imageFish.frame;
        self.imageFish.frame = r;
        UIView.animate(withDuration: 15.0, delay: 0, options: [], animations: {
          //  self.view.layoutIfNeeded() // add this
            
            self.imageFish.center = CGPoint(x: self.screenSize.maxX + 100 , y: r.origin.y)
            //self.view.layoutIfNeeded() // add this
            
        }, completion: nil)

    }
    
    func setupView(){
        self.txtTextBox.becomeFirstResponder();
        errorText.isHidden = true
        lblChangingHeader.text = "First Name"
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        counterLabel += 1

        switch counterLabel {

        case 2:
            firstName = txtTextBox.text!
            txtTextBox.text = ""
             slideLabel(labelOne: lblChangingHeader,textForLabel: "Last Name",leftOrRight:"left");
        case 3:
            lastName = txtTextBox.text!
            txtTextBox.text = ""

             slideLabel(labelOne: lblChangingHeader,textForLabel: "Email Address",leftOrRight:"right");
        case 4:
            emailAddress = txtTextBox.text!
            txtTextBox.text = ""

             slideLabel(labelOne: lblChangingHeader,textForLabel: "Password",leftOrRight:"left");
        case 5:
            password = txtTextBox.text!
            txtTextBox.text = ""
            
            slideLabel(labelOne: lblChangingHeader,textForLabel: "Confirm Password",leftOrRight:"left");
        case 6:
            if txtTextBox.text! == password{
                password = txtTextBox.text!
                txtTextBox.text = ""
                slideLabel(labelOne: lblChangingHeader,textForLabel: "Phone (Optional)",leftOrRight:"left");

            }else{
                errorText.isHidden = false
                txtTextBox.text = ""
                slideLabel(labelOne: lblChangingHeader,textForLabel: "Password",leftOrRight:"left");
                counterLabel = 4
            }

        default:
            phoneNumber = txtTextBox.text!
            
            //If there isn't an account then login if there is an account get it
            self.view.lock(headingText: "Registering", loadingText: nil, lowerLoadingText: nil)
            NoSqlManager.saveBusiness(businessName:nil, businessCategory: nil, businessDescription: nil, businessEmail: emailAddress, businessImage: nil, businessLatidude: nil, businessLongitude: nil, businessPhone: phoneNumber, businessWebsite: nil, mondayHours: nil, tuesdayHours: nil, wednesdayHours: nil, thusdayHours: nil, fridayHours: nil, saturdayHours: nil, sundayHours: nil, isBusinessActive: false, firstName: firstName,lastName:lastName,password:password, completion: { (status) in
                if status == 200{
                    DispatchQueue.main.async {
                    self.view.unlock(statusCode: 200)
                    AppController.shared.keychain.set(self.password, forKey: Constants.PASSWORDKEY)
                    AppController.shared.keychain.set(self.password, forKey: Constants.EMAILKEY)

                        
                    self.performSegue(withIdentifier: "homeVC", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                    self.view.unlock(statusCode: 200)
                    self.loginError()
                    }
                   
                }
                
            })
        }

        return true
    }
    
    
     func loginError(){
        
        let refreshAlert = UIAlertController(title: "Oops", message: "login error", preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        DispatchQueue.main.async {
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    
    /*
     This is the sliding animation it takes a  label and text that should apear in it after
     it slides back in
     */
    func slideLabel(labelOne: UILabel,textForLabel: String,leftOrRight: String){
        // lblRegistrationInfo.text = textForLabel;
        labelOne.textColor = UIColor.black
        let yPosition = labelOne.center;
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            
            
            if(leftOrRight == "right"){
                labelOne.center = CGPoint(x: self.view.frame.maxX + labelOne.frame.maxX, y:self.middleLabel.y )
            }else{
                labelOne.center = CGPoint(x: ((self.view.frame.maxX + labelOne.frame.maxX) * -1) , y:self.middleLabel.y )
            }
            
        },completion:{ finished in self.animationTwo(labelTwo: labelOne,textForLabel: textForLabel, yPosition: yPosition)})
        
    }//end first func
    
    
    func animationTwo(labelTwo: UILabel,textForLabel:String, yPosition: CGPoint){
        
        labelTwo.text = textForLabel;
        
        UIView.animate(withDuration: 0.4, delay: 0.0,options: .curveEaseIn, animations: {
            
            // if(self.inOrOut == 0){
            //}
            labelTwo.center = yPosition;
            
        }, completion:nil)
        
    }//end second func
    
    
}
    
