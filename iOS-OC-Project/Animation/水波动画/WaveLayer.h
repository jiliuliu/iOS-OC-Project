//
//  WaveLayer.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/7.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WaveLayer : CAShapeLayer

@property (nonatomic, strong) UIColor *waveColor;
//波浪高度
@property (nonatomic, assign) CGFloat progress;
//波峰值 占周长的  百分比
@property (nonatomic, assign) CGFloat amplitude;
//当offset = 1时，一秒钟曲线移动一个周期，可以通过修改它，改变波浪速度
@property (nonatomic, assign) CGFloat offset;

@end
