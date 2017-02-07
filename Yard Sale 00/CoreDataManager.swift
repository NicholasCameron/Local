//
//  CoreDataManager.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-02-06.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import MapKit

var Users = [NSManagedObject]()



class CoreDataManager: NSObject{
    
    
    func save(organizationName: String,details:String,emailAddress:String,hours: [String],coordinate: CLLocationCoordinate2D,password:String,description:String,typeOfBusiness:String,pinColor:String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // set up manager
        let managedContext = appDelegate.managedObjectContext
        
        // get the entity/table
        let entity = NSEntityDescription.entity(forEntityName: "Users",in: managedContext)!
        
        let users = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        // add the values boom shaa!
        users.setValue(organizationName, forKeyPath: "organizationName")
        users.setValue(organizationName, forKeyPath: "emailAddress")
        users.setValue(organizationName, forKeyPath: "longitude")
        users.setValue(organizationName, forKeyPath: "latidude")
        users.setValue(organizationName, forKeyPath: "typeOfBusiness")
        users.setValue(organizationName, forKeyPath: "password")
        users.setValue(organizationName, forKeyPath: "details")
        users.setValue(organizationName, forKeyPath: "pinColor")
        
        
        //loop though hours and put them in 
        
        
        for hour in hours {
            
            print(hour)
            
            switch hour{
                
            case "mondayHours": break
                
                
            default:
            break
                
            }
            
            
            
        }
        
        
        // 4
        do {
            try managedContext.save()
        //this is likely when i load all the usrs then save it adds to it
          //  people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
}
