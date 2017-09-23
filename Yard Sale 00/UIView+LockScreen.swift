//
//  UIView+LockScreen.swift
//  AC_FlightPass_iOS
//
//  Created by Nicholas Cameron on 2017-04-28.
//  Copyright © 2017 IBM. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func lock(headingText:String?,loadingText:String?,lowerLoadingText:String?) {
        
        
        
        let LoadingView = Bundle.main.loadNibNamed("LoadingGearView", owner: self, options: nil)?.first as? LoadingGearView
        
        
        LoadingView?.tag = 1074
        LoadingView?.alpha = 0.0
        LoadingView?.frame = bounds
        
        if headingText == nil{
            LoadingView?.viewBelowHeader.isHidden = true
            LoadingView?.lblheadingMessage.isHidden = true
            
        }else{
            LoadingView?.lblheadingMessage.text = headingText
            
        }
        if loadingText == nil{
            LoadingView?.lblLoadingMessage.isHidden = true
        }else{
            LoadingView?.lblLoadingMessage.text = loadingText
            
        }
        if lowerLoadingText == nil{
            LoadingView?.lblLowerMessage.isHidden = true
        }else{
            LoadingView?.lblLowerMessage.text = lowerLoadingText
            
        }
        LoadingView?.startAnimating()
        for views in subviews{
            if views == LoadingView || views.tag == 1074{
                views.removeFromSuperview()
            }
        }
        addSubview(LoadingView!)
        
        UIView.animate(withDuration: 0.0) {
            LoadingView?.alpha = 1.0
        }
        
    }
    func unlock(statusCode:Int,checkMarkDuration:Double,lowerLoadingText:String?) {
        
        if let lockView = self.viewWithTag(1074) as? LoadingGearView {
            if statusCode == 200{
                lockView.loadingImageView.image = UIImage(named: "ic_success")
                lockView.returnAnimation()
            }else{
                lockView.loadingImageView.image = UIImage(named: "ic_success")
                lockView.returnAnimation()
            }
            
            
            
            UIView.animate(withDuration: checkMarkDuration, animations: {
                lockView.tag = 1075
                lockView.alpha = 0.0
                if lowerLoadingText != nil{
                    lockView.lblLowerMessage.text = lowerLoadingText
                }
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    
    
    func unlock(statusCode:Int) {
        
        if let lockView = self.viewWithTag(1074) as? LoadingGearView {
            if statusCode == 200{
                lockView.loadingImageView.image = UIImage(named: "ic_success")
                lockView.returnAnimation()
            }else{
                lockView.loadingImageView.image = UIImage(named: "error")
                lockView.returnAnimation()
            }
            
            
            
            
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    lockView.tag = 1075
                    lockView.alpha = 0.0
                }) { finished in
                    DispatchQueue.main.async {
                        lockView.removeFromSuperview()
                    }
                    
                }
            }
        }
    }
    
}
