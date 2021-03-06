//
//  CLSFloatingView.h
//  CLSFloatingViewDemo
//
//  Created by wlei on 16/7/20.
//  Copyright © 2016年 cloverstudio. All rights reserved.
//  1.0.0

#import <UIKit/UIKit.h>

@interface CLSFloatingView : NSObject

/** floatview被点击后的代码块 */
typedef  void (^FloatingViewClickBlock)(NSString *msg);
/** floatview消失且未点击的代码块 */
typedef  void (^FloatingViewUnClickBlock)(NSString *msg);

/**
 *  显示消息
 *
 *  @param msg 消息内容
 */
+(void)show:(NSString *)msg;

/**
 *  显示消息
 *
 *  @param msg   消息内容
 *  @param color 消息视图的的背景颜色
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color;

/**
 *  显示消息
 *
 *  @param msg    消息内容
 *  @param action 点击消息后的操作
 *  @param target 点击操作所属的对象
 */
+(void)show:(NSString *)msg action:(SEL) action target:(id)target;

/**
 *  显示消息
 *
 *  @param msg    消息内容
 *  @param action 点击消息后的操作
 *  @param target 点击操作所属的对象
 *  @param color  消息视图的的背景颜色
 */
+(void)show:(NSString *)msg action:(SEL) action target:(id)target hudColor:(UIColor *)color;

/**
 *  显示消息
 *
 *  @param msg        消息内容
 *  @param color      消息视图的的背景颜色
 *  @param clickBlock 点击操作的代码块
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color clickBlock:(FloatingViewClickBlock)clickBlock;

/**
 *  显示消息
 *
 *  @param msg        消息内容
 *  @param clickBlock 点击操作的代码块
 */
+(void)show:(NSString *)msg clickBlock:(FloatingViewClickBlock)clickBlock;

/**
 *  显示消息
 *
 *  @param msg          消息内容
 *  @param color        消息视图的的背景颜色
 *  @param clickBlock   点击操作的代码块
 *  @param unClickBlock 当视图消失后，未进行点击的代码块
 */
+(void)show:(NSString *)msg hudColor:(UIColor *)color clickBlock:(FloatingViewClickBlock)clickBlock unClickBlock:(FloatingViewUnClickBlock)unClickBlock;

/**
 *  取消显示
 */
+(void)dismiss;

@end
