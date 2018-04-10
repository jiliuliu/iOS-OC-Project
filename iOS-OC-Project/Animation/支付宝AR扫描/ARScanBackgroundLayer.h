//
//  ARScanLayer.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/23.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARScanBackgroundLayer : CALayer

@property (nonatomic, assign) CGFloat inRadius;
@property (nonatomic, assign) CGPoint inCenter;
@property (nonatomic, assign) CGFloat spaceBetweenCircles;
@property (nonatomic, assign) NSInteger numberOfPolygon;

@property (nonatomic, assign, readonly) CGRect polygonBounds;

- (void)resetDraw;

@end
