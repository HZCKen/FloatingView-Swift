//
//  HZCAnimator.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/14.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//


import UIKit

class HZCAnimator:NSObject, UIViewControllerAnimatedTransitioning {
    
    var currentFrame:CGRect?
    var operation:UINavigationControllerOperation?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let  toView = transitionContext.view(forKey: UITransitionContextViewKey.to) ,
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                
                print("toView = nil or FromView = nil")
                
                return
        }
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        
        guard let operation = self.operation , let currentFrame = self.currentFrame else {
            print("operation = nil or currentFrame = nil")
            return
        }
        
        if operation == .push {
            startAnimating(containerView: containerView, transitionContext: transitionContext, view: toView, fromRect: currentFrame, toRect: toView.bounds, duration: 0.5)

        } else {
            startAnimating(containerView: containerView, transitionContext: transitionContext, view: fromView, fromRect: fromView.bounds, toRect: currentFrame, duration: 0.5)
        }
 
    }
    
    private func startAnimating(containerView: UIView, transitionContext:UIViewControllerContextTransitioning, view: UIView, fromRect: CGRect, toRect: CGRect, duration: TimeInterval) {
        let animatorView = HZCAnimatorView(frame: view.bounds)
        containerView.addSubview(animatorView)
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        animatorView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        animatorView.startAnimating(view: view, fromRect: fromRect, toRect: toRect, duration: duration)
        //MARK:动画时间和延迟时间相等时，不知道为什么会出现一闪的效果
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration - 0.1) {
            transitionContext.completeTransition(true)
        }
    }
    
}
