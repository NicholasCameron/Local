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



class AddBusiness: NSObject,MKAnnotation {
   
    public func encode(with aCoder: NSCoder) {
        print("beep")
    }

    
    var coordinate : CLLocationCoordinate2D
    var businessName : String
    var businessDescription : String
    var pinColor : String
    var type: String
    var image : NSData
    var emailAddress : String
    var hours : [String]
    
    
    
    
    
    var title: String? {
        if businessName.isEmpty {
            return "Error"
        }
        return  businessName
    }
    
    var subtitle: String? {
        if businessDescription.isEmpty{
            return "None"
        }else{
            return businessDescription
        }
    }

    
    ///Constructor
    init(coordinate: CLLocationCoordinate2D, businessName: String, businessDescription: String, pinColor:String,type: String,image: NSData, emailAddress: String, hours : [String]) {
        self.coordinate = coordinate
        self.businessName = businessName
        self.businessDescription = businessDescription
        self.pinColor = pinColor
        self.type = type
        self.image = image
        self.emailAddress = emailAddress
        self.hours = hours
    }
    deinit {
        print("ere")
    }
    

}//End of class
