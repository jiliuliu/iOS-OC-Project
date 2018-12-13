//
//  WaveView.m
//  RDWave
//
//  Created by 刘吉六 on 2017/7/27.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

#import "RDWaveView.h"

@interface RDWaveView ()
{
    CADisplayLink *_displayLink;
    CGFloat _currentOffset;
    CGFloat _currentProgress;
}


@end

@implementation RDWaveView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progress = 0.5;
        _amplitude = 0.1;
        _currentProgress = 1;
        _offset = 1 * (M_PI * 2 / 60);
        _waveColor = [UIColor blueColor];
        self.backgroundColor = [UIColor whiteColor];
        [self drawCircle];
        [self contrutUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetLineWidth(ctx, 1);
    CGContextSetFillColorWithColor(ctx, _waveColor.CGColor);
    
    float radius = MIN(rect.size.width, rect.size.height);
    float startY = _currentProgress * radius;
    float y = startY;
    
    CGPathMoveToPoint(path, nil, 0, y);
    
    for(float x = 0; x <= radius; x++){
        y = _amplitude * radius * sin( x / radius * M_PI * 2 + _currentOffset) + startY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, radius, radius);
    CGPathAddLineToPoint(path, nil, 0, radius);
    CGPathAddLineToPoint(path, nil, 0, y);
    
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    CGPathRelease(path);
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow == nil) {
        [self stopAnimation];
    }
}

- (void)didMoveToWindow {
    [self startAnimation];
}

- (void)startAnimation {
    if (_displayLink) {
        [self stopAnimation];
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculateOffset)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)calculateOffset {
    _currentOffset += _offset;
    
    CGFloat space = 1 / 120.0;
    if (fabs(_currentProgress - _progress) < space) {
        _currentProgress = _progress;
    } else if (_currentProgress > _progress) {
        _currentProgress -= space;
    } else if (_currentProgress < _progress) {
        _currentProgress += space;
    }
    [self setNeedsDisplay];
}

- (void)stopAnimation {
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)contrutUI {
    _textLabel = [UILabel new];
    _textLabel.textColor = _waveColor;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.frame = self.bounds;
    _textLabel.font = [UIFont boldSystemFontOfSize:self.bounds.size.height * 0.5];
    [self addSubview:_textLabel];
}

- (void)drawCircle {
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor greenColor].CGColor;
}



@end
