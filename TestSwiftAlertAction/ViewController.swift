//
//  ViewController.swift
//  TestSwiftAlertAction
//
//  Created by lbxia on 16/6/17.
//  Copyright © 2016年 lbx. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
    }

    @IBAction func testAlertView(_ sender: AnyObject)
    {

//        let alert = UIAlertView(title: "title", message: "message", delegate: nil, cancelButtonTitle: "cance", otherButtonTitles: "sure", "sure2")
//        
//        alert .show { (buttonIndex) in
//            
//            print(buttonIndex)
//        }
        
        let items = ["cancel","ok1","ok2"];
        
        AlertAction.showAlert(title: "title", message: "message", btnStatements:items )
        {
            (buttonIndex) in
            
            
            let items = ["cancel","ok1","ok2"];
            
            print(buttonIndex)
            
            print(items[buttonIndex])
          
        }
    }
    
    @IBAction func testSheetView(_ sender: AnyObject)
    {
        let destrucitve:String? = "destructive"
        
//        let destrucitve:String? = nil
        
        AlertAction.showSheet(title: "title", message: "ios8之后才会显示本条信息",  destructiveButtonTitle: destrucitve,cancelButtonTitle: "cancel", otherButtonTitles: ["other1","other2"]) { (buttonIdx, itemTitle) in
            
            /*
             经测试
             buttonIdx：  destructiveButtonTitle 为0， cancelButtonTitle 为1，otherButtonTitles按顺序增加
             如果destructiveButtonTitle 传入值为nil,那么 cancelButtonTitle 为0，otherButtonTitles按顺序增加
             
             或者按照itemTitle来判断用户点击那个按钮更稳妥
             */
            
            print(buttonIdx)
            print(itemTitle)
        }

    }
    
    func alertResult(_ buttonIndex:Int) -> Void
    {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

