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
    
    var externalBusinesses = [Businesses]()
    var externalBusinessMapObjects = [LocalBusinessMapObject]()
    var businessCoordinates = CLLocationCoordinate2D();
    var businessAddress = String();
    var usersLocation = CLLocationCoordinate2D();
    let location = CLLocationCoordinate2D()
    let latDelta:CLLocationDegrees = 5.05
    let lonDelta:CLLocationDegrees = 5.05
    var onOrOff = Bool()
    var center = "";
    var DataManager = CoreDataManager()
    

    var businessName = String()
    var businessEmail = "NA"
    var password = String()
    var businessLongitude = String()
    var businessLatitude = String()
    var businessCategory = String()
    var businessImage = Data()
    var businessPhone = "NA"
    var businessWebsite = "NA"
    var other = String()
    var businessDescription = String()
    var businessHours = [String]()
    
    
    
    
    
    
    
    
}
