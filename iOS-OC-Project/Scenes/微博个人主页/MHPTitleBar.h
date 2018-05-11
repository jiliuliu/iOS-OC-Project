//
//  MHPTitleBar.h
//  Master
//
//  Created by 刘吉六 on 2017/11/29.
//  Copyright © 2017年 qushenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHPTitleBar;
@protocol MHPTitleBarDelegate

- (void)titleBar:(MHPTitleBar *)titleBar clickAtIndex:(NSInteger)index;
- (void)clickAddInTitleBar:(MHPTitleBar *)titleBar;

@end

@interface MHPTitleBar : UIView

@property (nonatomic, weak) id <MHPTitleBarDelegate> delegate;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL hasLine;

@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) CGFloat lineMargin;
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;

@end
