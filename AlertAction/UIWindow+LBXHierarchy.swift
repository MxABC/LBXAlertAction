//
//  AlertAction.swift
//
//
//  Created by lbxia on 16/6/20.
//  Copyright © 2016年 lbx. All rights reserved.
//

import UIKit

/** @abstract UIWindow hierarchy category.  */
public extension UIWindow {

    /** @return Returns the current Top Most ViewController in hierarchy.   */
     public func topController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    /** @return Returns the topViewController in stack of topController.    */
    public func currentTopViewController()->UIViewController? {
        
        var currentViewController = topController()
        
        while currentViewController != nil
            && currentViewController is UITabBarController
            && (currentViewController as! UITabBarController).selectedViewController != nil
        {
            currentViewController = (currentViewController as! UITabBarController).selectedViewController
        }
        
        while currentViewController != nil
            && currentViewController is UINavigationController
            && (currentViewController as! UINavigationController).topViewController != nil
        {
                
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }

        return currentViewController
    }
}
