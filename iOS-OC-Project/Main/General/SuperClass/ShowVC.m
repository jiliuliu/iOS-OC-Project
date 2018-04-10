//
//  ShowVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "ShowVC.h"

@interface ShowVC ()

@end

@implementation ShowVC

+ (NSDictionary *)info {
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupRightItem];
}

- (void)setupRightItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemBookmarks) target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickRightItem {
    NSString *message = [[self class] info][HMDetail];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"描述" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
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
