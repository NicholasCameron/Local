//
//  NoSqlManager.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-09-21.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import AWSCore
import AWSDynamoDB
import CoreLocation

class NoSqlManager: NSObject {

    
    
    
    class func saveBusiness(businessName:String?,businessCategory:String?,businessDescription:String?,businessEmail:String?,businessImage:Data?,businessLatidude:String?,businessLongitude:String?,businessPhone:String?,businessWebsite:String?,mondayHours:String?,tuesdayHours:String?,wednesdayHours:String?,thusdayHours:String?,fridayHours:String?,saturdayHours:String?,sundayHours:String?,isBusinessActive:Bool,firstName:String?,lastName:String?,password:String?,completion: @escaping (_ statusCode: Int) -> Void ) {
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
    
        //Create data object using data models you downloaded from Mobile Hub
        let businessItem: Businesses = Businesses();
        
        // Use AWSIdentityManager.default().identityId here to get the user identity id.
        var id = businessEmail
        
        if AppController.shared.isLoggedIn().0{
            if AppController.shared.isLoggedIn().1 == AppController.LoginType.Facebook{
                id = (AppController.shared.usersBusiness?._facebookUserID)!
                businessItem._facebookUserID = id
            }else{
                id = AppController.shared.usersBusiness?._businessEmail

            }
            
        
        }else{
            
        }
        
        businessItem._businessId = id
    
        businessItem._businessCategory = businessCategory
        businessItem._businessDescription = businessDescription
        businessItem._businessEmail = businessEmail
        businessItem._businessImage = businessImage
        businessItem._businessLatitude = businessLatidude
        businessItem._businessLongitude = businessLongitude
        businessItem._businessName = businessName
        businessItem._businessPhone = businessPhone
        businessItem._businessWebsite = businessWebsite
        businessItem._fridayHours = saturdayHours
        businessItem._mondayHours = mondayHours
        businessItem._saturdayHours = fridayHours
        businessItem._sundayHours = sundayHours
        businessItem._thursdayHours = thusdayHours
        businessItem._tuesdayHours = tuesdayHours
        businessItem._wednesdayHours = wednesdayHours
        businessItem._activeBusiness = isBusinessActive as NSNumber
        businessItem._firstName = firstName
        businessItem._lastName = lastName
        businessItem._password = AppController.shared.usersBusiness?._password
        
        //Save a new item
        dynamoDbObjectMapper.save(businessItem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                completion(500)
                return
            }
            completion(200)
            return
        })
    }
    
    
    
    class func getAllBusinesses(completion: @escaping (_ statusCode: Int,_ businesses:[LocalBusinessMapObject]?) -> Void){
        
        var businessDetailsArray = [LocalBusinessMapObject]()
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        //Create data object using data models you downloaded from Mobile Hub
        var _: Businesses = Businesses();
        
        
        
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.limit = 20
        
        scanExpression.filterExpression = "#activeBusiness = :activeBusiness"
        scanExpression.expressionAttributeNames = ["#activeBusiness": "activeBusiness"]
        scanExpression.expressionAttributeValues = [":activeBusiness": true, ]
        
        
        
        let t = AWSDynamoDBObjectMapperConfiguration()
        
            dynamoDbObjectMapper.scan(Businesses.self, expression: scanExpression, configuration: t) { (businessPager, error) in
                if businessPager?.items != nil{
                    for business in (businessPager?.items)!{
                        if let pulledBusiness = business as? Businesses{
                            
                            let location = CLLocationCoordinate2D(latitude: Double(pulledBusiness._businessLatitude!)!, longitude: Double(pulledBusiness._businessLongitude!)!)

                            var hours = [String]()
                                hours.append(pulledBusiness._mondayHours!)
                            hours.append(pulledBusiness._tuesdayHours!)
                            hours.append(pulledBusiness._wednesdayHours!)
                            hours.append(pulledBusiness._thursdayHours!)
                            hours.append(pulledBusiness._fridayHours!)
                            hours.append(pulledBusiness._saturdayHours!)
                            hours.append(pulledBusiness._sundayHours!)

                        
                            AppController.shared.externalBusinesses.append(pulledBusiness)
                            
                            let b = LocalBusinessMapObject(coordinate: location, businessName: pulledBusiness._businessName!, businessDescription: pulledBusiness._businessDescription!, pinColor: "red", type: pulledBusiness._businessCategory!, image: pulledBusiness._businessImage!, emailAddress: pulledBusiness._businessEmail!, hours: hours)
                                
                            
                            businessDetailsArray.append(b)
                        }
                    }
                    completion(200,businessDetailsArray)
                    return
                }else{
                    completion(500,nil)

                }
        }
        

        
        
    }
    
    
    
}
