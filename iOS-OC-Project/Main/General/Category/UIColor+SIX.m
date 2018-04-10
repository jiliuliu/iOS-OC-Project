//
//  UIColor+SIX.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "UIColor+SIX.h"

@implementation UIColor (SIX)

+ (instancetype)six_random {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0
                           green:arc4random_uniform(256)/255.0
                            blue:arc4random_uniform(256)/255.0 alpha:1.0];
}

+ (instancetype)six_colorWithR:(CGFloat)r b:(CGFloat)b g:(CGFloat)g {
    return [UIColor colorWithRed:r/255.0
                           green:b/255.0
                            blue:g/255.0 alpha:1.0];
}

+ (UIColor*)six_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)six_colorWithHex:(NSInteger)hexValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:1];
}

@end
