//
//  Login.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-10-17.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreData
class Login: UIViewController,UITextFieldDelegate{

   
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var lblpass: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    var firstPassword = "";
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtUsername.delegate = self;
        self.txtPassword.delegate = self;

        
    }
        open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if(txtPassword.isFirstResponder && !txtPassword.isEqual("") && lblpass.text == "Password" ){
            lblpass.text = "Confirm Password";
            firstPassword = txtPassword.text!;
            txtPassword.text = "";
        errorMessage.text = ""

    }
        if(lblpass.text == "Confirm Password" && txtPassword.text != ""){
            
            if(firstPassword.isEqual(txtPassword.text)){
                
                txtPassword.text = txtPassword.text;
                errorMessage.text = "Passwords Match"

                
            }else{
                firstPassword = "";
                lblpass.text = "Password"
                errorMessage.text = "Passwords Do Not Match"
                txtPassword.text = "";
            }
            
            
            
        }
        
        
        textField.resignFirstResponder()
        
        return true
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register()  {
        print("user saved")

        var appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as NSManagedObject
        
        newUser.setValue(txtUsername.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")

        do{
       try context.save()
            print("user saved")

        }catch{
            print("user not saved")
        }
        
        
    }
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
