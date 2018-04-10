//
//  WaveView.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/7.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "WaveView.h"


@interface WaveView ()

@property (nonatomic, strong) CATextLayer *bottomTextLayer;
@property (nonatomic, strong) CATextLayer *topTextLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *strokeCircleLayer;

@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _text = @"50%";
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _bottomTextLayer = [self textLayer];
    _bottomTextLayer.foregroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_bottomTextLayer];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_circleLayer];
    
    _topTextLayer = [self textLayer];
    _topTextLayer.foregroundColor = [UIColor whiteColor].CGColor;
    [_circleLayer addSublayer:_topTextLayer];
    
    _strokeCircleLayer = [CAShapeLayer layer];
    _strokeCircleLayer.lineWidth = 2;
    _strokeCircleLayer.strokeColor = [UIColor cyanColor].CGColor;
    _strokeCircleLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_strokeCircleLayer];
    
    _waveLayer = [WaveLayer layer];
    _waveLayer.progress = 0.45;
    _circleLayer.mask = _waveLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"layoutSubviews");
    
    CGFloat minSize = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius = minSize / 2.0 - _circleLayer.lineWidth/2.0;
    
    _circleLayer.bounds = CGRectMake(0, 0, minSize, minSize);
    _circleLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    _strokeCircleLayer.frame = _circleLayer.frame;
    
    _bottomTextLayer.position = _circleLayer.position;
    _topTextLayer.position = CGPointMake(minSize/2.0, minSize/2.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(minSize/2.0, minSize/2.0) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _circleLayer.path = path.CGPath;
    _strokeCircleLayer.path = path.CGPath;
    
    _waveLayer.frame = _circleLayer.bounds;
}

- (CATextLayer *)textLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = _text;
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    UIFont *font = [UIFont boldSystemFontOfSize:40];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName: font}];
    textLayer.bounds = CGRectMake(0, 0, size.width+120, size.height);
    
    return textLayer;
}

- (void)setText:(NSString *)text {
    _text = text;
    _bottomTextLayer.string = text;
    _topTextLayer.string = text;
}

- (void)setWaveColor:(UIColor *)waveColor {
    _waveColor = waveColor;
    self.circleLayer.fillColor = _waveColor.CGColor;
}

@end
