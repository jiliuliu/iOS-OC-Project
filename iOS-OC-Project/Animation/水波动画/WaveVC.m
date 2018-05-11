//
//  WaveVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/7.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "WaveVC.h"
#import "WaveView.h"
#import "WaterWaveView.h"
#import "RDWave.h"

@interface WaveVC ()

@end

@implementation WaveVC

+ (NSDictionary *)info {
    return @{HMVCName: @"WaveVC",
             HMTitle: @"水波溜溜球",
             HMDetail: @"技术点：分别用三种方式实现：CAKeyframeAnimation.path、图片、CADisplayLink；\n文字的双色效果都是通过mask实现，暂时没有找到替代"
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat x = self.view.center.x - 50;
    CGFloat y = 84;
    CGFloat space = (self.view.bounds.size.height - y - 50) / 3;
    
    WaveView *wave = [[WaveView alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
    wave.tag = 10;
    wave.waveColor = [UIColor redColor];
    [self.view addSubview:wave];
    
    y += space;
    WaterWaveView *waterWave = [[WaterWaveView alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
    waterWave.tag = 11;
    waterWave.waveColor = [UIColor purpleColor];
    [self.view addSubview:waterWave];

    y += space;
    RDWave *rdwave = [[RDWave alloc] initWithFrame:CGRectMake(x, y, 100, 100) andText:@"RD"];
    rdwave.progress = 0.5;
    rdwave.tag = 12;
    [self.view addSubview:rdwave];
    
    [self addLabels];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height-50, self.view.frame.size.width-100, 50)];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(clickSlider:) forControlEvents:UIControlEventValueChanged];
}

- (void)clickSlider:(UISlider *)slider {
    WaveView *wave = [self.view viewWithTag:10];
    wave.waveLayer.progress = slider.value;
    
    RDWave *rdwave = [self.view viewWithTag:12];
    rdwave.progress = slider.value;
}

- (void)addLabels {
    
    NSArray *strings = @[@"WaveView：用CAShapeLayer绘制波浪，CAKeyframeAnimation.path做流动效果。效果一般，性能中等",
                         @"WaterWaveView：异步绘制波浪图片，并做本地缓存，CABasicAnimation.transform做流动效果。效果最差，性能最优，但不支持波浪的上升下降",
                         @"RDWave：CADisplayLink加drawRect实现，效果最好，性能最差,cpu一直占10%"];
    
    CGFloat y = 84;
    CGFloat space = (self.view.bounds.size.height - y - 50) / 3;
    
    for (int i=0; i<3; i++) {
        y += space;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y-100, self.view.bounds.size.width-40, 100)];
        label.text = strings[i];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
