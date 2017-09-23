//
//  HomeViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-02-26.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Get all the external data needed
        
        NoSqlManager.getAllBusinesses { (status,  externalBusinesses) in
            
            if status == 200 && externalBusinesses != nil{
            BusinessProperties.properties.externalBusinesses = externalBusinesses!
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
