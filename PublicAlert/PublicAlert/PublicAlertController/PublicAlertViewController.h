//
//  PublicAlertViewController.h
//  ylx
//
//  Created by 明镜止水 on 17/3/23.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MainTabBarColor [UIColor colorWithRed:(0x10 / 255.0) green:(0xb4 / 255.0) blue:(0x87 / 255.0) alpha:1.0]

typedef void(^PublicAlertViewCompletionBlock)(NSInteger buttonIndex);

@interface PublicAlertViewController : UIViewController

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(PublicAlertViewCompletionBlock)completion;
-(void)hide;
-(void)showInternal;

@end
