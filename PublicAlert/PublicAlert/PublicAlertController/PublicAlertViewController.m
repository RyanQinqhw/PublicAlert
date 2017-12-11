//
//  PublicAlertViewController.m
//  ylx
//
//  Created by 明镜止水 on 17/3/23.
//  Copyright © 2017年 明镜止水. All rights reserved.
//




#import "PublicAlertViewController.h"
#import "PublicAlertViewStack.h"
//@class PublicAlertViewStack;

@interface PublicAlertViewController ()

/**
 主window
 */
@property (nonatomic, strong) UIWindow *mainWindow;

/**
 提醒过window
 */
@property (nonatomic, strong) UIWindow *alertWindow;

/**
 背景view
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 提示框view
 */
@property (nonatomic, strong) UIView *alertView;

/**
 title
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 message
 */
@property (nonatomic, strong) UILabel *messageLabel;

/**
 保存 按钮的Y
 */
@property (nonatomic, assign) CGFloat buttonsY;

/**
 保存创建的按钮
 */
@property (nonatomic, strong) NSArray *buttons;

/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancelButton;

/**
 两个按钮中间的垂直线
 */
@property (nonatomic, strong) CALayer *verticalLine;

/**
 存储临时按钮
 */
@property (nonatomic, strong) UIButton *otherButton;

/**
 点击按钮回调
 */
@property (nonatomic, copy) void (^completion)(NSInteger buttonIndex);
@property (nonatomic, getter = isVisible) BOOL visible;
@end

static const CGFloat MutiAlertViewWidth = 270.0;
static const CGFloat MutiAlertViewContentMargin = 9;
static const CGFloat MutiAlertViewVerticalElementSpace = 10;
static const CGFloat MutiAlertViewButtonHeight = 44;
static const CGFloat MutiAlertViewLineLayerWidth = 0.5;

@implementation PublicAlertViewController

-(UIWindow *)windowWidthLevel:(UIWindowLevel)windowLevel{
    NSArray *windowArr = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windowArr) {
        if (window.windowLevel == windowLevel) {
            return window;
        }
    }
    return nil;
}


+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(PublicAlertViewCompletionBlock)completion{
    
    PublicAlertViewController *alertView = [[self alloc] initWithTitle:title message:message cancelTitle:cancelTitle otherTitles:otherTitles contentView:view completion:completion];
    [alertView show];
    return alertView;
}


/**
 通过下面信息,创建按钮回调, 模仿系统UIAlertController

 @param title 名称
 @param message 描述信息
 @param cancelTitle 取消title
 @param otherTitles 其他按钮
 @param contentView 其他内容view
 @param completion 完成回调
 @return 返回实体
 */
- (instancetype)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        otherTitles:(NSArray *)otherTitles
        contentView:(UIView *)contentView
         completion:(PublicAlertViewCompletionBlock)completion{
    self = [super init];
    if (self) {
        
        _mainWindow = [self windowWidthLevel:UIWindowLevelNormal];
        //创建alertwindow
        _alertWindow = [self windowWidthLevel:UIWindowLevelAlert];
        if(!_alertWindow){
            _alertWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            _alertWindow.windowLevel = UIWindowLevelAlert;
            _alertWindow.backgroundColor = [UIColor clearColor];
        }
        _alertWindow.rootViewController = self;
        
        //当前view 和 屏幕一样大
        self.view.frame = [UIScreen mainScreen].bounds;
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self.view addSubview:_backgroundView];
        
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8.0;
        _alertView.layer.opacity = 0.95;
        _alertView.clipsToBounds = YES;
        [self.view addSubview:_alertView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MutiAlertViewContentMargin, MutiAlertViewVerticalElementSpace, MutiAlertViewWidth - MutiAlertViewContentMargin *2, MutiAlertViewButtonHeight)];
        _titleLabel.text = title;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame = [self adjustLableFrame:self.titleLabel];
        [_alertView addSubview:_titleLabel];
        
        CGFloat messageLabelY = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + MutiAlertViewVerticalElementSpace;
        
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(MutiAlertViewContentMargin, messageLabelY, MutiAlertViewWidth - MutiAlertViewContentMargin *2, MutiAlertViewButtonHeight)];
        _messageLabel.text = message;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:17];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.numberOfLines = 0;
        _messageLabel.frame = [self adjustLableFrame:self.messageLabel];
        [_alertView addSubview:_messageLabel];
        
        CALayer *lineLayer = [self lineLayer];
        lineLayer.frame = CGRectMake(0, _messageLabel.frame.origin.y + _messageLabel.frame.size.height + MutiAlertViewVerticalElementSpace, MutiAlertViewWidth, MutiAlertViewLineLayerWidth);
        [_alertView.layer addSublayer:lineLayer];
        
        _buttonsY = lineLayer.frame.origin.y + lineLayer.frame.size.height;
        
        if (cancelTitle) {
            [self addButtonWithTitle:cancelTitle];
        }else{
            
        }
        //添加按钮
        if (otherTitles && [otherTitles count] > 0) {
            for (NSString *title in otherTitles) {
                [self addButtonWithTitle:title];
            }
        }
        
        _alertView.bounds = CGRectMake(0, 0, MutiAlertViewWidth, 150);
        if (completion) {
            _completion = completion;
        }
        [self resizeViews];
        
        _alertView.center = self.view.center;
        
    }
    return self;
}


