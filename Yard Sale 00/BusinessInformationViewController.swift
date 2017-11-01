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
    
    @IBOutlet weak var txtOwnersName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnEditAddress: UIButton!
    @IBOutlet weak var btnEditCategory: UIButton!
    
    
    
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    @IBOutlet weak var lblMondayHours: UILabel!
    @IBOutlet weak var lblTuesdayHours: UILabel!
    @IBOutlet weak var lblWednesdayHours: UILabel!
    @IBOutlet weak var lblThursdayHours: UILabel!
    @IBOutlet weak var lblFridayHoura: UILabel!
    @IBOutlet weak var lblSaturdayHours: UILabel!
    @IBOutlet weak var lblSundayHours: UILabel!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var btnEditHours: UIButton!
    
    
    
    
    
    var isBeingEdited = Bool()
    
    var delegate: AddGeotificationDelegate?
    let imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        imagePicker.delegate = self
        btnEditHours.isHidden = true
        btnEditAddress.isHidden = true
        btnEditCategory.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    func setupView(){
     
        //add the view to the stackview but hide it
        txtPhone.text = AppController.shared.usersBusiness?._businessPhone
        self.title = AppController.shared.usersBusiness?._businessName
        lblCategory.text = AppController.shared.usersBusiness?._businessCategory;
        txtOwnersName.text = (AppController.shared.usersBusiness?._firstName)! + " " + (AppController.shared.usersBusiness?._lastName)!
        lblAddress.text = AppController.shared.usersBusiness?._businessAddress;
        lblMondayHours.text = mondayHours;
        lblTuesdayHours.text = tuesdayHours
        lblWednesdayHours.text = wednesdayHours
        lblThursdayHours.text = thrusdayHours
        lblFridayHoura.text = fridayHours
        lblSaturdayHours.text = satudayHours
        lblSundayHours.text = sundayHours
    }

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
    
    
    @IBAction func btnAddressTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AddGeoVC = storyboard.instantiateViewController(withIdentifier: "addGeotification") as! AddGeotification
        AddGeoVC.isEditingLocation = true
        self.navigationController?.pushViewController(AddGeoVC, animated: true)
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AddGeoVC = storyboard.instantiateViewController(withIdentifier: "addGeotification") as! AddGeotification
        AddGeoVC.isEditingCategory = true
        self.navigationController?.pushViewController(AddGeoVC, animated: true)
        
    }
    
    @IBAction func editHoursTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hoursVC = storyboard.instantiateViewController(withIdentifier: "hoursVC") as! Register01
        hoursVC.isBeingEdited = true
        self.navigationController?.pushViewController(hoursVC, animated: true)
        
    }
    
    
    
    
    @IBAction func editBtnTapped(_ sender: Any) {
      
        if btnEdit.title != "Done"{
            isBeingEdited = true
            btnEditAddress.isHidden = false
            btnEditCategory.isHidden = false
            btnEdit.title = "Done"
            self.btnEditHours.isHidden = false
            txtOwnersName.borderStyle = .roundedRect
            txtOwnersName.isEnabled = true
            txtPhone.borderStyle = .roundedRect
            txtPhone.isEnabled = true
        }else{
            btnEdit.title = "Edit"
            isBeingEdited = false
            btnEditAddress.isHidden = true
            btnEditCategory.isHidden = true
            
            self.btnEditHours.isHidden = true
            txtPhone.borderStyle = .none
            txtPhone.isEnabled = false
            txtOwnersName.borderStyle = .none
            txtOwnersName.isEnabled = false
          
            
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
    
    
    }
   
    func updateBusinessInformation(){
        AppController.shared.usersBusiness?._businessCategory = lblCategory.text
        let firstAndLastName = txtOwnersName.text?.split(separator: " ")
        if let fNR = firstAndLastName{
            if fNR.count > 1{
                AppController.shared.usersBusiness?._firstName = String(fNR[0])
                AppController.shared.usersBusiness?._lastName = String(fNR[1])
            }
        }
        
         AppController.shared.usersBusiness?._businessAddress = lblAddress.text
        mondayHours = lblMondayHours.text!
        tuesdayHours = lblTuesdayHours.text!
        wednesdayHours = lblWednesdayHours.text!
        thrusdayHours = lblThursdayHours.text!
        fridayHours = lblFridayHoura.text!
        satudayHours = lblSaturdayHours.text!
        sundayHours = lblSundayHours.text!
        
    }
    
    //BOOM REGISTER
    @IBAction func Register(_ sender: Any) {
    
        updateBusinessInformation()
        
        if isBeingEdited{
//alert and if press ok then register them.
        
        }else{
        _ = AppController.shared.usersBusiness?._businessName
            let coordinate = CLLocationCoordinate2D(latitude: Double((AppController.shared.usersBusiness?._businessLatitude)!)!, longitude: Double((AppController.shared.usersBusiness?._businessLongitude)!)!)
      
            AppController.shared.businessCoordinates = coordinate;
            let i = UIImageJPEGRepresentation(imageHeader.image!, 0.1)
            AppController.shared.usersBusiness?._businessImage = i!
            AppController.shared.usersBusiness?._activeBusiness = true

            NoSqlManager.saveBusiness(businessName: AppController.shared.usersBusiness?._businessName, businessCategory: AppController.shared.usersBusiness?._businessCategory, businessDescription: AppController.shared.usersBusiness?._businessDescription, businessEmail: AppController.shared.usersBusiness?._businessEmail, businessImage: AppController.shared.usersBusiness?._businessImage, businessLatidude: AppController.shared.usersBusiness?._businessLatitude, businessLongitude: AppController.shared.usersBusiness?._businessLongitude, businessPhone: AppController.shared.usersBusiness?._businessPhone, businessWebsite: AppController.shared.usersBusiness?._businessWebsite, mondayHours: AppController.shared.usersBusiness?._mondayHours, tuesdayHours: AppController.shared.usersBusiness?._tuesdayHours, wednesdayHours: AppController.shared.usersBusiness?._wednesdayHours, thusdayHours: AppController.shared.usersBusiness?._thursdayHours, fridayHours: AppController.shared.usersBusiness?._fridayHours, saturdayHours: AppController.shared.usersBusiness?._saturdayHours, sundayHours: AppController.shared.usersBusiness?._sundayHours, isBusinessActive: true,firstName:AppController.shared.usersBusiness?._firstName,lastName:AppController.shared.usersBusiness?._lastName,password:nil) { (status) in
                if status == 200{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "registeredSegue", sender: self)
                    }
                }
            }
        }
    }
   

    
    
    
  
}
