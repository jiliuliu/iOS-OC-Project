//
//  TextKitDemoVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/7/25.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TextKitDemoVC.h"

@interface TextKitDemoVC ()

@end

@implementation TextKitDemoVC

+ (NSDictionary *)info {
    return @{HMVCName: @"TextKitDemoVC",
             HMTitle: @"TextKit探究",
             HMDetail: @""
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [UITextView new];
    textView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textView];
    textView.frame = self.view.bounds;
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
