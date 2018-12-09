//
//  HitVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/11/3.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "HitVC.h"
#import "UIView+Hit.h"

@interface HitVC ()

@end

@implementation HitVC

+ (NSDictionary *)info {
    return @{HMVCName: @"HitVC",
             HMTitle: @"扩大view点击范围",
             HMDetail: @"实现：修改pointInside:withEvent:方法"
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.hitTestEdgeInsets = UIEdgeInsetsMake(-100, -100, -100, -100);
    [button setTitle:@"点击按钮边缘" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(tapAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)tapAction {
    NSLog(@"2222");
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
