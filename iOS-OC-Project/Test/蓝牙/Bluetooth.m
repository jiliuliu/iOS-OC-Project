//
//  Bluetooth.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "Bluetooth.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface Bluetooth () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;

@property (nonatomic, strong) NSMutableArray <CBPeripheral *> *peripherals;
@property (nonatomic, strong) NSMutableArray *peripheralNames;
@property (nonatomic, strong) NSMutableArray *advertisementDatas;

@end

@implementation Bluetooth

- (instancetype)init
{
    self = [super init];
    if (self) {
        _peripherals = @[].mutableCopy;
        _peripheralNames = @[].mutableCopy;
        _advertisementDatas = @[].mutableCopy;
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        _centralManager.delegate = self;
    }
    return self;
}

- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    if (@available(iOS 10.0, *)) {
        if (central.state == CBManagerStatePoweredOn) {
            [central scanForPeripheralsWithServices:nil options:nil];
        } else {
            [Helper alertWithContent:@"蓝牙不可用，请检查"];
        }
    } else {
        // Fallback on earlier versions
        [Helper alertWithContent:@"蓝牙不可用，请检查"];
    }
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (peripheral.name != nil && ![self.peripheralNames containsObject:peripheral.name]) {
        [self.peripherals addObject:peripheral];
        [self.peripheralNames addObject:peripheral.name];
        [self.advertisementDatas addObject:advertisementData];
        self.discoverPeripheral(self.peripheralNames.copy, self.advertisementDatas.copy);
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error {
    NSLog(@"%@", service);
}


- (void)connectPeripheralWithIndex:(NSInteger)index {
    [_centralManager connectPeripheral:_peripherals[index] options:nil];
}

@end
