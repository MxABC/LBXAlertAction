//
//  UIAlertController+LBXAlertAction.m
//  LBXAlertAction
//
//  Created by lbxia on 2018/8/8.
//

#import "UIAlertController+LBXAlertAction.h"

@implementation UIAlertController (LBXAlertAction)

//是否允许转屏
- (BOOL)shouldAutorotate {
    
    if (!self.presentingViewController) {
        return NO;
    }
    return [self.presentingViewController shouldAutorotate];
}
//viewController所支持的全部旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (!self.presentingViewController) {
        return  self.supportedInterfaceOrientations;
    }
    return  [self.presentingViewController supportedInterfaceOrientations];
}
//viewController初始显示的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if (!self.presentingViewController) {
        return  self.preferredInterfaceOrientationForPresentation;
    }
    
    return  [self.presentingViewController preferredInterfaceOrientationForPresentation];
}

@end
