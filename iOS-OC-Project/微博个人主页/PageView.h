//
//  PageView.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/19.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageView;
@protocol PageViewDelegate

- (NSInteger)numberOfPagesInPageView;

- (CGFloat)heightForHeaderViewInPageView:(PageView *)pageView;
- (CGFloat)heightForSuspendedViewInPageView:(PageView *)pageView;
- (CGFloat)pageView:(PageView *)pageView spaceForItemInSuspendedViewAtIndex:(NSInteger)index;

- (UIView *)headerViewInPageView:(PageView *)pageView;
- (UIView *)pageView:(PageView *)pageView itemViewAtIndex:(NSInteger)index;
- (UIView *)pageView:(PageView *)pageView contentViewAtIndex:(NSInteger)index;

@end

@interface PageView : UIView

@property (nonatomic, weak) id <PageViewDelegate> delegate;

- (void)reloadData;

@property (nonatomic, weak) UITableView *containerView;
@property (nonatomic, weak) UIView *headerBgView;
@property (nonatomic, weak) UIView *suspendedBgView;
@property (nonatomic, weak) UIScrollView *contentContainerView;

@end
