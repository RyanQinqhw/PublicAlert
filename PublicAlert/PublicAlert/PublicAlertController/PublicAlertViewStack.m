//
//  PublicAlertViewStack.m
//  ylx
//
//  Created by 明镜止水 on 17/3/23.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import "PublicAlertViewStack.h"


@implementation PublicAlertViewStack

+(PublicAlertViewStack *)shareInstance{
    static PublicAlertViewStack *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.alertViews = [NSMutableArray array];
    });
    return instance;
}
+(void)push:(PublicAlertViewController *)alertView{
    [[self shareInstance].alertViews addObject:alertView];
    [alertView showInternal];
    for (PublicAlertViewController *pView in [self shareInstance].alertViews) {
        if (pView != alertView) {
            [pView hide];
        }
    }
}
+(void)pop:(PublicAlertViewController *)alertView{
    [[self shareInstance].alertViews removeObject:alertView];
    PublicAlertViewController *last = [[self shareInstance].alertViews lastObject];
    if (last) {
        [last showInternal];
    }

}
@end