//计算label 的frame 和 实际高度

/**
 返回label 的frame

 @param label 传入label
 @return 返回frame
 */
-(CGRect)adjustLableFrame:(UILabel *)label{
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 1.0;
    CGSize textSize = CGSizeMake(label.frame.size.width, FLT_MAX);
    CGRect labelFrame = [label.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:context];
    return CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, labelFrame.size.height);
}

-(CALayer *)lineLayer{
    CALayer *linerLyer = [CALayer layer];
    linerLyer.backgroundColor = [[UIColor colorWithWhite:0.90 alpha:0.7] CGColor];
    return linerLyer;
}


/**
 通过字符串,创建按钮

 @param title 按钮名称
 @return 放回多少个按钮
 */
-(NSInteger)addButtonWithTitle:(NSString *)title{
    UIButton *button = [self genericButton];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    if (!self.cancelButton) {
        self.cancelButton = button;
        self.cancelButton.frame = CGRectMake(0, self.buttonsY, MutiAlertViewWidth, MutiAlertViewButtonHeight);
    } else if (self.buttons && [self.buttons count] > 1) {
        UIButton *lastButton = (UIButton *)[self.buttons lastObject];
//        lastButton.titleLabel.font = [UIFont systemFontOfSize:17];
        if ([self.buttons count] == 2) {
            [self.verticalLine removeFromSuperlayer];
            CALayer *lineLayer = [self lineLayer];
            lineLayer.frame = CGRectMake(0, self.buttonsY + MutiAlertViewButtonHeight, MutiAlertViewWidth, MutiAlertViewLineLayerWidth);
            [self.alertView.layer addSublayer:lineLayer];
            lastButton.frame = CGRectMake(0, self.buttonsY + MutiAlertViewButtonHeight, MutiAlertViewWidth, MutiAlertViewButtonHeight);
            self.cancelButton.frame = CGRectMake(0, self.buttonsY, MutiAlertViewWidth, MutiAlertViewButtonHeight);
        }
        CGFloat lastButtonYOffset = lastButton.frame.origin.y + MutiAlertViewButtonHeight;
        button.frame = CGRectMake(0, lastButtonYOffset, MutiAlertViewWidth, MutiAlertViewButtonHeight);
        CALayer *lineLayer = [self lineLayer];
        lineLayer.frame = CGRectMake(0, lastButtonYOffset, MutiAlertViewWidth, MutiAlertViewLineLayerWidth);
        [self.alertView.layer addSublayer:lineLayer];
    } else {
        self.verticalLine = [self lineLayer];
        self.verticalLine.frame = CGRectMake(MutiAlertViewWidth/2, self.buttonsY, MutiAlertViewLineLayerWidth, MutiAlertViewButtonHeight);
        [self.alertView.layer addSublayer:self.verticalLine];
        button.frame = CGRectMake(MutiAlertViewWidth/2, self.buttonsY, MutiAlertViewWidth/2, MutiAlertViewButtonHeight);
        self.otherButton = button;
        self.cancelButton.frame = CGRectMake(0, self.buttonsY, MutiAlertViewWidth/2, MutiAlertViewButtonHeight);
//        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    
    [self.alertView addSubview:button];
    self.buttons = (self.buttons) ? [self.buttons arrayByAddingObject:button] : @[ button ];
    return [self.buttons count] - 1;
}


/**
 创建按钮

 @return 返回按钮
 */
-(UIButton *)genericButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:MainTabBarColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.25 alpha:1] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
    return button;
}


/**
 计算控件内容中的frame, 计算实际高度,给alertView实际高度
 */
-(void)resizeViews{
    CGFloat totalHeight = 0;
    for (UIView *view in [self.alertView subviews]) {
        if ([view class] != [UIButton class]) {
            totalHeight += view.frame.size.height + MutiAlertViewVerticalElementSpace;
        }
    }
    if (self.buttons) {
        totalHeight += MutiAlertViewButtonHeight * (self.buttons.count > 2 ? self.buttons.count : 1);
    }
    totalHeight += MutiAlertViewVerticalElementSpace;
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x, self.alertView.frame.origin.y, self.alertView.frame.size.width, totalHeight);
}


/**
 消除当前的alert 设置mianWindow为主window
 @param sender 目前是按钮
 */
-(void)dismiss:(id)sender{
    [PublicAlertViewStack pop:self];
    self.alertWindow.hidden = YES;
    [self.mainWindow makeKeyAndVisible];
    [self.view removeFromSuperview];
    if (self.completion) {
        NSInteger buttonIndex = -1;
        buttonIndex = [self.buttons indexOfObject:sender];
        if (buttonIndex != NSNotFound) {
            self.completion(buttonIndex);
        }
    }
}


/**
 按钮按下 改变颜色

 @param sender 按钮
 */
-(void)setBackgroundColorForButton:(id)sender{
    [sender setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.6]];
}

/**
 离开按钮
 
 @param sender 按钮
 */
-(void)clearBackgroundColorForButton:(id)sender{
    [sender setBackgroundColor:[UIColor clearColor]];
}



-(void)showInternal{
    self.alertWindow.hidden = NO;
    [self.alertWindow addSubview:self.view];
    [self.alertWindow makeKeyAndVisible];
    self.visible = YES;
}

-(void)show{

    [PublicAlertViewStack push:self];
}
-(void)hide{
    [self.view removeFromSuperview];
}

@end
