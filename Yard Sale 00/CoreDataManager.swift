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
// set up manager



class CoreDataManager: NSObject{
    
    
    func getUsers()->[AddBusiness]{
        
        var businesses = [AddBusiness]()
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {

        return businesses
        }
        
        let managedContext = appDelegate.managedObjectContext

        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        //3
        do {
            
            
          Users = try managedContext.fetch(fetchRequest)
            for u in Users{
                var coordinate = CLLocationCoordinate2D()
              let  n = (u.value(forKey: "organizationName")! as! String)
              let la = (u.value(forKey: "latitude")! as! String)
              let lo = (u.value(forKey: "longitude")! as! String)
              let type = (u.value(forKey: "typeOfBusiness")! as! String)
              coordinate.latitude =  Double(la)!
              coordinate.longitude =  Double(lo)!
              let  businessD = (u.value(forKey: "details")! as! String)
              let  pinC = (u.value(forKey: "pinColor")! as! String)
        
                let  image = (u.value(forKey: "headerImage")! as! NSData)

                let  emailAddress = (u.value(forKey: "emailAddress")! as! String)

          //      let  monday = (u.value(forKey: "mondayHours")! as! String)
          //      let  tuesday = (u.value(forKey: "tuesdayHours")! as! String)
          //      let  wednesday = (u.value(forKey: "wednesdayHours")! as! String)
           //     let  thursday = (u.value(forKey: "thursdayHours")! as! String)
           //     let  friday = (u.value(forKey: "fridayHours")! as! String)
           //     let  saturday = (u.value(forKey: "saturdayHours")! as! String)
           //     let  sunday = (u.value(forKey: "sundayHours")! as! String)

                let  monday = "1:00 to 2:00"
                let  tuesday = "1:00 to 2:00"
                let  wednesday = "1:00 to 2:00"
                let  thursday = "1:00 to 2:00"
                let  friday = "1:00 to 2:00"
                let  saturday = "1:00 to 2:00"
                let  sunday = "1:00 to 2:00"
                

                let hours = [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
                
                
                
                
                
                
                
                businesses.append(AddBusiness(coordinate: coordinate, businessName: n, businessDescription: businessD, pinColor: pinC,type:type,image:image,emailAddress: emailAddress, hours: hours))
                
            }
    
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        return businesses
    
    }
    
    
    func save(organizationName: String,details:String,emailAddress:String,hours: [String],coordinate: CLLocationCoordinate2D,password:String,typeOfBusiness:String,pinColor:String,image: NSData) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.managedObjectContext

       
        // get the entity/table
        let entity = NSEntityDescription.entity(forEntityName: "Users",in: managedContext)!
        
        let users = NSManagedObject(entity: entity, insertInto: managedContext)
        
       
        // add the values boom shaa!
        users.setValue(organizationName, forKeyPath: "organizationName")
        users.setValue(emailAddress, forKeyPath: "emailAddress")
        users.setValue(String(coordinate.longitude), forKeyPath: "longitude")
        users.setValue(String(coordinate.latitude), forKeyPath: "latitude")
        users.setValue(typeOfBusiness, forKeyPath: "typeOfBusiness")
        users.setValue(password, forKeyPath: "password")
        users.setValue(details, forKeyPath: "details")
        users.setValue(pinColor, forKeyPath: "pinColor")
        users.setValue(image, forKeyPath: "headerImage")

        
        //loop though hours and put them in 
        
        
        for hour in hours {
            
            print(hour)
            
            switch hour{
                
            case "mondayHours":
                
                users.setValue(hour, forKeyPath: "mondayHours")

                break
                
                
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
