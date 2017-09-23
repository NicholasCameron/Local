//
//  LoadingGearView.swift
//  AC_FlightPass_iOS
//
//  Created by Nicholas Cameron on 2017-04-24.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit
import QuartzCore


class LoadingGearView: UIView {
    // MARK - Variables
    
    
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var lblheadingMessage: UILabel!
    @IBOutlet weak var lblLoadingMessage: UILabel!
    @IBOutlet weak var viewBelowHeader: UIView!
    @IBOutlet weak var lblLowerMessage: UILabel!
    
    
    
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
        animationLayer = loadingImageView.layer
        
        addRotation(forLayer: self.loadingImageView.layer)
        pause(layer: self.loadingImageView.layer)
        self.isHidden = false
        UIView.animate(withDuration:0.3){
            self.alpha = 1
        }
        
    }
    func returnAnimation(){
        
        animationLayer.removeAllAnimations()
    }
    
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(value: 3.14 * 2.0)
        rotation.toValue = NSNumber(value: 0.0)
        
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
