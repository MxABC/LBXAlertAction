//
//  UIAlertView+Extension.swift
//  
//
//  Created by lbxia on 16/6/17.
//  Copyright © 2016年 lbx. All rights reserved.
//

import Foundation
import UIKit

import ObjectiveC


// MARK: - 使用oc关联
extension UIAlertView
{
    fileprivate static var alertKey = "alertKey"
    
    internal class closureKey : NSObject
    {
        let closure:((_ buttonIndex:Int) -> Void)?
        
        init( closure:((_ buttonIndex:Int)->Void)? ) {
            
            self.closure = closure
        }
    }
    
    fileprivate var alertClosure:closureKey
    {
        get
        {
            return objc_getAssociatedObject(self, &UIAlertView.alertKey) as! closureKey
        }
        set
        {
            objc_setAssociatedObject(self, &UIAlertView.alertKey,newValue , .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func show(_ completion:((_ buttonIndex:Int)->Void)?) -> Void
    {
        alertClosure = closureKey(closure: completion)
        self.delegate = self;
        self.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        alertClosure.closure?(buttonIndex)
        objc_removeAssociatedObjects(self);
        
    }
}

