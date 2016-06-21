//
//  AlertAction.swift
//  
//
//  Created by lbxia on 16/6/20.
//  Copyright © 2016年 lbx. All rights reserved.
//

import Foundation
import UIKit

public class AlertAction: NSObject
{
    /**
     获取最上层控制器
     
     - returns: 最上层控制器
     */
    public static func AppTopViewController() -> UIViewController? {
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
    
    
    /**
     弹出选择对话框
     
     - parameter title:         标题
     - parameter message:       消息内容
     - parameter btnStatements: 按钮，数组存储，第一个默认取消按钮
     - parameter closure:       用户点击闭包返回
     */
    public static func showAlert( title title:String,message:String,btnStatements:Array<String>,completion:((buttonIndex:Int)->Void)? )
    {
        if #available(iOS 8.0, *)
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            for (index,item) in btnStatements.enumerate() {
                
                let style:UIAlertActionStyle = (index != 0) ? .Default:.Cancel
                
                let action = UIAlertAction(title: item, style: style, handler: { (action) in
                    
                    if completion != nil
                    {
                        completion!(buttonIndex: index)
                    }
                })
                
                alert.addAction(action)
            }
            
            let topVC = AppTopViewController()
            if  topVC != nil
            {
                topVC!.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else
        {
            // Fallback on earlier versions
            
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: btnStatements[0])
            
            var bs = btnStatements
            bs.removeAtIndex(0)
            for title in bs
            {
                alert.addButtonWithTitle(title)
            }
            alert.show(completion)
        }
    }
    
    
    /**
     弹出列表选择对话框，从界面底部弹出，sheet形式
     
     - parameter title:                  标题
     - parameter message:                消息内容
     - parameter destructiveButtonTitle: 默认选项，红色显示
     - parameter cancelButtonTitle:      取消选项
     - parameter otherButtonTitles:      其他选项
     - parameter closure:                闭包返回用户点击结果
     */
    public static func showSheet(title title:String,message:String,destructiveButtonTitle:String?,cancelButtonTitle:String, otherButtonTitles:[String]?,completion: ( (buttonIdx:Int,itemTitle:String?) -> Void )? )
    {
        if #available(iOS 8.0, *)
        {
            let topVC = AppTopViewController()
            
            if topVC == nil
            {
                return
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            var idxDiff = 0
            
            if destructiveButtonTitle != nil
            {
                let actionDestructive = UIAlertAction(title: destructiveButtonTitle, style: .Destructive, handler: { (action) in
                    
                    if completion != nil
                    {
                        completion!(buttonIdx:0,itemTitle:action.title)
                    }
                })
                alertController.addAction(actionDestructive)
                idxDiff += 1
            }
            
            
            
            let actionCancel = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler: { (action) in
                
                if completion != nil
                {
                    completion!(buttonIdx:idxDiff,itemTitle:action.title)
                }
            })
            
            alertController.addAction(actionCancel)
    
            
            
            if otherButtonTitles != nil
            {
                for (idx,item) in otherButtonTitles!.enumerate()
                {
                    
                    let action = UIAlertAction(title: item, style: .Default, handler: { (action) in
                        
                        if completion != nil
                        {
                            completion!(buttonIdx:idx+idxDiff+1,itemTitle:action.title)
                        }
                    })
                    alertController.addAction(action)
                }
            }
            topVC! .presentViewController(alertController, animated: true, completion: nil)
            
        }
        else
        {
            let topVC = AppTopViewController()
            
            if topVC == nil
            {
                return
            }
            
            let sheet = UIActionSheet(title: title, delegate: nil, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
            
            if otherButtonTitles != nil
            {
                for item in otherButtonTitles!
                {
                    sheet.addButtonWithTitle(item)
                }
            }
           sheet.show(parentView: topVC!.view, completion: completion)
        }
    }
    
}