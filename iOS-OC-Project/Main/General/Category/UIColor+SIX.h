//
//  UIColor+SIX.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SIX)

+ (instancetype)six_random;

+ (instancetype)six_colorWithR:(CGFloat)r b:(CGFloat)b g:(CGFloat)g;
+ (UIColor*)six_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)six_colorWithHex:(NSInteger)hexValue;

@end
