//
//  ShowProtocol.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString * const HMSectionTitles;
UIKIT_EXTERN NSString * const HMTitle;
UIKIT_EXTERN NSString * const HMDetail;
UIKIT_EXTERN NSString * const HMVCName;

@protocol ShowProtocol <NSObject>

+ (NSDictionary *)info;

@end
