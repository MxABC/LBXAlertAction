//
//  UIActionSheet+Extension.swift
//  
//
//  Created by lbxia on 16/6/20.
//  Copyright © 2016年 lbx. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

// MARK: - 使用oc关联
extension UIActionSheet:UIActionSheetDelegate
{
    fileprivate static var alertKey = "alertKey"
    
    internal class closureKey:NSObject
    {
        let closure:((_ idx:Int,_ btnTitle:String?) -> Void )?
        
        init( closure:((_ idx:Int,_ btnTitle:String?) -> Void )? ) {
            
            self.closure = closure
        }
    }
    
    fileprivate var sheetClosure:closureKey
    {
        get
        {  
            return objc_getAssociatedObject(self, &UIActionSheet.alertKey) as! closureKey
        }
        set
        {
            objc_setAssociatedObject(self, &UIActionSheet.alertKey,newValue , .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func show(parentView:UIView,completion: ((_ idx:Int,_ btnTitle:String?)->Void)?)
    {
        sheetClosure = closureKey(closure: completion)
        self.delegate = self
        
        self.show(in: parentView)
    }
    
    public func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        let closure = sheetClosure.closure
        
        closure?(buttonIndex,self.buttonTitle(at: buttonIndex)!)
        objc_removeAssociatedObjects(self);
    }
    
}





