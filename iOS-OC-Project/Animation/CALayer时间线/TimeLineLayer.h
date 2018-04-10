//
//  TimeLineLayer.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/30.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface TimeLineLayer : CALayer

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CATextLayer *airplaneLayer;


@property (nonatomic, assign) CFTimeInterval animationBeginTime;

@property (nonatomic, assign) CFTimeInterval animationTimeOffset;

@property (nonatomic, assign) double animationSpeed;

- (void)addAndRemoveAnimation;

- (void)startAndStopAnimation;

@end
