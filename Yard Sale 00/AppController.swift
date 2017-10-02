//
//  AppController.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-09-30.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import CoreLocation

class AppController: NSObject {
    
    enum LoginType {
        case Custom
        case Facebook
    }
    
    static let shared = AppController()
    
    var externalBusinesses = [Businesses]()
    var usersBusiness = Businesses()
    var isloggedInWithFacebook = Bool()
    var isCustomLogin = Bool()
    
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
    
    
//    var businessName = String()
//    var businessEmail = "NA"
//    var password = String()
//    var businessLongitude = String()
//    var businessLatitude = String()
//    var businessCategory = String()
//    var businessImage = Data()
//    var businessPhone = "NA"
//    var businessWebsite = "NA"
//    var other = String()
//    var businessDescription = String()
//    var businessHours = [String]()
//    var firstName = String()
//    var lastName = String()
    func isLoggedIn()->(Bool,LoginType?){
        
        if isloggedInWithFacebook || isCustomLogin{
            if isloggedInWithFacebook{
                return (true, LoginType.Facebook)
            }else{
                return (true, LoginType.Custom)
            }
        }
        return (false,nil)
    }
    
    
}
