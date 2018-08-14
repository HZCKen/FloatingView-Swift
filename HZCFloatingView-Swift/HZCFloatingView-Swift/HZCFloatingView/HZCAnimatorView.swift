//
//  HZCAnimatorView.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/14.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

import UIKit

class HZCAnimatorView: UIImageView {
    
    private lazy var shapeLayer = CAShapeLayer()
    private var toView:UIView?

    func startAnimating(view:UIView, fromRect:CGRect, toRect:CGRect, duration:TimeInterval) {
        self.toView = view
        self.toView?.isHidden = true
        self.shapeLayer.path = UIBezierPath(roundedRect: fromRect, cornerRadius: 30.0).cgPath
        self.layer.mask = self.shapeLayer
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.toValue = UIBezierPath(roundedRect: toRect, cornerRadius: 30.0).cgPath
        anim.duration = duration
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        anim.delegate = self
        self.shapeLayer.add(anim, forKey: nil)
        
    }

}

extension HZCAnimatorView:CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.toView?.isHidden = false
        self.shapeLayer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
}
