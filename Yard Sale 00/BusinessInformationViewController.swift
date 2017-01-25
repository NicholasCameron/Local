//
//  BusinessInformationViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-11-20.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit

class BusinessInformationViewController: UIViewController {

    
    @IBOutlet weak var lblBusinessType: UILabel!
    @IBOutlet weak var lblOwnersName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMondayHours: UILabel!
    @IBOutlet weak var lblTuesdayHours: UILabel!
    @IBOutlet weak var lblWednesdayHours: UILabel!
    @IBOutlet weak var lblThursdayHours: UILabel!
    @IBOutlet weak var lblFridayHoura: UILabel!
    @IBOutlet weak var lblSaturdayHours: UILabel!
    @IBOutlet weak var lblSundayHours: UILabel!
    
    
    
    @IBOutlet weak var lblAddress: UILabel!

    
    var x1 = CGFloat()
    var x2 = CGFloat()
    var x3 = CGFloat()
    var x4 = CGFloat()
    var x5 = CGFloat()
    var x6 = CGFloat()
    var x7 = CGFloat()
    var x8 = CGFloat()
    var x9 = CGFloat()
    var x10 = CGFloat()
    var x11 = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       self.view.ViewBackground(image: "confirmationBG")

        
        
        lblBusinessType.text = businessTypeOfficial;
        lblOwnersName.text = ownerName;
        lblEmail.text = emailAddress;
        lblAddress.text = businessStreet;
        
        x1 = lblBusinessType.center.y;
        x2 = lblOwnersName.center.y;
        x3 = lblEmail.center.y;
        x4 = lblAddress.center.y;

        lblBusinessType.center.y = 0;
        lblOwnersName.center.y = 0;
        lblEmail.center.y = 0;
        lblAddress.center.y = 0;
        
        
        
        
        
        lblMondayHours.text = mondayHours;
        lblTuesdayHours.text = tuesdayHours
        lblWednesdayHours.text = wednesdayHours
        lblThursdayHours.text = thrusdayHours
        lblFridayHoura.text = fridayHours
        lblSaturdayHours.text = satudayHours
        lblSundayHours.text = sundayHours
        
        x5 = lblMondayHours.center.x;
        x6 = lblTuesdayHours.center.x;
        x7 = lblWednesdayHours.center.x;
        x8 = lblThursdayHours.center.x;
        x9 = lblFridayHoura.center.x;
        x10 = lblSaturdayHours.center.x;
        x11 = lblSundayHours.center.x;
        
        lblMondayHours.center.x = self.view.bounds.width * 2
        lblTuesdayHours.center.x = self.view.bounds.width * 2
        lblWednesdayHours.center.x = self.view.bounds.width * 2
        lblThursdayHours.center.x = self.view.bounds.width * 2
        lblFridayHoura.center.x = self.view.bounds.width * 2
        lblSaturdayHours.center.x = self.view.bounds.width * 2
        lblSundayHours.center.x = self.view.bounds.width * 2
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2.0, delay:0.1,usingSpringWithDamping:0.3,initialSpringVelocity:0.0,options:.curveEaseIn, animations: {
            
            self.lblBusinessType.center.y = self.x1;
          self.lblOwnersName.center.y = self.x2
         self.lblEmail.center.y = self.x3
            self.lblAddress.center.y = self.x4

            },completion:(nil))
        
        UIView.animate(withDuration: 2.0, delay:0.5,usingSpringWithDamping:0.3,initialSpringVelocity:0.0,options:.curveEaseIn, animations: {
            
            self.lblMondayHours.center.x = self.x5
            self.lblTuesdayHours.center.x = self.x6
            self.lblWednesdayHours.center.x = self.x7
            self.lblThursdayHours.center.x = self.x8
            self.lblFridayHoura.center.x = self.x9
            self.lblSaturdayHours.center.x = self.x10
            self.lblSundayHours.center.x = self.x11

            
        },completion:(nil))
        
        
        writeToJson()
    
    }
    func writeToJson(){
        
      
    let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("loco.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
        

    
        
        
        let jsonObject: [String:[String:String]] =
            [
                ownerName: ([
                    "OrganizationName": ownerName ,
                    "EmailAddress": emailAddress ,
                    "Password": password,
                    "Longitude": String(businessCoordinates.longitude),
                    "Latitude": String(businessCoordinates.latitude),
                    "TypeOfOrganization": businessTypeOfficial,
                    "Description":"This is a description",
                    "MondayHours": mondayHours,
                    "TuesdayHours": tuesdayHours ,
                    "WednesdayHours":wednesdayHours ,
                    "ThursdayHours": thrusdayHours,
                    "FridayHours": fridayHours ,
                    "SaturdayHours": satudayHours,
                    "SundayHours":sundayHours ,
                    "Other":"iO1S"
                    ]) 
            ]
        
        

        // creating JSON out of the above array
        var jsonData: NSData!

        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData!
           // let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        

        
        // Write that JSON to the file created earlier
      //  let jsonFilePath = documentsDirectoryPath.URLByAppendingPathComponent("test.json")
        do {
            
            let file = try FileHandle(forWritingTo: jsonFilePath!)

            file.seekToEndOfFile()
            file.write(jsonData as Data)
            print("JSON data was written to teh file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        
        }
    }
    
    
  
}
