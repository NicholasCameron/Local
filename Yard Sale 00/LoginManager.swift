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
import AWSDynamoDB

class LoginManager: NSObject {

    
    
    //Log's the user into facebook and gets their liked information
    class func facebookLogin(viewController:UIViewController,completion: @escaping ((_ statusCode:Int) -> Void))  {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: viewController) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
               
                if fbloginresult.grantedPermissions != nil {
                    
                    AppController.shared.usersBusiness?._facebookUserID = fbloginresult.token.userID
                    
                    AppController.shared.isloggedInWithFacebook = true
                   self.getFBUserData(completion: { (status) in
                    if status == 200{
                        completion(status)
                        return
                    }else{
                        completion(status)
                        return
                    }
                })
               }
            }
        }
    }
    
    class func getFBUserData(completion: @escaping ((_ statusCode:Int) -> Void)) {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                
                  var properties =  result as! [String : AnyObject]
                    if (properties["first_name"] as? String) != nil{
                        AppController.shared.usersBusiness?._firstName = properties["first_name"] as? String
                    }
                    if (properties["last_name"] as? String) != nil{
                        AppController.shared.usersBusiness?._lastName = properties["last_name"] as? String

                    }
                    if (properties["email"] as? String) != nil{
                        AppController.shared.usersBusiness?._businessEmail = properties["email"] as? String

                    }
                    
                    let objectMapper = AWSDynamoDBObjectMapper.default()
                    let scanExpression = AWSDynamoDBScanExpression()
                    
                    scanExpression.filterExpression = "#FacebookUserID = :FacebookUserID"
                    scanExpression.expressionAttributeNames = ["#FacebookUserID": "FacebookUserID"]
                    scanExpression.expressionAttributeValues = [":FacebookUserID": AppController.shared.facebookID , ]
                    
                    objectMapper.scan(Businesses.self, expression: scanExpression) { (response: AWSDynamoDBPaginatedOutput?, error: Error?) in
                    
                        if response?.items.count != 0 && error == nil{
                            for item in (response?.items)!{
                                if let biz = item as? Businesses{
                                    AppController.shared.usersBusiness = biz
                                    completion(200)
                                    return

                                }
                            }
                        }else{
                           
                           //If there isn't an account then login if there is an account get it
                            NoSqlManager.saveBusiness(businessName:nil, businessCategory: "test", businessDescription: nil, businessEmail: AppController.shared.usersBusiness?._businessEmail, businessImage: nil, businessLatidude: nil, businessLongitude: nil, businessPhone: nil, businessWebsite: nil, mondayHours: nil, tuesdayHours: nil, wednesdayHours: nil, thusdayHours: nil, fridayHours: nil, saturdayHours: nil, sundayHours: nil, isBusinessActive: false, firstName: AppController.shared.usersBusiness?._firstName,lastName:AppController.shared.usersBusiness?._lastName,password:nil, completion: { (status) in
                                
                                if status == 200{
                                    completion(200)
                                    return
                                }else{
                                    completion(500)
                                    return
                                }
                                
                            })
                            
                            
                        }
                        
                    }
                }
            })
        }
    }
        
   class func facebookLogout(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
    }
}
