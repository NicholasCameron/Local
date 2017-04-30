//
//  LoadingView.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-04-30.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    
    
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var lblheadingMessage: UILabel!
    @IBOutlet weak var lblLoadingMessage: UILabel!
    
    
    
    var animationLayer = CALayer()
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    
    // MARK - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LoadAnimation()
        
    }
    
    // MARK - Func
    
    
    func LoadAnimation(){
        self.alpha = 0
        animationLayer.frame = loadingImageView.frame
        animationLayer.bounds = loadingImageView.bounds
        
        let image = loadingImageView.image?.cgImage
        animationLayer.contents = image
        // animationLayer.masksToBounds = true
        self.layer.addSublayer(animationLayer)
        self.loadingImageView.removeFromSuperview()
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.isHidden = false
        UIView.animate(withDuration:0.3){
            self.alpha = 1
        }
        
    }
    
    
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        
        layer.add(rotation, forKey: "rotate")
    }
    
    func pause(layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
    }
    
    func resume(layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 0.3
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        isAnimating = true
    }
    
    func startAnimating () {
        
        if isAnimating {
            return
        }
        
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(layer: animationLayer)
    }
    
    func stopAnimating () {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(layer: animationLayer)
        self.removeFromSuperview()
    }
    
    
}

extension UIView {
    func lock(headingText:String,loadingText:String) {
        
        
        if let _ = viewWithTag(1074) {
            //View is already locked
        }
        else{
            
            
            let LoadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? LoadingView
            LoadingView?.tag = 1074
            LoadingView?.alpha = 0.0
            
            LoadingView?.frame = frame
            //   LoadingView?.frame.origin.y = 0
            LoadingView?.lblLoadingMessage.text = loadingText
            LoadingView?.lblheadingMessage.text = headingText
            LoadingView?.startAnimating()
            
            addSubview(LoadingView!)
            
            UIView.animate(withDuration: 0.3) {
                LoadingView?.alpha = 1.0
            }
        }
    }
    
    
    func unlock() {
        if let lockView = self.viewWithTag(1074) {
            UIView.animate(withDuration: 0.3, animations: {
                lockView.tag = 1075
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
}

