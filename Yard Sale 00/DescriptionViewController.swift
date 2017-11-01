//
//  DescriptionViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-04-08.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.ViewBackground(image: "descriptionBG")
        descriptionTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        descriptionTextField.becomeFirstResponder()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @available(iOS 2.0, *)
     public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        print(range.length)
        let newLength = (descriptionTextField.text.characters.count + range.length)
        let numbersLeft = 150 - newLength

        
        print(newLength)
        print(numbersLeft)
        lblText.text = "Please explain your organization in " + String(numbersLeft) + " characters!"
        
        
        if newLength == 150{
            descriptionTextField.deleteBackward()
            descriptionTextField.resignFirstResponder()

        }
        if(text == "\n") {
            descriptionTextField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
      
    @available(iOS 2.0, *)
     public func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
      //  performSegue(withIdentifier: "hoursSegue", sender: nil)
        AppController.shared.usersBusiness?._businessDescription = descriptionTextField.text
        descriptionTextField.resignFirstResponder()

        return true
       
    }
    
    @available(iOS 2.0, *)
     public func textViewDidEndEditing(_ textView: UITextView)
    {
        descriptionTextField.resignFirstResponder()

    }
    

}

