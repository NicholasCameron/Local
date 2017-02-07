//
//  ViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-08-24.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreLocation

var locationManager = CLLocationManager()
var ownerName = String();
var emailAddress = String();
var password = String();
var longitude = String();
var latitude = String();
var organizatinType = String();
var other = String();
var businessDescription = String();
var pinColor = String();

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.ViewBackground(image:"LoginBackGround")

    //    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "LoginBackGround")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

