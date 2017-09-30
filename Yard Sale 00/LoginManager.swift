//
//  LoginManager.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-09-27.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit
class LoginManager: NSObject {

    
    //Log's the user into facebook and gets their liked information
    class func facebookLogin(viewController:UIViewController,completion: (() -> Void)? = nil)  {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: viewController) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                      //  viewController.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    
}
}
