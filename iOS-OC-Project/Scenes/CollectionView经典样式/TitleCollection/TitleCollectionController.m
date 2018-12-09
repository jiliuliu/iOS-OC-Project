//
//  TitleCollectionController.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/12/9.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TitleCollectionController.h"
#import "TitleCollectionCell.h"
#import "TitleCollectionHeaderView.h"

@interface TitleCollectionController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TitleCollectionController

+ (NSDictionary *)info {
    return @{HMVCName: @"TitleCollectionController",
             HMTitle: @"带分区标题 可增删cell",
             HMDetail: @"1.点击最后一个cell，表示增加cell；\n2.点击其它cell，表示删除"
             };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionView];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@[@""].mutableCopy,
                        @[@""].mutableCopy,
                        @[@""].mutableCopy, ];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<10; i++) {
            CGFloat count = arc4random_uniform(8) + 1;
            NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:count];
            for (int j=0; j<count; j++) {
                [subArray addObject:@""];
            }
            [array addObject:subArray];
        }
        _dataSource = array.copy;
    }
    return _dataSource;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat itemSpacing = 9;
        CGFloat countPerLine = 3;
        CGFloat sectionInsetLeft = 25;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemWidth =  (screenWidth + itemSpacing - sectionInsetLeft * 2) / countPerLine - itemSpacing;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = itemSpacing;
        layout.minimumLineSpacing = 11;
        layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 53);
        layout.sectionInset = UIEdgeInsetsMake(0, sectionInsetLeft, 0, sectionInsetLeft);
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:TitleCollectionCell.class forCellWithReuseIdentifier:NSStringFromClass(TitleCollectionCell.class)];
        [collectionView registerClass:TitleCollectionHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(TitleCollectionHeaderView.class)];
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(TitleCollectionHeaderView.class) forIndexPath:indexPath];
    sectionHeader.titleLabel.text = [NSString stringWithFormat:@"SECTION %ld", indexPath.section];
    return sectionHeader;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TitleCollectionCell.class) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0
                                           green:arc4random_uniform(256)/255.0
                                            blue:arc4random_uniform(256)/255.0 alpha:1.0];
    if (indexPath.item + 1 == [self.dataSource[indexPath.section] count]) {
        cell.backgroundColor = UIColor.blackColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item + 1 == [self.dataSource[indexPath.section] count]) {
        [self addItemAtIndexPath:indexPath];
    } else {
        [self removeItemAtIndexPath:indexPath];
    }
}

- (void)addItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.dataSource[indexPath.section];
    [array addObject:@""];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:array.count-2 inSection:indexPath.section];
    [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.dataSource[indexPath.section];
    [array removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end


