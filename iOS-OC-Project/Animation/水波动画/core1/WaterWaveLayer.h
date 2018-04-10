//
//  WaterWaveLayer.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/8.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WaterWaveLayer : CAReplicatorLayer

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, strong) UIColor *waveColor;

@end
