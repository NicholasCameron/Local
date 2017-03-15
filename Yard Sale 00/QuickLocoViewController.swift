//
//  QuickLocoViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-01-24.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import Foundation
import CoreData

var Businesses = [String:AnyObject]()


struct BusinessDetail{
    let businessName: String
    let businessDescription: String
    let businessType: String
}




class QuickLocoViewController: UIViewController {

    
    var bizName = String()
    var bizDescription = String()
    var bizType = String()
    
    var shouldShowSearchResults = Bool();
    
    var filteredNameArray = [String]()
    var filteredTypeArray = [String]()
    
    
    
    var businessDetailsArray = [BusinessDetail]()
    var businessDetailsFilteredArray = [BusinessDetail]()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
             self.view.ViewBackground(image: "quickLocoBG")

    
    
    //TABLE VIEW
        
    
         }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
      
        
        
        
        
        for button in view.subviews{
        if button is UIButton {
            UIView.animate(withDuration: 0.5, delay: 0.0,options: [.autoreverse, .allowUserInteraction],
            animations:{
                button.transform = CGAffineTransform(scaleX: 1.1, y:1.1)
                
            }, completion: { (t) -> Void in
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            
            
            
            }
            
        }
        
    }


    
    
 

}
