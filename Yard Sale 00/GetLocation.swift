//
//  GetLocation.swift
//  MapSeach00
//
//  Created by Nick J Cameron on 2016-11-08.
//  Copyright © 2016 IBM. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AddressBookUI

var locations = String();


////Reverse geodecoding
//func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees)->String {
//    
//    let location = CLLocation(latitude: latitude, longitude: longitude)
//    CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//      
//        
//        if error != nil {
//            print("Error")
//            return
//        }
//        else if (placemarks?.count)! > 0 {
//            let pm = placemarks![0]
//            let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
//            print("\n\(address)")
//            locations = address;
//
//            
//          
//        }
//    })
//    return locations
//}

