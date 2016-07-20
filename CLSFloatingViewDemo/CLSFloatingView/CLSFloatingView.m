//
//  CLSFloatingView.m
//  CLSFloatingViewDemo
//
//  Created by wlei on 16/7/20.
//  Copyright © 2016年 cloverstudio. All rights reserved.
//

#import "CLSFloatingView.h"

#define FloatingViewHUDWindowHeight 64
#define FloatingViewHUDAnimationDuration 0.5
#define FloatingViewHUDTimerInterval 2.0
#define FloatingViewHUDScreenWidth [UIScreen mainScreen].bounds.size.width
#define FloatingViewHUDDefBgColor [UIColor colorWithRed:79/255.0 green:190/255.0 blue:251/255.0 alpha:1]
#define FloatingViewHUDLabelMarginLeft 10
#define FloatingViewHUDLabelMarginTop 20
#define FloatingViewHUDLabelHeight 44
#define FloatingViewHUDLabelTextSize 15.0

@implementation CLSFloatingView

static UIWindow *window_;
static NSTimer *timer_;
static FloatingViewClickBlock clickBlock_;
static FloatingViewUnClickBlock unClickBlock_;

/**
 *  显示消息
 *
 *  @param msg 消息内容
 */
+(void)show:(NSString *)msg{
    [self show:msg action:nil target:nil hudColor:FloatingViewHUDDefBgColor];
}

/**
 *  显示消息
 *
 *  @param msg   消息内容
 *  @param color hud的背景颜色
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color{
    [self show:msg action:nil target:nil hudColor:color];
}

/**
 *  显示消息
 *
 *  @param msg
 */
+(void)show:(NSString *)msg action:(SEL) action target:(id)target{
    
    [self show:msg action:action target:target hudColor:FloatingViewHUDDefBgColor];
    
}

/**
 *  显示消息
 *
 *  @param msg    消息内容
 *  @param action 点击消息后的操作
 *  @param target 点击操作所属的对象
 *  @param color  hud的背景颜色
 */
+(void)show:(NSString *)msg action:(SEL) action target:(id)target hudColor:(UIColor *)color{
    //设置window
    [self setupWindow:color];
    //设置标签
    [self setupLabel:msg];
    //设置按钮
    [self setupButton:action target:target];
}

/**
 *  显示消息
 *
 *  @param msg
 *  @param color
 *  @param clickBlock
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color clickBlock:(FloatingViewClickBlock)clickBlock{
    //设置window
    [self setupWindow:color];
    //设置标签
    [self setupLabel:msg];
    //设置按钮
    [self setupButtonUseBlock:clickBlock unClickBlock:nil];
    
}

/**
 *  显示消息
 *
 *  @param msg          消息内容
 *  @param color        消息视图的的背景颜色
 *  @param clickBlock   点击操作的代码块
 *  @param unClickBlock 当视图消失后，未进行点击的代码块
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color clickBlock:(FloatingViewClickBlock)clickBlock unClickBlock:(FloatingViewUnClickBlock)unClickBlock{
    //设置window
    [self setupWindow:color];
    //设置标签
    [self setupLabel:msg];
    //设置按钮
    [self setupButtonUseBlock:clickBlock unClickBlock:unClickBlock];
}

/**
 *  显示消息
 *
 *  @param msg        消息内容
 *  @param clickBlock 点击操作的代码块
 */
+(void)show:(NSString *)msg clickBlock:(FloatingViewClickBlock)clickBlock{
    //设置window
    [self setupWindow:FloatingViewHUDDefBgColor];
    //设置标签
    [self setupLabel:msg];
    //设置按钮
    [self setupButtonUseBlock:clickBlock unClickBlock:nil];
}



/**
 *  取消显示
 */
+(void)dismiss{
    
    [UIView animateWithDuration:FloatingViewHUDAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = -FloatingViewHUDWindowHeight;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        if (unClickBlock_) {
            NSString *msg = [self getFloatViewMsg];
            unClickBlock_(msg);
        }
        window_ = nil;
    }];
}

#pragma mark -私有方法
/**
 *  设置window
 */
+(void)setupWindow:(UIColor *)color{
    
    //关闭定时器
    [timer_ invalidate];
    
    CGFloat windowStartY = -FloatingViewHUDWindowHeight;
    
    CGRect frame = CGRectMake(0, windowStartY, [UIScreen mainScreen].bounds.size.width,FloatingViewHUDWindowHeight);
    
    //先隐藏之前的window
    window_.hidden = YES;
    //重新设置window
    window_ = [[UIWindow alloc] init];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelNormal;
    window_.backgroundColor = color;
    window_.hidden = NO;
    
    //给window设置一个动画
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,FloatingViewHUDWindowHeight);
    [UIView animateWithDuration:FloatingViewHUDAnimationDuration animations:^{
        window_.frame = frame;
    }];
    
    //启动定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:FloatingViewHUDTimerInterval target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    
}

/**
 *  设置待显示的标签
 *
 *  @param msg
 */
+(void)setupLabel:(NSString *)msg{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(FloatingViewHUDLabelMarginLeft, FloatingViewHUDLabelMarginTop, FloatingViewHUDScreenWidth-2*FloatingViewHUDLabelMarginLeft, FloatingViewHUDLabelHeight)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:FloatingViewHUDLabelTextSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = msg;
    [window_ addSubview:label];
}

/**
 *  设置按钮
 *
 *  @param action 点击操作
 */
+(void)setupButton:(SEL)action target:(id)target{
    UIButton *button =[[UIButton alloc] init];
    button.frame = window_.bounds;
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    if (action && target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [window_ addSubview:button];
}

/**
 *  设置点击事件
 *
 *  @param clickBlock 处理点击事件的block
 */
+(void)setupButtonUseBlock:(FloatingViewClickBlock)clickBlock unClickBlock:(FloatingViewUnClickBlock)unClickBlock{
    clickBlock_ = clickBlock;
    unClickBlock_ = unClickBlock;
    UIButton *button =[[UIButton alloc] init];
    button.frame = window_.bounds;
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [window_ addSubview:button];
}

+(void)buttonOnClick:(UIButton *)button{
    if (clickBlock_) {
        unClickBlock_ = nil;
        NSString *msg = [self getFloatViewMsg];
        clickBlock_(msg);
        [self dismiss];
    }
}

+(NSString *)getFloatViewMsg{
    NSString *msg = @"";
    for (UIView *eachView in window_.subviews) {
        if ([eachView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)eachView;
            msg = label.text;
            break;
        }
    }
    return msg;

}


@end
