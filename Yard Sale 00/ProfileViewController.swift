//
//  ProfileViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-03-09.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if Profile.ProfilePage.profileName != ""{
        businessTitle.text = Profile.ProfilePage.profileName
        self.navigationController?.title = Profile.ProfilePage.profileType
        

        self.view.backgroundColor = Profile.ProfilePage.bgColor
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
