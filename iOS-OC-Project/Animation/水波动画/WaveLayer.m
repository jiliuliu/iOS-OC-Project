//
//  WaveLayer.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/7.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "WaveLayer.h"

@implementation WaveLayer
{
    CGFloat _currentOffset;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _progress = 0.5;
        _amplitude = 0.1;
        _progress = 0.5;
        _offset = 3 / 60;
        _waveColor = [UIColor blueColor];
        self.fillColor = _waveColor.CGColor;
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    [self addWaveAnimation];
}

- (void)addWaveAnimation {
    static NSString * const AnimationKey = @"wave";
    if ([self animationForKey:AnimationKey]) {
        [self removeAnimationForKey:AnimationKey];
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    animation.duration = 2;
    animation.values = [self calculateWavePaths];
    animation.repeatCount = NSIntegerMax;
    [self addAnimation:animation forKey:AnimationKey];
}

- (NSArray *)calculateWavePaths {
    CGFloat diameter = self.bounds.size.width;
    CGFloat y = 0;
    CGFloat startY = (1-_progress) * diameter;
    CGFloat offset = 10 * (M_PI * 2 / 60);
    
    NSMutableArray *paths = [NSMutableArray array];
    UIBezierPath *path = nil;
    for (int i = 0; i<20; i++) {
        _currentOffset += offset;
        
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, startY)];
        for (int x = 0; x<=diameter; x++) {
            y = _amplitude * diameter * sin(( x / diameter - _currentOffset) * M_PI * 2) + startY;
            [path addLineToPoint:CGPointMake(x, y)];
        }
        [path addLineToPoint:CGPointMake(diameter, diameter)];
        [path addLineToPoint:CGPointMake(0, diameter)];
        [path closePath];
        [paths addObject:(__bridge id)path.CGPath];
    }
    [paths addObject:paths.firstObject];
    return paths.copy;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self addWaveAnimation];
}

- (void)setWaveColor:(UIColor *)waveColor {
    _waveColor = waveColor;
    self.fillColor = _waveColor.CGColor;
}

@end
