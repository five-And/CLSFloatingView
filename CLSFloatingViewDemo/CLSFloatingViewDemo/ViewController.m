//
//  ViewController.m
//  CLSFloatingViewDemo
//
//  Created by wlei on 16/7/20.
//  Copyright © 2016年 cloverstudio. All rights reserved.
//

#import "ViewController.h"
#import "CLSFloatingView.h"

#define defHUDColor [UIColor colorWithRed:3/255.0 green:111/255.0 blue:116/255.0 alpha:1]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showHudStyle1:(id)sender {
    [CLSFloatingView show:@"感谢使用，CLSFloatingView"];
}

- (IBAction)showHudStyle2:(id)sender {
    
    [CLSFloatingView show:@"感谢使用，CLSFloatingView" hudColor: defHUDColor];
}

- (IBAction)showHudStyle3:(id)sender {
    [CLSFloatingView show:@"感谢使用，CLSFloatingView" action:@selector(floatingViewOnClick) target:self];
}

- (IBAction)showHudStyle4:(id)sender {
    [CLSFloatingView show:@"感谢使用，CLSFloatingView" action:@selector(floatingViewOnClick) target:self hudColor:defHUDColor];
}

- (IBAction)dismissHUD:(id)sender {
    [CLSFloatingView dismiss];
}

-(void)floatingViewOnClick{
    NSLog(@"CLSFloatingView 被点击了");
    [CLSFloatingView dismiss];
}


@end
