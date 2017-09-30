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

    @IBAction func signInWithFacebookTapped(_ sender: Any) {
        
               LoginManager.facebookLogin(viewController: self) { 
                print("gpda")
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
@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
