//
//  Register00.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-10-20.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit




class Register00: UIViewController,UITextFieldDelegate {
  
    
    var Registration = DataManagerViewController();
    
    @IBOutlet weak var lblBusiessName: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtData: UITextField!
    //wait until the user put in their name then display the welcome
    @IBOutlet weak var lblWelcome: UILabel!

    
    
    var middleLabel = CGPoint();
    let screenSize: CGRect = UIScreen.main.bounds
    var inOrOut = 0;
    var businessName = "";
    var businessEmail = "";
    var password = String();
    var confirmPassword = String();
   //this is the counter to see when to switch to the next view
  //to continue registering..
 //when the second input of data is entered and confirmed it will switch aka counter = 2..012
    
    var counter = 0;
    
    @IBOutlet weak var smallCloud: UIImageView!
    var r = CGRect();
    
    override func viewDidLoad() {
        
        
        
        
        //WARNING! WARNING! WARNING!
        //Will need to restrict KEY on LAUNCH
        super.viewDidLoad()
        r = self.smallCloud.frame;
        self.smallCloud.frame = r;

        //background
        self.view.ViewBackground(image:"waterlight0");
        /////////////
        self.txtData.delegate = self;
        lblError.isHidden = true;
        lblBusiessName.text = "Organization Name"
        self.txtData.becomeFirstResponder();
        
        //hide until get users name
        lblWelcome.isHidden = true;
        ///////////////////////////

        
    }
    override func viewDidAppear(_ animated: Bool) {
        //FOOL AROUND TO MAKE SMALL CLOUD DO COOL JAZZ
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 15.0, delay: 0, options: [], animations: {
           
            
            self.view.layoutIfNeeded() // add this
            self.smallCloud.center = CGPoint(x: self.screenSize.maxX + 100 , y:self.r.origin.y)
            self.view.layoutIfNeeded() // add this

}, completion: nil)
        
        
        ///////////////////////////////////////////////////////////////


    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.layoutIfNeeded() // add this

        /////////////////////////////////////////////////////////////
        //below is to hide the keyboard
        //textField.resignFirstResponder()
        
        //ERROR CHECK BELOW FOR NAME IF WANTED.
////////////////////////////////////////////////////////
        if(txtData.text != ""){
            if(self.counter == 0){
              
                //data in text = var business name
                businessName = txtData.text!;
                ownerName = businessName;
                
                //Take name and welcome them
                lblWelcome.text = "Welcome " + businessName
                lblWelcome.isHidden = false;

                //slide the business ownser/full name out of there
                slideLabel(labelOne: lblBusiessName,textForLabel: "Email Address",leftOrRight:"left");
              
                //no error so error stays hiden
                lblError.isHidden = true;
              
                //reset text field to nothing
                txtData.text = "";
              
                //add to the counter because were on email now
                self.counter = self.counter + 1;
                self.txtData.becomeFirstResponder();


                
            }else if(self.counter == 1){
                
                
                
                
                //data in text = var business name
                businessEmail = txtData.text!;
                emailAddress = businessEmail;
                
                //Take name and welcome them
                lblWelcome.text = "Welcome " + businessName
                
                //slide the business ownser/full name out of there
                slideLabel(labelOne: lblBusiessName,textForLabel: "Password",leftOrRight:"right");
                
                //no error so error stays hiden
                lblError.isHidden = true;
                
                //reset text field to nothing
                txtData.text = "";
                
                //add to the counter because were on email now
                self.counter += 1;
                self.txtData.becomeFirstResponder();
                
                
                
                
            }else if(counter == 2){
                

                
                
                password = txtData.text!;
                
                
                            
                //slide the business ownser/full name out of there
                slideLabel(labelOne: lblBusiessName,textForLabel: "Confirm Password",leftOrRight:"right");
                
                //no error so error stays hiden
                lblError.isHidden = true;
                
                //reset text field to nothing
                txtData.text = "";
                
                //add to the counter because were on email now
                self.counter += 1;
                self.txtData.becomeFirstResponder();
            }
            
            
            
            
            else{
            
            if(password.isEqual(txtData.text)){

                Registration.registrationData.append(businessName);
                Registration.registrationData.append(businessEmail);
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Register01") as! Register01
                self.present(nextViewController, animated:true, completion:nil)
                

            }else{
                
                lblWelcome.text = "Welcome " + businessName
                
                //slide the business ownser/full name out of there
                self.counter = 1;

                slideLabel(labelOne: lblBusiessName,textForLabel: "Password",leftOrRight:"right");
                
                //no error so error stays hiden
                lblError.text = "Passwords Do Not Match";
                lblError.isHidden = false;
                
                //reset text field to nothing
                txtData.text = "";
                self.counter = self.counter + 1
                
                //add to the counter because were on email now
                self.txtData.becomeFirstResponder();

                }
                                
                
                
            }
          

        }else{
            //says please enter something dummy..politely
            lblError.isHidden = false;
            lblError.text = "Please Enter Text";

        }
        
        return false
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
    //////////////////End of animation functions they are combined functions.///////////////
    
}




