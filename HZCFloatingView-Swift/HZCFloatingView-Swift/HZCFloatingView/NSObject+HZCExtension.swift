//
//  NSObject+HZCExtension.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/14.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

import UIKit

extension NSObject {
    
    func hzc_currentViewController() -> UIViewController? {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        
        guard var rootVC = vc else { return nil }
        
        while true {
            if rootVC.isKind(of: UITabBarController.self)  {
                rootVC = (rootVC as! UITabBarController).selectedViewController!
            }
            
            if rootVC.isKind(of: UINavigationController.self) {
                rootVC = (rootVC as! UINavigationController).visibleViewController!
            }
            
            if (rootVC.presentingViewController != nil) {
                rootVC = rootVC.presentingViewController!
            } else {
                break;
            }
            
        }
        
        return rootVC
    }
    
    func hzc_currentNavigationController() -> UINavigationController? {
        return self.hzc_currentViewController()?.navigationController
    }
    
    func hzc_currentTabBarController() -> UITabBarController? {
        return self.hzc_currentViewController()?.tabBarController
    }
    
    
}
