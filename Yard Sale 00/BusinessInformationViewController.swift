//
//  BusinessInformationViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-11-20.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import MapKit



class BusinessInformationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageHeader: UIImageView!
    
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
    
    var delegate: AddGeotificationDelegate?
    let imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()

        viewInfo.alpha = 0
        
        
        imagePicker.delegate = self
        
       self.view.ViewBackground(image: "ocean")

        
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

    @IBOutlet weak var btnUploadImage: UIButton!
    @IBAction func btnUploadImageClicked(_ sender: Any) {
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
}
    
    
    
    @available(iOS 2.0, *)
     public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageHeader.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
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

        },completion:nil)
        
        UIView.animate(withDuration: 2.0, delay:0.5,usingSpringWithDamping:0.3,initialSpringVelocity:0.0,options:.curveEaseIn, animations: {
            
            self.lblMondayHours.center.x = self.x5
            self.lblTuesdayHours.center.x = self.x6
            self.lblWednesdayHours.center.x = self.x7
            self.lblThursdayHours.center.x = self.x8
            self.lblFridayHoura.center.x = self.x9
            self.lblSaturdayHours.center.x = self.x10
            self.lblSundayHours.center.x = self.x11

            
        },completion:(nil))
        
        
        addToCoreData()
    
    }
    func addToCoreData(){
        
      
   
    }
    
    @IBOutlet weak var viewInfo: UIView!
    
    
    @IBAction func headerInfoBtnClicked(_ sender: Any) {
        
        UIView.animate(withDuration: 2, delay: 0,options: [], animations: {
            
            
            self.viewInfo.alpha = 1
            
        }, completion: nil)
        
        
    }
    
    @IBAction func btnCloseInfo(_ sender: Any) {
        
        UIView.animate(withDuration: 2, delay: 0,options: [], animations: {
            
            
            self.viewInfo.alpha = 0
            
        }, completion: nil)
        
        
    }
    //BOOM REGISTER
    
    @IBAction func Register(_ sender: Any) {
    
   // let coordinate = mapKit.centerCoordinate
    let businessName = ownerName
        let coordinate = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
  
    
    
    
    
    businessTypeOfficial = businessDescription;
    businessCoordinates = coordinate;
  
        
        
        let imageData = NSData(data: UIImageJPEGRepresentation(imageHeader.image!, 1.0)!)
        
        
        
        DataManager.save(organizationName: ownerName, details: businessDescription, emailAddress: emailAddress, hours: businessHours, coordinate: coordinate, password: password,  typeOfBusiness: businessTypeOfficial, pinColor: pinColor,image:imageData)
        
        
        ///////////////////////////////////////////////////////////
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
    self.present(nextViewController, animated:true, completion:nil)

    
    }
    
    
    
    
  
}
