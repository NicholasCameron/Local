//
//  ViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-08-24.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreLocation

var ownerName = String();
var emailAddress = String();
var password = String();
var longitude = String();
var latitude = String();
var organizatinType = String();
var other = String();
var businessDescription = String();
var pinColor = String();
var businessHours = [String]();

var DataManager = CoreDataManager()

class ViewController: UIViewController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.ViewBackground(image:"waterlight")
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
