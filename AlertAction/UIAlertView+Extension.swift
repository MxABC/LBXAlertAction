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
    private static var alertKey = "alertKey"
    
    internal class closureKey : NSObject
    {
        let closure:((buttonIndex:Int) -> Void)?
        
        init( closure:((buttonIndex:Int)->Void)? ) {
            
            self.closure = closure
        }
    }

    private var alertClosure:closureKey
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
    
    public func show(result:((buttonIndex:Int)->Void)?) -> Void
    {
        alertClosure = closureKey(closure: result)
        self.delegate = self;
        self.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
       
        
        if alertClosure.closure != nil
        {
            alertClosure.closure!(buttonIndex: buttonIndex)
        }
        
         objc_removeAssociatedObjects(self);

    }
}

