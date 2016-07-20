# CLSFloatingView
一个悬浮在屏幕顶端的提示视图，类似网易新闻收到推送消息时的显示效果

##显示文字
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView"];
```

##显示文字，采用自定义背景色
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView" hudColor: [UIColor colorWithRed:3/255.0 green:111/255.0 blue:116/255.0 alpha:1]];
```

##显示文字,支持点击操作
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView" action:@selector(floatingViewOnClick) target:self]
```

##显示文字，支持点击操作，并支持采用自定义背景色
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView" action:@selector(floatingViewOnClick) target:self hudColor:[UIColor colorWithRed:3/255.0 green:111/255.0 blue:116/255.0 alpha:1]];
```

##显示文字，点击后通过代码块回调，并支持采用自定义背景色
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView" hudColor:defHUDColor clickBlock:^(NSString *msg) {
        NSLog(@"FloatingView:%@ 被点击了",msg);
    }];
```

##显示文字，点击后通过代码块回调，但采用默认背景颜色
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView" clickBlock:^(NSString *msg) {
        NSLog(@"FloatingView:%@ 被点击了",msg);
    }];
```

##显示文字，点击后通过代码块回调，当没有点击，且视图自动消失后通过代码块回调
```objc
[CLSFloatingView show:@"感谢使用，CLSFloatingView"
                 hudColor:defHUDColor
               clickBlock:^(NSString *msg) {
                   NSLog(@"FloatingView:%@ 被点击了",msg);
               }
             unClickBlock:^(NSString *msg) {
                 NSLog(@"FloatingView:%@ 消失了",msg);
             }];
```
