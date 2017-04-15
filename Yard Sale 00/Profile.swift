//
//  Profile.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-03-31.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import Foundation
import UIKit
var ProfilePage = Profile()

class Profile{
    
var profileName = String()
var profileDescription = String()
var profileHours = [String]()
var profileType = String()
var bgColor = UIColor()
    
    init() {
        self.profileName = String()
        self.profileType = String()
        self.profileHours = [String()]
        self.profileDescription = String()
        self.bgColor = UIColor()
    }


}
