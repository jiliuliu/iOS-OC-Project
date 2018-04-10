//
//  ARScanView.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/22.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ARScanBackgroundLayer.h"
@class ARScanView;

@protocol QRCodeViewDelegate <NSObject>

@optional

/**
 *  获取QR的扫描结果
 *
 *  @param codeView   QRCodeView实体对象
 *  @param codeString 扫描字符串
 */
- (void)QRCodeView:(ARScanView *)codeView codeString:(NSString *)codeString;

@end


@interface ARScanView : UIView

/**
 *  自定义图层，设置额外视图
 */
@property (nonatomic, strong) ARScanBackgroundLayer *backgroundLayer;

/**
 *  代理
 */
@property (nonatomic, weak) id <QRCodeViewDelegate> delegate;


/**
 *  开始扫描
 */
- (void)start;

/**
 *  结束扫描
 */
- (void)stop;


@end
