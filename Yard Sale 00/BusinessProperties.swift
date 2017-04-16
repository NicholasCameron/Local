//
//  BusinessProperties.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-04-16.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class BusinessProperties: NSObject {

    
    static let properties = BusinessProperties()
    
    
    var businessCoordinates = CLLocationCoordinate2D();
    var businessTypeOfficial = String();
    var businessStreet = String();
    var usersLocation = CLLocationCoordinate2D();
    let location = CLLocationCoordinate2D()
    
    let latDelta:CLLocationDegrees = 5.05
    
    let lonDelta:CLLocationDegrees = 5.05
    
    var onOrOff = Bool()
    var center = "";
    
    
    
    var DataManager = CoreDataManager()
    

    var ownerName = String()
    var emailAddress = String()
    var password = String()
    var longitude = String()
    var latitude = String()
    var organizatinType = String()
    var other = String()
    var businessDescription = String()
    var pinColor = String()
    var businessHours = [String]()
    
    
  
    
    
    
    
    
    
}
