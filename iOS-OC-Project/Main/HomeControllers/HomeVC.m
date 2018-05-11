//
//  HomeVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "HomeVC.h"
#import "HomeViewModel.h"
#import "HomeCell.h"

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) HomeViewModel *viewModel;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (HomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [HomeViewModel new];
        NSUInteger index = [self.tabBarController.viewControllers indexOfObject:self.navigationController];
        if (index == 0) {
            _viewModel.totalData = [HomeModel animations];
        } else if (index == 1) {
            _viewModel.totalData = [HomeModel scenes];
        } else if (index == 2) {
            _viewModel.totalData = [HomeModel tests];
        }
    }
    return _viewModel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfCellAtSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.backgroundColor = indexPath.row ? [UIColor whiteColor] : [UIColor colorWithWhite:0.95 alpha:1];
    NSDictionary *data = [self.viewModel cellDataAtIndexPath:indexPath];
    cell.titleLabel.text = data[HMTitle];
    cell.classNameLabel.text = data[HMVCName];
    cell.detailLabel.text = data[HMDetail];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.viewModel titleAtSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *data = [self.viewModel cellDataAtIndexPath:indexPath];
    Class vcClass = NSClassFromString(data[HMVCName]);
    [self.navigationController pushViewController:[vcClass new] animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}



@end
