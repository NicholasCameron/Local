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
        descriptionTextField.isFirstResponder = true
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
        
        
        if newLength == 100{
            descriptionTextField.deleteBackward()
            
        }
        
        return true
    }

}

