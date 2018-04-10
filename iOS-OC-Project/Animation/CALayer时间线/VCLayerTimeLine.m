//
//  VCLayerTimeLine.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/31.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "VCLayerTimeLine.h"
#import "TimeLineLayer.h"

@interface VCLayerTimeLine () <UITextFieldDelegate>

@property (nonatomic, strong) TimeLineLayer *timeLineLayer;

@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation VCLayerTimeLine

+ (NSDictionary *)info {
    return @{HMVCName: @"VCLayerTimeLine",
             HMTitle: @"CALayer时间线测试",
             HMDetail: @""
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //路径动画
    [self test0];
    
    //只需看打印
//    [self test1];
//    [self test2];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _timeLineLayer.frame = self.bgView.bounds;
}

- (IBAction)addRemove:(id)sender {
    [_timeLineLayer addAndRemoveAnimation];
}

- (IBAction)startStop:(id)sender {
//    self.timeLineLayer.airplaneLayer.beginTime = -2;
//    self.timeLineLayer.airplaneLayer.timeOffset = 2;
    [_timeLineLayer startAndStopAnimation];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)test0 {
    _timeLineLayer = [TimeLineLayer layer];
    [self.bgView.layer addSublayer:_timeLineLayer];
}

//当speed=1时，beginTime和timeOffset效果相反
- (void)test1 {
    CALayer *layer1 = [CALayer new];
    CALayer *layer2 = [CALayer new];
    CALayer *layer3 = [CALayer new];
    [layer1 addSublayer:layer2];
    [layer2 addSublayer:layer3];
    [self.view.layer addSublayer:layer1];
    
    layer2.beginTime = 1;
    layer3.beginTime = 2;
    
    CFTimeInterval absoluteTime = CACurrentMediaTime();
    CFTimeInterval localTime1 = [layer1 convertTime:absoluteTime fromLayer:nil];
    CFTimeInterval localTime2 = [layer2 convertTime:absoluteTime fromLayer:nil];
    CFTimeInterval localTime3 = [layer3 convertTime:absoluteTime fromLayer:nil];
    
    NSLog(@"\nabsoluteTime:%2.lf, \nlocalTime1:%2.lf, \nlocalTime2:%2.lf, \nlocalTime3:%2.lf", absoluteTime, localTime1, localTime2, localTime3);
    
    CFTimeInterval localTime3f1 = [layer3 convertTime:absoluteTime fromLayer:layer1];
    CFTimeInterval localTime3f2 = [layer3 convertTime:absoluteTime fromLayer:layer2];
    
    CFTimeInterval localTime3t1 = [layer3 convertTime:absoluteTime toLayer:layer1];
    CFTimeInterval localTime3t2 = [layer3 convertTime:absoluteTime toLayer:layer2];
    
    CFTimeInterval localTime1f3 = [layer1 convertTime:absoluteTime fromLayer:layer3];
    CFTimeInterval localTime1t3 = [layer1 convertTime:absoluteTime toLayer:layer3];
    
    NSLog(@"图层间时间转换\nlocalTime3f1:%2.lf, \nlocalTime3f2:%2.lf, \nlocalTime3t1:%2.lf, \nlocalTime3t2:%2.lf, \nlocalTime1f3:%2.lf, \nlocalTime1t3:%2.lf", localTime3f1, localTime3f2, localTime3t1, localTime3t2, localTime1f3, localTime1t3);
    
    layer2.beginTime = 0;
    layer3.beginTime = 0;
    layer2.timeOffset = 1;
    layer3.timeOffset = 2;
    
    CFTimeInterval localTimeOffset1 = [layer1 convertTime:absoluteTime fromLayer:nil];
    CFTimeInterval localTimeOffset2 = [layer2 convertTime:absoluteTime fromLayer:nil];
    CFTimeInterval localTimeOffset3 = [layer3 convertTime:absoluteTime fromLayer:nil];
    
    NSLog(@"\nlocalTimeOffset1:%2.lf, \nlocalTimeOffset2:%2.lf, \nlocalTimeOffset3:%2.lf", localTimeOffset1, localTimeOffset2, localTimeOffset3);
}

/* Additional offset in active local time. i.e. to convert from parent
 * time tp to active local time t: t = (tp - begin) * speed + offset.
 * 验证这句话
 */
- (void)test2 {
    CALayer *layer1 = [CALayer new];
    CALayer *layer2 = [CALayer new];
    [layer1 addSublayer:layer2];
    [self.view.layer addSublayer:layer1];
    
    layer2.beginTime = 3;
    layer2.speed = 2;
    layer2.timeOffset = 5;
    
    //获取图层在此刻的本地时间
    CFTimeInterval absoluteTime = CACurrentMediaTime();
    CFTimeInterval t = [layer1 convertTime:absoluteTime fromLayer:nil];
    CFTimeInterval tp = [layer2 convertTime:absoluteTime toLayer:nil];
    
    //验证公式t = (tp - begin) * speed + offset
    CFTimeInterval t0 = (tp - layer2.beginTime) * layer2.speed + layer2.timeOffset;
    
    NSLog(@"t:                              %.2lf", t);
    NSLog(@"(tp - begin) * speed + offset:  %.2lf", t0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
