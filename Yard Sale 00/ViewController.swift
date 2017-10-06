//
//  ViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-08-24.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit


var mondayHours = String();
var tuesdayHours = String();
var wednesdayHours = String();
var thrusdayHours = String();
var fridayHours = String();
var satudayHours = String();
var sundayHours = String();

class ViewController: UIViewController {


    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.ViewBackground(image:"waterlight")
       // NoSqlManager.saveBusiness()
        
        print(CFGetRetainCount(AddGeotification.self))
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            if let viewControllers = window.rootViewController?.childViewControllers {
                for viewController in viewControllers{
                    print(viewController.debugDescription)
                }
            }
        }
    }

    @IBAction func homeBtnTapped(_ sender: Any) {
        
        if AppController.shared.isLoggedIn().0 {
            self.performSegue(withIdentifier: "homeVC", sender: nil)
            
        }else{
            LoginAlerts.genericAlert(viewController: self, title: "Hold up", message: "Login or register..it only takes a second and you'll stay logged in.")
        }
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        let isloggedIn = AppController.shared.isLoggedIn()
        if isloggedIn.0{
            if isloggedIn.1 == AppController.LoginType.Facebook{
                //search for the facebook ID Tied ot the business
                performSegue(withIdentifier: "registerSegue", sender: nil)
            }else{
                //seatch for the custom user/pass tied to business
                
                performSegue(withIdentifier: "registerSegue", sender: nil)
            }
        }else{
            LoginAlerts.genericAlert(viewController: self, title: "Please Sign In", message: "In order for your business to reach the public you must first register. It will take less than one minute.")
        }
    }
    
    
    
    
    @IBAction func signInWithFacebookTapped(_ sender: Any) {
        
               LoginManager.facebookLogin(viewController: self) { (status) in
                if status == 200{
                    AppController.shared.isloggedInWithFacebook = true
                    //HAVE TO GET FB ID AND STORE IT.
                    
                    self.performSegue(withIdentifier: "homeVC", sender: nil)
                }else{
                    LoginAlerts.genericAlert(viewController: self, title: "Login Error", message: "Something went wrong..FUCK")
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    deinit {
        print("tet")
    }
    
}
