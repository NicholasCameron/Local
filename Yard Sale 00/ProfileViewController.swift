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
    @IBOutlet weak var businessType: UILabel!
    
    
    @IBOutlet weak var viewContact: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    businessTitle.text = ProfilePage.profileName
        
        businessType.text = ProfilePage.profileType

        //    let ColorValues = ["brown","purple","white","green","red","black","pink","orange","grey","green"]

        self.view.backgroundColor = ProfilePage.bgColor
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnContactClicked(_ sender: Any) {
   
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
          
            
            self.viewContact.alpha = 1
   
        }, completion: nil)
    
    }
    

    @IBAction func btnCloseViewContact(_ sender: Any) {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
            self.viewContact.alpha = 0
        }, completion: nil)
        

    }
    @IBOutlet weak var btnCall: UIButton!
    @IBAction func btnCallClicked(_ sender: Any) {
        let url = NSURL(string: "tel://19024324631")!
        UIApplication.shared.openURL(url as URL)
    }

    
}
