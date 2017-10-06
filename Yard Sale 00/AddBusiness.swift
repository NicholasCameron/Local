//
//  AddBusiness.swift
//  MapKitRecreation
//
//  Created by Nicholas Cameron on 2016-10-27.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class LocalBusinessMapObject: NSObject,MKAnnotation {
   
    public func encode(with aCoder: NSCoder) {
        print("beep")
    }

    
    var coordinate : CLLocationCoordinate2D
    var businessName : String
    var businessCategory : String
    
    
    
    
    var title: String? {
        if businessName.isEmpty {
            return "Error"
        }
        return  businessName
    }
    
    var subtitle: String? {
        if businessCategory.isEmpty{
            return "None"
        }else{
            return businessCategory
        }
    }

    
    ///Constructor
    init(coordinate: CLLocationCoordinate2D, businessName: String, businessCategory: String) {
        self.coordinate = coordinate
        self.businessName = businessName
        self.businessCategory = businessCategory
    }
    
  
    
    deinit {
        print("ere")
    }
    

}//End of class
