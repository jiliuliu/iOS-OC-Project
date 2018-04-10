//
//  HomeModel.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "HomeModel.h"


NSString * const HMSectionTitles = @"sectionTitles";
NSString * const HMTitle = @"title";
NSString * const HMDetail = @"detail";
NSString * const HMVCName = @"vcName";

@implementation HomeModel

+ (NSDictionary *)animations {
    return @{HMSectionTitles: @[@"经典动画", @"CALayer基础"],
             @"经典动画": @[@"VCARScan", @"WaveVC"],
             @"CALayer基础": @[@"VCLayerTimeLine"],
             @"": @[@""],
             };
}

+ (NSDictionary *)scenes {
    return @{HMSectionTitles: @[@"经典动画"],
             @"经典动画": @[@"VCARScan", @"", @""],
             @"": @[@""],
             @"": @[@""],
             };
}

+ (NSDictionary *)tests {
    return @{HMSectionTitles: @[@"经典动画"],
             @"经典动画": @[@"VCARScan", @"", @""],
             @"": @[@""],
             @"": @[@""],
             };
}

@end



