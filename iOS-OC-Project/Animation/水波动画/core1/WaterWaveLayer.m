//
//  WaterWaveLayer.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/8.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "WaterWaveLayer.h"

@implementation WaterWaveLayer
{
    CGFloat imageWidth;
    CALayer *imageLayer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _offsetY = 50;
        _waveColor = [UIColor redColor];
        self.instanceCount = 10;
        
        imageLayer = [CALayer layer];
        [self addSublayer:imageLayer];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    imageWidth = self.bounds.size.width / self.instanceCount;
    imageLayer.frame = CGRectMake(0, 0, imageWidth, self.bounds.size.height);
    self.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, imageWidth, 0, 0);
    [self fetchImageWithSize:imageLayer.bounds.size handler:^(UIImage *image) {
        imageLayer.contents = (__bridge id _Nullable)(image.CGImage);
    }];
    
    [self addWaveAnimation];
}

- (void)addWaveAnimation {
    static NSString * const AnimationKey = @"waterwave";
    if ([self animationForKey:AnimationKey]) {
        [self removeAnimationForKey:AnimationKey];
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, imageWidth-self.bounds.size.width, 0, 0)];
    animation.duration = self.instanceCount * 1;
    animation.repeatCount = NSIntegerMax;
    [self addAnimation:animation forKey:AnimationKey];
}

- (void)fetchImageWithSize:(CGSize)size handler:(void (^)(UIImage *image))handler {
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    filePath = [filePath stringByAppendingPathComponent:@"waterwave.png"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            CGFloat y = 0;
            CGFloat amplitude = size.width / 8.0;
            
            UIGraphicsBeginImageContext(size);
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, size.height*0.5)];
            for (int x = 0; x<=size.width; x++) {
                y = amplitude * sin(( x / size.width) * M_PI * 2) + _offsetY;
                [path addLineToPoint:CGPointMake(x, y)];
            }
            [path addLineToPoint:CGPointMake(size.width, size.height)];
            [path addLineToPoint:CGPointMake(0, size.height)];
            [path closePath];
            [_waveColor setFill];
            [path fill];
            
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(image);
            });
            
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:filePath atomically:YES];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(image);
            });
        }
    });
}

@end
