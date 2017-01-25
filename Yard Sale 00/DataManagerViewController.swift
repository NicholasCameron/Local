//
//  DataManagerViewController.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2016-10-25.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreData

class DataManagerViewController {

    public var registrationData = [String]();
    
    
    func Register(userName: String,password: String,businessName: String, businessLocation: String, businessType: String)->Bool  {
        print("user saved")
        
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as NSManagedObject
        
        newUser.setValue(userName, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do{
            try context.save()
            return true;
        }catch{
            return false;
            
        }
    
    }//end of function
}
