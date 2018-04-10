//
//  RDWave.h
//  RDWave
//
//  Created by 刘吉六 on 2017/7/27.
//  Copyright © 2017年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDWave : UIView

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text;

@property (nonatomic, assign) CGFloat progress;
//@property (nonatomic, copy) UIColor *topColor;
//@property (nonatomic, copy) UIColor *bottomColor;

@end
