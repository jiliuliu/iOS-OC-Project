//
//  UIImage+SIX.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "UIImage+SIX.h"

@implementation UIImage (SIX)

+ (instancetype)six_imageWithColor:(UIColor *)color {
    return [self six_imageWithColor:color andSize:CGSizeMake(1, 1)];
}

+ (instancetype)six_imageWithColor:(UIColor *)color andSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
