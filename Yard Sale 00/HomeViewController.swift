//
//  HomeViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-02-26.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class HomeViewController: UIViewController {
   
    
    @IBOutlet weak var btnMyBusiness: UIButton!
    @IBOutlet weak var btnRegisterBusiness: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Get all the external data needed if its not already loaded
        
        if AppController.shared.externalBusinesses.count == 0 {
            self.view.lock(headingText: "loading", loadingText: "test", lowerLoadingText: nil)
            NoSqlManager.getAllBusinesses { (status,  externalBusinesses) in
                self.view.unlock(statusCode: 200)
                if status == 200 && externalBusinesses != nil{
                AppController.shared.externalBusinessMapObjects = externalBusinesses!
                }
            }
        }
        
        if AppController.shared.usersBusiness?._activeBusiness == true{
            btnRegisterBusiness.isHidden = true
        }else{
            btnMyBusiness.isHidden = true
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
            GenericAlerts.genericAlert(viewController: self, title: "Hold up", message: "You must first login and register a business.")
        }
    }

    @IBAction func logoutTapped(_ sender: Any) {
      // var fbManager = FBSDKLoginManager()
       // fbManager.logOut()
        AppController.shared.signOut()
        LoginManager.facebookLogout()
        AppController.shared.signOut()
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
