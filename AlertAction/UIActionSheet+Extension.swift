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
    private static var alertKey = "alertKey"
    
    internal class closureKey:NSObject
    {
        let closure:((idx:Int,btnTitle:String?) -> Void )?
        
        init( closure:((idx:Int,btnTitle:String?) -> Void )? ) {
            
            self.closure = closure
        }
    }
    
    private var sheetClosure:closureKey
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
    
    public func show(parentView parentView:UIView,completion: ((idx:Int,btnTitle:String?)->Void)?)
    {
        sheetClosure = closureKey(closure: completion)
        self.delegate = self
        
        self.showInView(parentView)
    }
    
    public func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        let closure = sheetClosure.closure
        
        if closure != nil
        {
            closure!(idx: buttonIndex,btnTitle: self.buttonTitleAtIndex(buttonIndex)!)
        }
        
        objc_removeAssociatedObjects(self);
    }
    
}





