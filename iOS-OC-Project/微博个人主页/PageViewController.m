//
//  PageViewController.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/22.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "PageViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface PageViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.currentIndex = 0;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    
    __weak PageViewController *wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wself.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *temp = wself.datas[wself.currentIndex];
            NSInteger start = temp.count;
            for (NSInteger j=start; j<start+15; j++) {
                [temp addObject:[NSString stringWithFormat:@"%@--%ld", wself.titles[wself.currentIndex], j]];
            }
            [self.tableView reloadData];
            [wself.tableView.mj_footer endRefreshing];
        });
    }];
}


#pragma - mark lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            //            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        _headerView.image = [UIImage imageNamed:@"img6"];
        _headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * _headerView.image.size.height / _headerView.image.size.width);
    }
    return _headerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(100, 40);
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles =  @[@"天龙八部", @"仙剑", @"小李飞刀", @"神雕侠侣", @"笑傲江湖", @"侠客岛"];
    }
    return _titles;
}

- (NSArray *)datas {
    if (!_datas) {
        NSMutableArray *datas = [NSMutableArray arrayWithCapacity:self.titles.count];
        for (int i=0; i<self.titles.count; i++) {
            NSMutableArray *temp = @[].mutableCopy;
            for (int j=0; j<15; j++) {
                [temp addObject:[NSString stringWithFormat:@"%@--%d", self.titles[i], j]];
            }
            datas[i] = temp;
        }
        _datas = datas.copy;
    }
    return _datas;
}


#pragma - mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas[self.currentIndex] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.collectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.datas[self.currentIndex][indexPath.row];
    return cell;
}


#pragma - mark UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *label = [cell.contentView viewWithTag:11];
    if (!label) {
        label = [UILabel new];
        label.tag = 11;
        label.frame = CGRectMake(0, 0, 90, 40);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor greenColor];
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        [cell.contentView addSubview:label];
    }
    
    if (indexPath.row == self.currentIndex) {
        label.textColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:20];
    } else {
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:18];
    }
    
    label.text = self.titles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //change ui
    self.currentIndex = indexPath.item;
    [collectionView reloadData];
    
    //    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    CGFloat height = self.tableView.tableHeaderView.frame.size.height;
    NSLog(@"%.2lf,%.2lf", height, self.tableView.contentOffset.y);
    if (self.tableView.contentOffset.y >= height) {
        self.tableView.contentOffset = CGPointMake(0, height);
    }
    
    //reload data
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView) {
//        NSLog(@"%.2lf", scrollView.contentOffset.y);
//    }
//}


@end
