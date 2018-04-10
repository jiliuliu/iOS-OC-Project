//
//  WaveView.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/7.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaveLayer.h"

@interface WaveView : UIView

@property (nonatomic, strong) WaveLayer *waveLayer;
@property (nonatomic, strong) UIColor *waveColor;
@property (nonatomic, assign) NSString *text;

@end
