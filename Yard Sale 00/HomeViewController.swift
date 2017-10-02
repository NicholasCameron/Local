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
        self.view.lock(headingText: "loading", loadingText: "test", lowerLoadingText: nil)
        NoSqlManager.getAllBusinesses { (status,  externalBusinesses) in
            self.view.unlock(statusCode: 200)
            if status == 200 && externalBusinesses != nil{
            AppController.shared.externalBusinessMapObjects = externalBusinesses!
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMyBusinessTapped(_ sender: Any) {
        
        if AppController.shared.isLoggedIn().0 && AppController.shared.usersBusiness?._activeBusiness == true{
            self.performSegue(withIdentifier: "profileSegue", sender: nil)

        }else{
            LoginAlerts.genericAlert(viewController: self, title: "Hold up", message: "You must first login and register a business.")
        }
        
        
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
