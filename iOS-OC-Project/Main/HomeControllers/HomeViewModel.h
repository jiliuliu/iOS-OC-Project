//
//  HomeViewModel.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/30.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

@interface HomeViewModel : NSObject

@property (nonatomic, strong) NSDictionary *totalData;

- (NSInteger)numberOfSection;
- (NSInteger)numberOfCellAtSection:(NSInteger)section;
- (NSDictionary *)cellDataAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)titleAtSection:(NSInteger)section;

@end
