//
//  Bluetooth.h
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bluetooth : NSObject

@property (nonatomic, copy) void (^discoverPeripheral) (NSArray *peripheralNames, NSArray *advertisementDatas);
//@property (nonatomic, copy) void (^discoverPeripheral) (NSArray *peripheralNames, NSArray *advertisementDatas);

- (void)connectPeripheralWithIndex:(NSInteger)index;

@end
