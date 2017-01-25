//
//  ViewBackground.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-11-13.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func ViewBackground(image: String) {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0,y:0,width:width,height:height))
        imageViewBackground.image = UIImage(named: image)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }}
