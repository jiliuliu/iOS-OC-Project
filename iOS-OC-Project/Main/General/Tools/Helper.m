//
//  Helper.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (void)alertWithContent:(NSString *)content {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:content preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [UIApplication.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
