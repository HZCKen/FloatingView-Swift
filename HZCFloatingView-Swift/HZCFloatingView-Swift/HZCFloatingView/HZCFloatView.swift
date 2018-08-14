//
//  HZCFloatView.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/10.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

import UIKit

let fixedSpace:CGFloat = 160.0;

class HZCFloatView: UIView {
    
    private static let floatView = HZCFloatView(frame: CGRect(x: 10, y: 80, width: 60, height: 60))
    private static let semiCircleView = HZCSemiCircleView(frame: CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: fixedSpace, height: fixedSpace))

    private var lastPoint = CGPoint.zero
    
    private var pointInSelf = CGPoint.zero
    
    private var floatingVC:UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.contents = UIImage(named: "FloatingView@2x.png")?.cgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func showWithViewController(floatingVC:UIViewController) {
        
        if semiCircleView.superview == nil {
            UIApplication.shared.keyWindow?.addSubview(semiCircleView)
            UIApplication.shared.keyWindow?.bringSubview(toFront: semiCircleView)
        }
        
        
        if (floatView.superview == nil) {
            UIApplication.shared.keyWindow?.addSubview(floatView)
            UIApplication.shared.keyWindow?.bringSubview(toFront: floatView)
        }
        
        floatView.frame = CGRect(x: 10, y: 80, width: 60, height: 60)
        floatView.floatingVC = floatingVC
        floatingVC.navigationController?.delegate = floatView;
        floatingVC.navigationController?.popViewController(animated: true)
    }
    
    class func remove() {
        floatView.floatingVC?.navigationController?.delegate = nil
        floatView.floatingVC = nil
        floatView.removeFromSuperview()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()! as! UITouch
        lastPoint = touch.location(in: self.superview)
        pointInSelf = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()! as! UITouch
        let currentPoint = touch.location(in: self.superview)
        
        if HZCFloatView.semiCircleView.frame == CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: fixedSpace, height: fixedSpace) {
            UIView.animate(withDuration: 0.25) {
                HZCFloatView.semiCircleView.frame = CGRect(x: UIScreen.main.bounds.width - fixedSpace, y: UIScreen.main.bounds.height - fixedSpace, width: fixedSpace, height: fixedSpace)
            }
        }
        
        
        //计算当前的中心点
        let centerX = currentPoint.x - (frame.width/2 - pointInSelf.x)
        let centerY = currentPoint.y - (frame.height/2 - pointInSelf.y)
        //修改中心点的坐标
        let x = max(30.0, min(UIScreen.main.bounds.width - 30.0, centerX))
        let y = max(30.0, min(UIScreen.main.bounds.height - 30.0, centerY))
        
        center = CGPoint(x: x, y: y)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()! as! UITouch
        let currentPoint = touch.location(in: self.superview)
        
        if __CGPointEqualToPoint(lastPoint, currentPoint) {
            /// 点击操作
            distanceLeftOrRightMarginNeedAnimationMove(isAnimation: false)
            HZCFloatView.semiCircleView.frame = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: fixedSpace, height: fixedSpace)
            

            if let floatingVC = self.floatingVC , let nav = self.hzc_currentNavigationController() {
                nav.delegate = self
                nav.pushViewController(floatingVC, animated: true)
            } else {
                 print("没有导航栏或者没有浮窗控制器")
            }
            
            return
        }
        
        //动画收缩
        UIView.animate(withDuration: 0.25) {
            /// 如果floatingView在semiCircleView内部，就移除
            /// 计算2个圆心的距离
            
            let distance = CGFloat(sqrt(powf(Float(UIScreen.main.bounds.width - self.center.x), 2)+powf(Float(UIScreen.main.bounds.height-self.center.y), 2)))
            
            if distance <= fixedSpace-30 {
                HZCFloatView.remove()
            }
            
            HZCFloatView.semiCircleView.frame = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: fixedSpace, height: fixedSpace)
        }
        
        
        distanceLeftOrRightMarginNeedAnimationMove(isAnimation: true)
        
        
    }
    
    ///计算左右的距离并且是否需要动画移动
    private func distanceLeftOrRightMarginNeedAnimationMove(isAnimation: Bool) {
        
        let duartion = isAnimation ? 0.25:0
        
        let leftMargin = center.x
        let rightMargin = UIScreen.main.bounds.width - leftMargin
        
        let centerX = leftMargin < rightMargin ? 40.0 : UIScreen.main.bounds.width - 40.0
        
        UIView.animate(withDuration: duartion) {
            self.center = CGPoint(x: centerX, y: self.center.y)
        }
    }
}

extension HZCFloatView:UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        if let floatingVC = self.floatingVC {
            let animator = HZCAnimator()
            animator.currentFrame = frame
            animator.operation = operation
            if operation == .push {
                if toVC != floatingVC{
                    return nil
                }
                self.isHidden = true
                return animator
            } else if operation == .pop {
                if fromVC != floatingVC {
                    return nil
                }
                self.isHidden = false
                return animator
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }
}


