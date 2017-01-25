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


struct BusinessDetails {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let businessName = "nicks shop"
    static let businessDescription = "cafe"
    static let pinColor = "red";
}



class AddBusiness: NSObject,NSCoding,MKAnnotation {
    
    var coordinate : CLLocationCoordinate2D
    var businessName : String
    var businessDescription : String
    var pinColor : String;
    
    
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
    init(coordinate: CLLocationCoordinate2D, businessName: String, businessDescription: String, pinColor:String) {
        self.coordinate = coordinate
        self.businessName = businessName
        self.businessDescription = businessDescription
        self.pinColor = pinColor
    }
 
    
    //NSCoding these are decoder and encoder required functions of the nscoder class
    required init?(coder decoder: NSCoder) {
        let latitude = decoder.decodeDouble(forKey: BusinessDetails.latitude)
        let longitude = decoder.decodeDouble(forKey: BusinessDetails.longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        businessDescription = decoder.decodeObject(forKey: BusinessDetails.businessDescription) as! String
        businessName = decoder.decodeObject(forKey: BusinessDetails.businessName) as! String
        pinColor = decoder.decodeObject(forKey: String(describing: BusinessDetails.pinColor)) as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(coordinate.latitude, forKey: BusinessDetails.latitude)
        coder.encode(coordinate.longitude, forKey: BusinessDetails.longitude)
        coder.encode(businessName, forKey: BusinessDetails.businessName)
        coder.encode(businessDescription, forKey: BusinessDetails.businessDescription)
        coder.encode(pinColor, forKey: BusinessDetails.pinColor)
    }

}//End of class
