//
//  WaveView.h
//  RDWave
//
//  Created by 刘吉六 on 2017/7/27.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDWaveView : UIView

@property (nonatomic, strong) UIColor *waveColor;
//波浪高度
@property (nonatomic, assign) CGFloat progress;
//波峰值 占周长的  百分比
@property (nonatomic, assign) CGFloat amplitude;
//当offset = 1时，一秒钟曲线移动一个周期，可以通过修改它，改变波浪速度
@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, strong) UILabel *textLabel;


@end
