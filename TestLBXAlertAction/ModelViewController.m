//
//  ModelViewController.m
//  TestLBXAlertAction
//
//  Created by lbxia on 16/8/4.
//  Copyright © 2016年 csce. All rights reserved.
//

#import "ModelViewController.h"
#import "LBXAlertAction.h"

@interface ModelViewController ()

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)alertaction:(id)sender {
    
    [self btnSheet:nil];
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"ModelViewController dealloc");
}

- (void)dosomething
{
    
}
- (void)btnAlert:(id)sender {
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"标题"
                                   msg:@"提示消息内容"
                      buttonsStatement:@[@"取消",@"确认1",@"确认2",@"确认3",@"确认4",@"确认5",@"确认6"]
                           chooseBlock:^(NSInteger buttonIdx) {
                               
                               NSArray* array = @[@"取消",@"确认1",@"确认2",@"确认3",@"确认4",@"确认5",@"确认6"];
                               
                               //按钮按顺序输出
                               NSLog(@"u choose:%@",array[buttonIdx]);
                               
                               [weakSelf dosomething];
                           }];
    
}
- (void)btnSheet:(id)sender {
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showActionSheetWithTitle:@"标题"
                                     message:@"ios8系统之后才会显示本消息内容"
                           cancelButtonTitle:@"取消"
                      destructiveButtonTitle:@"destruct"
                            otherButtonTitle:@[@"items1",@"items2",@"items3"]
                                 chooseBlock:^(NSInteger buttonIdx) {
                                     
                                     //取消为0，destructiveButtonTitle从1开始，如果输入为nil，则otherButtonTitle从1开始，否则从2开始
                                     NSLog(@"%ld",buttonIdx);
                                     [weakSelf dosomething];
                                 }];
}




@end
