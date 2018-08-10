//
//  ViewController.m
//  TestLBXAlertAction
//
//  Created by lbxia on 15/11/12.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ViewController.h"
#import "LBXAlertAction.h"
#import "ModelViewController.h"

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
- (void)dosomething
{
    
}
- (IBAction)btnAlert:(id)sender {
    
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
- (IBAction)btnSheet:(id)sender {
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showActionSheetWithTitle:@"标题"
                                     message:@"ios8系统之后才会显示本消息内容"
                           cancelButtonTitle:@"取消"
                      destructiveButtonTitle:@"destructive"
                            otherButtonTitle:@[@"items1",@"items2",@"items3"]
                                 chooseBlock:^(NSInteger buttonIdx) {
                                     
                                     //取消为0，destructiveButtonTitle从1开始，如果输入为nil，则otherButtonTitle从1开始，否则从2开始
                                     NSLog(@"%ld",buttonIdx);
                                     [weakSelf dosomething];
                                 }];    
}

- (IBAction)modelVC:(id)sender {
    
    ModelViewController *vc = [[ModelViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskPortrait;
}


@end
