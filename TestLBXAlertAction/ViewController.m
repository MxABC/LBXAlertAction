//
//  ViewController.m
//  TestLBXAlertAction
//
//  Created by lbxia on 15/11/12.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ViewController.h"
#import "LBXAlertAction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAlert:(id)sender {
    
    
    [LBXAlertAction showAlertWithTitle:@"标题" msg:@"提示消息内容" chooseBlock:^(NSInteger idx)
     {
         //取消为0，后面的按顺序从1开始...
         NSLog(@"%ld",idx);
         
     }buttonsStatement:@"取消",@"确认1",@"确认2",@"确认3",@"确认4",@"确认5",@"确认6",nil];
    
    
//    [LBXAlertAction showAlertWithTitle:@"标题" msg:@"提示消息内容" chooseBlock:^(NSInteger idx)
//     {
//         //取消为0，后面的按顺序
//         NSLog(@"%ld",idx);
//         
//     }buttonsStatement:@"取消",@"确认1",nil];


}
- (IBAction)btnSheet:(id)sender {
    
    
    //    参数说明：
    //    title：视图标题
    //    delegate：设置代理
    //    cancelButtonTitle：取消按钮的标题
    //    destructiveButtonTitle：特殊标记的按钮的标题，红色文字显示
    //    otherButtonTitles：其他按钮的标题
    //    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"title" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"特殊标记的按钮" otherButtonTitles:@"测试1",@"测试2", nil];
    //    [sheet showInView:self.view block:^(NSInteger idx)
    //    {
    //        NSLog(@"%ld",idx);
    //    }];
    
    
    [LBXAlertAction showActionSheetWithTitle:@"标题" message:@"ios8系统之后才会显示本消息内容" chooseBlock:^(NSInteger idx)
     {
         //取消为0，destructiveButtonTitle从1开始，如果输入为nil，则otherButtonTitle从1开始，否则从2开始
         NSLog(@"%ld",idx);
     }cancelButtonTitle:@"取消" destructiveButtonTitle:@"destruct" otherButtonTitle:@"items1",@"items2",@"items3",nil];
    
    
}





@end
