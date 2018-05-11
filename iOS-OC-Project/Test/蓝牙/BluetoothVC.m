//
//  BluetoothVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/4/18.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "BluetoothVC.h"
#import "Bluetooth.h"
#import "BluetoothCell.h"

@interface BluetoothVC ()

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) Bluetooth *bluetooth;

@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;

@end

@implementation BluetoothVC

+ (NSDictionary *)info {
    return @{HMVCName: @"BluetoothVC",
             HMTitle: @"蓝牙demo",
             HMDetail: @""
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bluetooth = [Bluetooth new];
    __weak typeof (self) wself = self;
    self.bluetooth.discoverPeripheral = ^(NSArray *peripheralNames, NSArray *advertisementDatas) {
        wself.array1 = peripheralNames;
        wself.array2 = advertisementDatas;
        [wself.tableView reloadData];
    };
    [self.tableView registerNib:[UINib nibWithNibName:@"BluetoothCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BluetoothCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    cell.label1.text = self.array1[indexPath.row];
    cell.label2.text = [self.array2[indexPath.row] description];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.bluetooth connectPeripheralWithIndex:indexPath.row];
//    BluetoothVC *vc = [BluetoothVC new];
//    vc.type = 2;
//    [self.navigationController pushViewController:vc animated:YES];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
