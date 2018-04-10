//
//  ARScanViewController.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/22.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "VCARScan.h"
#import "ARScanView.h"

@interface VCARScan () <QRCodeViewDelegate>
@property (nonatomic, strong) ARScanView *scanView;
@end

@implementation VCARScan

+ (NSDictionary *)info {
    return @{HMVCName: @"VCARScan",
             HMTitle: @"支付宝AR扫描",
             HMDetail: @"技术点：1.多边形算法；\n   2.镂空效果；\n   3.CAShapeLayer的strokeStart、strokeEnd动画\n未解决问题：不规则路径的渐变色\n已做优化：对静态 复杂图层做栅栏化处理"
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
        
    ARScanView *scanView = [[ARScanView alloc] initWithFrame:self.view.bounds];
    scanView.delegate = self;
    [self.view addSubview:scanView];
    _scanView = scanView;
}

- (void)QRCodeView:(ARScanView *)codeView codeString:(NSString *)codeString {
    NSLog(@"%@", codeString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
