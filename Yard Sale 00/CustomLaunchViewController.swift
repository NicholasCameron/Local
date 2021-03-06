//
//  CustomLaunchViewController.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-05.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import KeychainSwift
import AWSDynamoDB

class CustomLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupApp()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupApp(){
        
//        AppController.shared.keychain.delete(Constants.PASSWORDKEY)
//        AppController.shared.keychain.delete(Constants.EMAILKEY)

        
        if ((AppController.shared.keychain.get(Constants.PASSWORDKEY) != nil &&
AppController.shared.keychain.get(Constants.EMAILKEY) != nil) || AppController.shared.keychain.get(Constants.FACEBOOKID) != nil){
            let pass = AppController.shared.keychain.get(Constants.PASSWORDKEY)
            let email = AppController.shared.keychain.get(Constants.EMAILKEY)
            DispatchQueue.main.async {
                self.view.endEditing(true)
                
                self.view.lock(headingText:"Air Canada mobile+",loadingText:"Signing in...", lowerLoadingText: nil)
                // self.view.unlock()
                let objectMapper = AWSDynamoDBObjectMapper.default()
                let scanExpression = AWSDynamoDBScanExpression()
                if email == nil || pass == nil{
                    scanExpression.filterExpression = "#FacebookUserID = :FacebookUserID"
                    scanExpression.expressionAttributeNames = ["#FacebookUserID": "FacebookUserID"]
                    scanExpression.expressionAttributeValues = [":FacebookUserID": AppController.shared.keychain.get(Constants.FACEBOOKID) ?? ""]
                }else{
                    scanExpression.filterExpression = "#BusinessEmail = :BusinessEmail AND #password = :password"
                    scanExpression.expressionAttributeNames = ["#BusinessEmail": "BusinessEmail","#password": "password"]
                    scanExpression.expressionAttributeValues = [":BusinessEmail": email ?? "" ,":password": pass ?? "", ]
                }
                objectMapper.scan(Businesses.self, expression: scanExpression) { (response: AWSDynamoDBPaginatedOutput?, error: Error?) in
                    DispatchQueue.main.async(execute: {
                        if response != nil{
                            self.view.unlock(statusCode: 200)
                            if response?.items.count == 1{
                                AppController.shared.isCustomLogin = true
                                AppController.shared.usersBusiness?._password = email
                                
                                
                                for item in (response?.items)!{
                                    if let pulledBusiness = item as? Businesses{
                                        AppController.shared.usersBusiness = pulledBusiness
                                        
                                    }
                                }
                                self.performSegue(withIdentifier: "homeVCSegue", sender: nil)
                            }else{
                                self.view.unlock(statusCode: 500)
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "customLaunchSegue", sender: nil)
                                }
                            }
                            
                        }else{
                            self.view.unlock(statusCode: 500)
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "customLaunchSegue", sender: nil)
                            }
                            
                        }
                    })
                }
            }
        }else{
            //no persistance
            DispatchQueue.main.async {
            self.performSegue(withIdentifier: "customLaunchSegue", sender: nil)
            }
        }
    }
}
