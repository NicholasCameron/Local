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
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var txtOwnersName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    
    @IBOutlet weak var lblMondayHours: UILabel!
    @IBOutlet weak var lblTuesdayHours: UILabel!
    @IBOutlet weak var lblWednesdayHours: UILabel!
    @IBOutlet weak var lblThursdayHours: UILabel!
    @IBOutlet weak var lblFridayHoura: UILabel!
    @IBOutlet weak var lblSaturdayHours: UILabel!
    @IBOutlet weak var lblSundayHours: UILabel!
    
    
    var txtDescriptionView = descriptionView.instanceFromNib()
var isBeingEdited = Bool()
    
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

        
        //add the view to the stackview but hide it
        txtDescriptionView.txtView.text = AppController.shared.usersBusiness?._businessDescription
        self.stackView.addArrangedSubview(txtDescriptionView)
        txtDescriptionView.txtView.text = AppController.shared.usersBusiness?._businessDescription
        txtDescriptionView.isHidden = true
        self.stackView.addArrangedSubview(txtDescriptionView)
        
        
        imagePicker.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = AppController.shared.usersBusiness?._businessName;
        txtCategory.text = AppController.shared.usersBusiness?._businessCategory;
        txtOwnersName.text = (AppController.shared.usersBusiness?._firstName)! + " " + (AppController.shared.usersBusiness?._lastName)!
        btnDescription.setTitle("Edit Description", for: .normal)
        txtAddress.text = AppController.shared.usersBusiness?._businessAddress;
        
        x1 = txtCategory.center.y;
        x2 = txtOwnersName.center.y;
        x3 = btnDescription.center.y;
        x4 = txtAddress.center.y;

        txtCategory.center.y = 0;
        txtOwnersName.center.y = 0;
        btnDescription.center.y = 0;
        txtAddress.center.y = 0;
        
        
        
        
        
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
    
    
    func doneBtnTapped(){
        
    }
    
    
    //MARK:EDIT MODE
    
    
    @IBAction func btnDescriptionTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            if !self.isBeingEdited{
                self.btnDescription.setTitle("Done", for: .normal)
                self.isBeingEdited = true
                for view in self.stackView.subviews{
                    if view == self.txtDescriptionView{
                        view.isHidden = false
                        view.alpha = 1
                    }else{
                        view.alpha = 0
                        view.isHidden = true
                    }
                }
           
                
            }else{
                self.btnDescription.setTitle("Edit Description", for: .normal)
                self.isBeingEdited = false
                for view in self.stackView.subviews{
                    if view == self.txtDescriptionView{
                        view.isHidden = true
                        view.alpha = 0
                    }else{
                        view.alpha = 1
                        view.isHidden = false
                    }
                }
            }
       }
    }
    
    
    @IBAction func editBtnTapped(_ sender: Any) {
      
        if btnEdit.title != "Done"{
            btnEdit.title = "Done"
            txtOwnersName.borderStyle = .roundedRect
            txtAddress.borderStyle = .roundedRect
            btnDescription.backgroundColor = .white
            txtCategory.borderStyle = .roundedRect
            txtPhone.borderStyle = .roundedRect
            txtPhone.isEnabled = true
            txtAddress.isEnabled = true
            btnDescription.isEnabled = true
            txtCategory.isEnabled = true
            txtOwnersName.isEnabled = true
        }else{
            btnEdit.title = "Edit"
            txtOwnersName.borderStyle = .none
            txtOwnersName.isEnabled = false
            txtPhone.isEnabled = false
            txtAddress.isEnabled = false
            btnDescription.isEnabled = false
            txtCategory.isEnabled = false
            txtOwnersName.isEnabled = false
            txtAddress.borderStyle = .none
            btnDescription.backgroundColor = .clear
            txtCategory.borderStyle = .none
            txtPhone.borderStyle = .none
            
            
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
            
            self.txtCategory.center.y = self.x1;
          self.txtOwnersName.center.y = self.x2
         self.btnDescription.center.y = self.x3
            self.txtAddress.center.y = self.x4

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
        AppController.shared.usersBusiness?._activeBusiness = true
        
        
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
