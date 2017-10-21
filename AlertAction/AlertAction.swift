//
//  AlertAction.swift
//  
//
//  Created by lbxia on 16/6/20.
//  Copyright © 2016年 lbx. All rights reserved.
//

import Foundation
import UIKit

open class AlertAction: NSObject
{
    /**
     获取最上层控制器
     
     - returns: 最上层控制器
     */
    open static func currentViewController() -> UIViewController? {
        
        return UIApplication.shared.keyWindow?.currentTopViewController()
    }
    
    
    /**
     弹出选择对话框
     
     - parameter title:         标题
     - parameter message:       消息内容
     - parameter btnStatements: 按钮，数组存储，第一个默认取消按钮
     - parameter closure:       用户点击闭包返回
     */
    open static func showAlert( title:String,message:String,btnStatements:Array<String>,completion:((_ buttonIndex:Int)->Void)? )
    {
        if #available(iOS 8.0, *)
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for (index,item) in btnStatements.enumerated() {
                
                let style:UIAlertActionStyle = (index != 0) ? .default:.cancel
                
                let action = UIAlertAction(title: item, style: style, handler: { (action) in
                    
                    completion?(index)
                    
                })
                
                alert.addAction(action)
            }
            
            
            if let topVC = currentViewController()
            {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            // Fallback on earlier versions
            
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: btnStatements[0])
            
            var bs = btnStatements
            bs.remove(at: 0)
            for title in bs
            {
                alert.addButton(withTitle: title)
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
    open static func showSheet(title:String,message:String,destructiveButtonTitle:String?,cancelButtonTitle:String, otherButtonTitles:[String]?,completion: ( (_ buttonIdx:Int,_ itemTitle:String?) -> Void )? )
    {
        if #available(iOS 8.0, *)
        {
             let topVC = currentViewController()
            
            if (topVC == nil) {
                return
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            var idxDiff = 0
            
            if (destructiveButtonTitle != nil)
            {
                let actionDestructive = UIAlertAction(title: destructiveButtonTitle, style: .destructive, handler: { (action) in
                    
                    completion?(0,action.title)
                    
                })
                alertController.addAction(actionDestructive)
                idxDiff += 1
            }
            
            
            
            let actionCancel = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (action) in
                
                completion?(idxDiff,action.title)
            })
            
            alertController.addAction(actionCancel)
    
            
            
            if (otherButtonTitles != nil)
            {
                for (idx,item) in otherButtonTitles!.enumerated()
                {
                    
                    let action = UIAlertAction(title: item, style: .default, handler: { (action) in
                        
                        completion?(idx+idxDiff+1,action.title)
                        
                    })
                    alertController.addAction(action)
                }
            }
            topVC! .present(alertController, animated: true, completion: nil)
            
        }
        else
        {
            let topVC = currentViewController()
            
            if (topVC == nil)
            {
                return
            }
            
            let sheet = UIActionSheet(title: title, delegate: nil, cancelButtonTitle: cancelButtonTitle, destructiveButtonTitle: destructiveButtonTitle)
            
            if (otherButtonTitles != nil)
            {
                for item in otherButtonTitles!
                {
                    sheet.addButton(withTitle: item)
                }
            }
           sheet.show(parentView: topVC!.view, completion: completion)
        }
    }
    
}
