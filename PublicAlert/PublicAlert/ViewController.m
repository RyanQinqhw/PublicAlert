//
//  ViewController.m
//  PublicAlert
//
//  Created by 明镜止水 on 2017/12/11.
//  Copyright © 2017年 明镜止水. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "PublicAlertViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"一个按钮的弹框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    btn1.tag = 1;
    [btn1 sizeToFit];
    btn1.y = 40;
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"两个按钮的弹框" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor grayColor];
    btn2.tag = 2;
    [btn2 sizeToFit];
    btn2.y = CGRectGetMaxY(btn1.frame) + 10;
    
    UIButton *btn3 = [UIButton new];
    [btn3 setTitle:@"三个按钮的弹框" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor grayColor];
    btn3.tag = 3;
    [btn3 sizeToFit];
    btn3.y = CGRectGetMaxY(btn2.frame) + 10;
    
    UIButton *btn4 = [UIButton new];
    [btn4 setTitle:@"四个按钮的弹框" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor grayColor];
    btn4.tag = 4;
    [btn4 sizeToFit];
    btn4.y = CGRectGetMaxY(btn3.frame) + 10;
    
    
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
}

-(void)clickBtn:(UIButton *)btn{
    if (btn.tag == 1) {
        [PublicAlertViewController showAlertWithTitle:@"温馨提示" message:@"一个按钮" cancelTitle:nil otherTitles:@[@"确定"] contentView:nil completion:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSLog(@"按钮一");
            }
            
        }];
    }else if (btn.tag == 2){
        [PublicAlertViewController showAlertWithTitle:@"温馨提示" message:@"两个个按钮" cancelTitle:nil otherTitles:@[@"确定",@"取消"] contentView:nil completion:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSLog(@"点击确定按钮");
            }else if (buttonIndex == 1){
                NSLog(@"点击取消按钮");
            }
        }];
        
    }else if (btn.tag == 3){
        
        [PublicAlertViewController showAlertWithTitle:@"温馨提示" message:@"三个个按钮" cancelTitle:nil otherTitles:@[@"按钮一",@"按钮二",@"按钮三"] contentView:nil completion:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSLog(@"点击按钮one");
            }else if (buttonIndex == 1){
                NSLog(@"点击按钮two");
            }else if (buttonIndex == 2){
                NSLog(@"点击按钮three");
            }
        }];
        
    }else if (btn.tag == 4){
        [PublicAlertViewController showAlertWithTitle:@"温馨提示" message:@"四个个按钮" cancelTitle:nil otherTitles:@[@"按钮一",@"按钮二",@"按钮三",@"按钮四"] contentView:nil completion:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSLog(@"点击按钮one");
            }else if (buttonIndex == 1){
                NSLog(@"点击按钮two");
            }else if (buttonIndex == 2){
                NSLog(@"点击按钮three");
            }else if (buttonIndex == 3){
                NSLog(@"点击按钮four");
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
