//
//  TimeLineLayer.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/30.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TimeLineLayer.h"


@interface TimeLineLayer () <CAAnimationDelegate>

@end


@implementation TimeLineLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animationTimeOffset = 0;
        _animationBeginTime = 0;
        _animationSpeed = 1;
        
//        CAMediaTiming
        
        [self addSublayer:self.shapeLayer];
        [self addSublayer:self.airplaneLayer];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    if (!CGRectEqualToRect(_shapeLayer.frame, self.bounds)) {
        _shapeLayer.frame = self.bounds;
        _shapeLayer.path = [self trackPathWithRect:_shapeLayer.bounds].CGPath;
        _airplaneLayer.position = CGPointMake(25, (self.bounds.size.height - _shapeLayer.lineWidth) * 0.5);
    }
}

- (void)addAndRemoveAnimation {
    if ([self.airplaneLayer animationForKey:@"airplaneLayer"]) {
        [self.airplaneLayer removeAnimationForKey:@"airplaneLayer"];
        self.airplaneLayer.beginTime = 0;
        self.airplaneLayer.timeOffset = 0;
        return;
    }
    
//    CFTimeInterval addAnimationTime = CACurrentMediaTime();
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.timeOffset =  CACurrentMediaTime() + 2; //修改的代码
    animation.path = self.shapeLayer.path;
    animation.duration = 3;
    animation.delegate = self;
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.airplaneLayer addAnimation:animation forKey:@"airplaneLayer"];
    NSLog(@"addAnimation");
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
}


//这部分有点难理解，但可以分别测试下
//beginTime = CACurrentMediaTime() - timeOffset 和 timeOffset 的效果
//即timeOffset = 2 和 beginTime = CACurrentMediaTime() - 2
- (void)startAndStopAnimation {
    if (_airplaneLayer.speed) {
        CFTimeInterval pausedTime = [_airplaneLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        //动画暂停
        _airplaneLayer.speed = 0.0;
        //如果_airplaneLayer.timeOffset=0，飞机会瞬间回到原点，这样设置后，飞机保留在暂停位置
        _airplaneLayer.timeOffset = pausedTime;
        NSLog(@"pausedTime:%.2lf", _airplaneLayer.timeOffset);
    } else {
        CFTimeInterval pausedTime = _airplaneLayer.timeOffset;
        _airplaneLayer.beginTime = 0.0;
        //动画重启
        _airplaneLayer.speed = 1.0;
        _airplaneLayer.timeOffset = 0.0;
        
        CFTimeInterval localTime = [_airplaneLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        //localTime - pausedTime代表的是暂停到重启的时间间隔
        _airplaneLayer.beginTime = localTime - pausedTime;
        NSLog(@"timeSincePause:%.2lf", _airplaneLayer.beginTime);
    }
}

#pragma - mark lazy load

- (CATextLayer *)airplaneLayer {
    if (!_airplaneLayer) {
        _airplaneLayer = [CATextLayer layer];
        _airplaneLayer.string = @"✈️";
        _airplaneLayer.frame = CGRectMake(0, 0, 33, 33);
        _airplaneLayer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI*0.25, 0, 0, 1);
     
        UIFont *font = [UIFont systemFontOfSize:30];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _airplaneLayer.font = fontRef;
        _airplaneLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
    }
    return _airplaneLayer;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 2;
    }
    return _shapeLayer;
}

- (UIBezierPath *)trackPathWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint start = CGPointMake(25, rect.size.height * 0.5);
    CGPoint end = CGPointMake(rect.size.width-25, (rect.size.height - 50) * 0.5);
    [path moveToPoint:start];
    [path addCurveToPoint:end
            controlPoint1:CGPointMake(start.x + 100, start.y - 100)
            controlPoint2:CGPointMake(end.x - 100, end.y + 100)];
    return path;
}

@end
