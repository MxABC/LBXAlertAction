//
//  LBXAlertAction.m
//
//
//  Created by lbxia on 15/10/27.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXAlertAction.h"
#import <UIKit/UIKit.h>
#import "UIAlertView+LBXAlertAction.h"
#import "UIActionSheet+LBXAlertAction.h"
#import "UIWindow+LBXHierarchy.h"

@implementation LBXAlertAction


+ (BOOL)isIosVersion8AndAfter
{  
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ;
}

+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)message buttonsStatement:(NSArray<NSString*>*)arrayItems chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithArray:arrayItems];
 
    
    if ( [LBXAlertAction isIosVersion8AndAfter])
    {
        //UIAlertController style
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        [[LBXAlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    //UIAlertView style
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:argsArray[0] otherButtonTitles:nil, nil];
    
    [argsArray removeObject:argsArray[0]];
    for (NSString *buttonTitle in argsArray) {
        
        NSLog(@"buttonTitle:%@",buttonTitle);
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    [alertView showWithBlock:^(NSInteger buttonIdx)
     {
         
         block(buttonIdx);
     }];
}


+ (UIViewController*)getTopViewController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    return window.currentViewController;
}



+ (void)showActionSheetWithTitle:(NSString*)title
                         message:(NSString*)message
               cancelButtonTitle:(NSString*)cancelString
          destructiveButtonTitle:(NSString*)destructiveButtonTitle
                otherButtonTitle:(NSArray<NSString*>*)otherButtonArray
                     chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
  
    [argsArray addObjectsFromArray:otherButtonArray];
        
    if ( [LBXAlertAction isIosVersion8AndAfter])
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            
            if (1==i && destructiveButtonTitle) {
                
                style = UIAlertActionStyleDestructive;
            }
            
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        [[LBXAlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //UIActionSheet
    UIView *view = [self getTopViewController].view;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    
    
    if (cancelString) {
        [argsArray removeObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray removeObject:destructiveButtonTitle];
    }
    
    for (NSString* title in argsArray)
    {
        [sheet addButtonWithTitle:title];
    }
    
    __block BOOL isDestructiveExist = destructiveButtonTitle ? YES:NO;
    
    [sheet showInView:view block:^(NSInteger buttonIdx,NSString* buttonTitle)
     {
         NSInteger idx = buttonIdx;
         
         if (isDestructiveExist ) {
             
             switch (idx) {
                 case 0:
                     idx = 1;
                     break;
                 case 1:
                     idx = 0;
                     break;
                     
                 default:
                     break;
             }
         }
         
         if (block) {
             block(idx);
         }
     }];
    
    
}



@end
