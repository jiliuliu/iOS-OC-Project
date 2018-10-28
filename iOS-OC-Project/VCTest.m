//
//  VCTest.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/8/23.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "VCTest.h"
#import <SIXEditorView.h>

@interface VCTest ()


@end

@implementation VCTest

+ (NSDictionary *)info {
    return @{HMVCName: @"VCTest",
             HMTitle: @"测试专用",
             HMDetail: @"测试专用"
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SIXEditorView *view = [SIXEditorView new];
    [self.view addSubview:view];
    view.frame = self.view.frame;
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
