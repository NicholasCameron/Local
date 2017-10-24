//
//  GenericAlerts.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-15.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class GenericAlerts: NSObject {

    
    class func genericAlert(viewController:UIViewController,title:String, message:String){
        
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            //  print("Handle Ok logic here")
            
        }))
        
        DispatchQueue.main.async {
            viewController.present(refreshAlert, animated: true, completion: nil)
        }
    }
    

    
}
