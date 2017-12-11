//
//  ViewController.m
//  PublicAlert
//
//  Created by 明镜止水 on 2017/12/11.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"一个按钮的弹框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 sizeToFit];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"两个按钮的弹框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 sizeToFit];
    
    UIButton *btn3 = [UIButton new];
    [btn3 setTitle:@"三个按钮的弹框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 sizeToFit];
    
    UIButton *btn4 = [UIButton new];
    [btn4 setTitle:@"三个按钮的弹框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 sizeToFit];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
