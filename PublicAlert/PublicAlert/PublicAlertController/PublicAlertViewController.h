//
//  PublicAlertViewController.h
//  ylx
//
//  Created by 明镜止水 on 17/3/23.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import <UIKit/UIKit.h>


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
