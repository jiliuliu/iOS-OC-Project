//
//  HomeViewModel.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/30.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "HomeViewModel.h"
#import "ShowVC.h"

@implementation HomeViewModel

- (NSInteger)numberOfSection {
    return [_totalData[HMSectionTitles] count];
}

- (NSInteger)numberOfCellAtSection:(NSInteger)section {
    return [_totalData[_totalData[HMSectionTitles][section]] count];
}

- (NSDictionary *)cellDataAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = _totalData[_totalData[HMSectionTitles][indexPath.section]][indexPath.row];
    return [NSClassFromString(className) performSelector:@selector(info)];
}

- (NSString *)titleAtSection:(NSInteger)section {
    return _totalData[HMSectionTitles][section];
}
@end
