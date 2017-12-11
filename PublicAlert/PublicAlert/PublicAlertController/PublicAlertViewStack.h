//
//  PublicAlertViewStack.h
//  ylx
//
//  Created by 明镜止水 on 17/3/23.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicAlertViewController.h"
@interface PublicAlertViewStack : NSObject

+(PublicAlertViewStack *)shareInstance;
@property (nonatomic, strong) NSMutableArray *alertViews;
+(void)push:(PublicAlertViewController *)alertView;
+(void)pop:(PublicAlertViewController *)alertView;
@end
