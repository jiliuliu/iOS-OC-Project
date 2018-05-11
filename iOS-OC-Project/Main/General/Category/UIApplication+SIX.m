//
//  UIApplication+SIX.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "UIApplication+SIX.h"

@implementation UIApplication (SIX)

+ (UIWindow *)window {
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIViewController *)rootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

@end
