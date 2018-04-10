//
//  RDWave.m
//  RDWave
//
//  Created by 刘吉六 on 2017/7/27.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

#import "RDWave.h"
#import "RDWaveView.h"

@implementation RDWave
{
    RDWaveView *_waveView;
    RDWaveView *_maskWaveView;
    UILabel *_topLabel;
}

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        _waveView = [[RDWaveView alloc] initWithFrame:self.bounds];
//        _waveView.progress = 0.5;
        _waveView.textLabel.text = text;
        [self addSubview:_waveView];
        
        _maskWaveView = [[RDWaveView alloc] initWithFrame:self.bounds];
//        _maskWaveView.progress = 0.5;
        _maskWaveView.waveColor = [UIColor blueColor];
        _maskWaveView.backgroundColor = [UIColor clearColor];
        
        _topLabel = [UILabel new];
        _topLabel.frame = _waveView.textLabel.frame;
        _topLabel.text = _waveView.textLabel.text;
        _topLabel.textAlignment = _waveView.textLabel.textAlignment;
        _topLabel.font = _waveView.textLabel.font;
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.maskView = _maskWaveView;
        [self addSubview:_topLabel];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _waveView.progress = progress;
    _maskWaveView.progress = progress;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
