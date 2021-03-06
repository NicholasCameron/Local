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
        
            self.performSegue(withIdentifier: "homeVC", sender: nil)
       
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
            GenericAlerts.genericAlert(viewController: self, title: "Please Sign In", message: "In order for your business to reach the public you must first register. It will take less than one minute.")
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
