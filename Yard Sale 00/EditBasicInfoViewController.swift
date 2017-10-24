//
//  EditBasicInfoViewController.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-14.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class EditBasicInfoViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate {

    
    @IBOutlet weak var txtBusinessName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var bizName:String?
    var bizDescription:String?
    var bizPhone:String?
    var bizCategory:String?
    
    var pickerData = ["CoffeeShop","Resturant","GiftShop","Golf","Food","Entertainment","Shop","Fun","Exercise", "Trail"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for category in pickerData{
            
            if category == AppController.shared.usersBusiness?._businessCategory{
            self.pickerData = pickerData.sorted(by: {$0.0 == category})
            }
        }
        
        
        txtBusinessName.delegate = self
        txtDescription.delegate = self
        txtPhone.delegate = self
        categoryPicker.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(EditBasicInfoViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditBasicInfoViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // function which is triggered when handleTap is called
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    ///PICKER VIEW PROTOCOLS.
    
    
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        bizCategory = pickerData[row]
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
        
        //  AppController.shared.pinColor = pinColorValue

    }

    //END OF PICKER VIEW

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y == 0 && (!txtDescription.isFirstResponder && !txtBusinessName.isFirstResponder)){
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y != 0 && (!txtDescription.isFirstResponder && !txtBusinessName.isFirstResponder)){
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @available(iOS 2.0, *)
    public func textViewDidEndEditing(_ textView: UITextView)
    {
        txtDescription.resignFirstResponder()
        
    }

    @IBAction func btnUpdateTapped(_ sender: Any) {
        
        var updatedName:String?
        var updatedDescription:String?
        var updatedPhone:String?
        var updatedCategory:String?

        if txtBusinessName.text != ""{
          //AppController.shared.usersBusiness?._businessName = txtBusinessName.text!
           bizName = txtBusinessName.text!
        }else if txtDescription.text != ""{
           // AppController.shared.usersBusiness?._businessDescription = txtDescription.text!
            bizDescription = txtDescription.text!
        }else if txtPhone.text != ""{
             //AppController.shared.usersBusiness?._businessPhone = txtPhone.text!
            bizPhone = txtPhone.text!
        }
        
        if bizName != AppController.shared.usersBusiness?._businessName && bizName != nil{
            updatedName = bizName
        }
        if bizDescription !=  AppController.shared.usersBusiness?._businessDescription && bizDescription != nil{
            updatedDescription = bizDescription
        }
        if bizCategory != AppController.shared.usersBusiness?._businessCategory && bizCategory != nil{
            updatedCategory = bizCategory
        }
        
        if bizPhone != AppController.shared.usersBusiness?._businessPhone && bizPhone != nil{
            updatedPhone = bizPhone
        }
        
        if updatedName == nil && updatedDescription == nil && updatedPhone == nil && updatedCategory == nil{
               updateBusiness()
        }else{
            
            dataChangeAlert(updatedName: updatedName, updatedDescription: updatedDescription, updatedCategory: updatedCategory, updatedPhone: updatedPhone)
        }
    }
    
    
    func updateBusiness(){
        
        NoSqlManager.updateBusiness(business: AppController.shared.usersBusiness!) { (status) in
            if status == 200{
                self.navigationController?.popViewController(animated: true)
                
            }else{
                
            }
        }
        
    }
    
    func dataChangeAlert(updatedName:String?,updatedDescription:String?,updatedCategory:String?,updatedPhone:String?){
    
        
        var message = "You are about to update the details below: \n"
        
        if updatedName != nil{
            message.append("Business Name: ")
            message.append(updatedName!)
            message.append("\n")
        }
        if updatedDescription != nil{

            message.append("Business Description: ")

            var description = String()
            for (index,character) in (updatedDescription?.characters.enumerated())!{
                description.append(character)
                if index > 8{
                    break
                }
            }
            description.append("...")
            message.append(description)
            message.append("\n")
        }
        if updatedCategory != nil{
            message.append("Business Category: ")
            message.append(updatedCategory!)
            message.append("\n")
        }
        if updatedPhone != nil{
            message.append("Business Phone: ")
            message.append(updatedPhone!)
       
        }
        
            let refreshAlert = UIAlertController(title: "WARNING", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.updateBusiness()
            }))
    
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
            DispatchQueue.main.async {
                self.present(refreshAlert, animated: true, completion: nil)
            }
        }

    
    
    
}
