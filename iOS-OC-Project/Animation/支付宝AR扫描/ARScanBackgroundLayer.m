//
//  ARScanLayer.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/23.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "ARScanBackgroundLayer.h"

@interface ARScanBackgroundLayer ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *movingCircleLayer;

@end

@implementation ARScanBackgroundLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        _numberOfPolygon = 6;
        _inCenter = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5);
        _inRadius = 150;
        _spaceBetweenCircles = 20;
        
        [self resetDraw];
    }
    return self;
}

- (void)resetDraw {
    if (self.sublayers.count) {
        for (CALayer *layer in self.sublayers) {
            [layer removeFromSuperlayer];
        }
    }
    
    [self addSublayer:self.maskLayer];
    [self addSublayer:self.movingCircleLayer];
    [self addAnimationToLayer:self.movingCircleLayer];
    [self setNeedsDisplay];
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = self.bounds;
        _maskLayer.shouldRasterize = YES;
        
        CGPoint points[_numberOfPolygon];
        [self polygonPoints:points count:_numberOfPolygon radius:_inRadius andCenter:_inCenter];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        [path setLineWidth:4];
        [path moveToPoint:points[0]];
        for (NSInteger i=1; i<_numberOfPolygon; i++) {
            [path addLineToPoint:points[i]];
        }
        [path closePath];
        
        _maskLayer.strokeColor = [UIColor whiteColor].CGColor;
        _maskLayer.fillColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
        _maskLayer.path = path.CGPath;
    }
    return _maskLayer;
}

- (CAShapeLayer *)movingCircleLayer {
    if (!_movingCircleLayer) {
        _movingCircleLayer = [CAShapeLayer layer];
        _movingCircleLayer.frame = self.bounds;
        
        CGPoint points[_numberOfPolygon];
        [self polygonPoints:points count:_numberOfPolygon radius:_inRadius + _spaceBetweenCircles andCenter:_inCenter];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path setLineWidth:4];
        [path moveToPoint:points[0]];
        for (NSInteger i=1; i<_numberOfPolygon; i++) {
            [path addLineToPoint:points[i]];
        }
        [path closePath];
        
        _movingCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _movingCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _movingCircleLayer.path = path.CGPath;
    }
    return _movingCircleLayer;
}

- (void)addAnimationToLayer:(CAShapeLayer *)shapeLayer {
    CGFloat MAX = 0.98f;
    CGFloat GAP = 0.2;
    
    CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
    aniStart.toValue           = [NSNumber numberWithFloat:MAX];
    aniStart.duration          = 2.f;
    
    CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
    aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
    aniEnd.duration            = 2.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration          = 2.f;
    group.animations        = @[aniEnd, aniStart];
    
    group.repeatCount = NSIntegerMax;
    shapeLayer.strokeStart   = MAX;
    shapeLayer.strokeEnd     = MAX + GAP;
    [shapeLayer addAnimation:group forKey:nil];
}

- (CGRect)polygonBounds {
    return CGPathGetBoundingBox(self.maskLayer.path);
}

- (void)polygonPoints:(CGPoint [])points count:(NSInteger)count radius:(CGFloat)radius andCenter:(CGPoint)center {
    CGFloat degree;
    CGFloat k = M_PI / 180;

    for (int i=0; i<count; i++) {
        degree = (i - 0.5) * 360.0 / count * k;
        points[i] = CGPointMake(radius * cos(degree) + center.x, radius * sin(degree) + center.y);
    }
}



@end
