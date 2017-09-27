//
//  ProfileViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-03-09.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSAuthCore

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var businessTitle: UILabel!
    @IBOutlet weak var mondayHours: UILabel!
    @IBOutlet weak var tuesdayHours: UILabel!
    @IBOutlet weak var wednesdayHours: UILabel!
    @IBOutlet weak var thursdayHours: UILabel!
    @IBOutlet weak var fridayHours: UILabel!
    @IBOutlet weak var saturdayHours: UILabel!
    @IBOutlet weak var sundayHours: UILabel!
    @IBOutlet weak var businessDescription: UILabel!
   var business = Businesses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if Profile.ProfilePage.profileName != ""{
        businessTitle.text = Profile.ProfilePage.profileName
        self.navigationController?.title = Profile.ProfilePage.profileType
        

        self.view.backgroundColor = Profile.ProfilePage.bgColor
        }
        
        loadData()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData(){
        
        
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.indexName = business?._businessId
        
     //   queryExpression.keyConditionExpression = ("BusinessName = :\(business?._businessName ?? "")");
       // queryExpression.indexName = businessID
    //queryExpression.expressionAttributeValues = ["BusinessName":business?._businessName ?? ""]

        queryExpression.indexName = business?._businessId
        
      //  queryExpression.keyConditionExpression = ("BusinessId = \(business?._businessId ?? "")")
     
        
      
        let objectMapper = AWSDynamoDBObjectMapper.default()
        let scanExpression = AWSDynamoDBScanExpression()
        
        scanExpression.filterExpression = "#BusinessName < :BusinessName"
        scanExpression.expressionAttributeNames = ["#BusinessName": "BusinessName" ,]
        scanExpression.expressionAttributeValues = [":BusinessName": business?._businessName! ?? ""]
        
        objectMapper.scan(Businesses.self, expression: scanExpression) { (response: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if let error = error as NSError? {
                print(error)
            }else{
                for item in (response?.items)!{
                    print(item)
                }
            }
        }

        
//        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
//
//        let t = AWSDynamoDBObjectMapperConfiguration()
//
//        
//        
//        dynamoDbObjectMapper.query(Businesses.self, expression: queryExpression, configuration: t) { (businessPager, error) in
//            if businessPager?.items != nil{
//
//                
//            }
//        }
        
     
        
        
        
    }
    
    
    @IBAction func btnContactClicked(_ sender: Any) {
   
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
          
            
           // self.viewContact.alpha = 1
   
        }, completion: nil)
    
    }
    

    @IBOutlet weak var btnCall: UIButton!
    @IBAction func btnCallClicked(_ sender: Any) {
        let url = NSURL(string: "tel://19024324631")!
        UIApplication.shared.openURL(url as URL)
    }

    
}
