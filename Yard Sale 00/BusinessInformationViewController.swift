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

        
        
        imagePicker.delegate = self
        

        lblBusinessType.text = AppController.shared.usersBusiness?._businessCategory;
        lblOwnersName.text = AppController.shared.usersBusiness?._businessName;
        lblEmail.text = AppController.shared.usersBusiness?._businessEmail;
        lblAddress.text = AppController.shared.usersBusiness?._businessAddress;
        
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
            let imagePicker = UIImagePickerController()
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
    
    //BOOM REGISTER
    
    @IBAction func Register(_ sender: Any) {
    
   // let coordinate = mapKit.centerCoordinate
    _ = AppController.shared.usersBusiness?._businessName
        let coordinate = CLLocationCoordinate2D(latitude: Double((AppController.shared.usersBusiness?._businessLatitude)!)!, longitude: Double((AppController.shared.usersBusiness?._businessLongitude)!)!)
  
    
    
    
    
    AppController.shared.businessCoordinates = coordinate;
  
        
        
        let i = UIImageJPEGRepresentation(imageHeader.image!, 0.1)
       // let imageData = UIImagePNGRepresentation(imageHeader.image!) as Data?
        AppController.shared.usersBusiness?._businessImage = i!

        
        
        NoSqlManager.saveBusiness(businessName: AppController.shared.usersBusiness?._businessName, businessCategory: AppController.shared.usersBusiness?._businessCategory, businessDescription: AppController.shared.usersBusiness?._businessDescription, businessEmail: AppController.shared.usersBusiness?._businessEmail, businessImage: AppController.shared.usersBusiness?._businessImage, businessLatidude: AppController.shared.usersBusiness?._businessLatitude, businessLongitude: AppController.shared.usersBusiness?._businessLongitude, businessPhone: AppController.shared.usersBusiness?._businessPhone, businessWebsite: AppController.shared.usersBusiness?._businessWebsite, mondayHours: AppController.shared.usersBusiness?._mondayHours, tuesdayHours: AppController.shared.usersBusiness?._tuesdayHours, wednesdayHours: AppController.shared.usersBusiness?._wednesdayHours, thusdayHours: AppController.shared.usersBusiness?._thursdayHours, fridayHours: AppController.shared.usersBusiness?._fridayHours, saturdayHours: AppController.shared.usersBusiness?._saturdayHours, sundayHours: AppController.shared.usersBusiness?._sundayHours, isBusinessActive: true,firstName:AppController.shared.usersBusiness?._firstName,lastName:AppController.shared.usersBusiness?._lastName,password:nil) { (status) in
            if status == 200{
                
                self.performSegue(withIdentifier: "registeredSegue", sender: self)

            }
        }
        
       // AppController.shared.DataManager.save(organizationName: AppController.shared.ownerName, details:  AppController.shared.businessDescription, emailAddress: AppController.shared.emailAddress, hours:  AppController.shared.businessHours, coordinate: coordinate, password: AppController.shared.password,  typeOfBusiness: AppController.shared.businessTypeOfficial,pinColor:  AppController.shared.pinColor,image:imageData)
        
        
        ///////////////////////////////////////////////////////////
   
    
    }
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
      */
        self.performSegue(withIdentifier: "unwind", sender: self)

    }

    
    
    
  
}
