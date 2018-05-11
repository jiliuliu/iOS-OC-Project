//
//  HomeModel.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString * const HMSectionTitles;
UIKIT_EXTERN NSString * const HMTitle;
UIKIT_EXTERN NSString * const HMDetail;
UIKIT_EXTERN NSString * const HMVCName;

@interface HomeModel : NSObject

+ (NSDictionary *)animations;
+ (NSDictionary *)scenes;
+ (NSDictionary *)tests;
+ (NSDictionary *)optimizations;
@end


