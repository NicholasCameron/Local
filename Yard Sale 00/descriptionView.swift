//
//  descriptionView.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-29.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class descriptionView: UIView {

    @IBOutlet weak var txtView: UITextView!
    
    
    class func instanceFromNib() -> descriptionView {
        return UINib(nibName: "descriptionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! descriptionView
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
