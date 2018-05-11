//
//  MHPTitleBar.m
//  Master
//
//  Created by 刘吉六 on 2017/11/29.
//  Copyright © 2017年 qushenghuo. All rights reserved.
//

#import "MHPTitleBar.h"

@class MHPTitleBarCell;
@interface MHPTitleBar () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *_itemWidths;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, weak) MHPTitleBarCell *preCell;
@end


@interface MHPTitleBarCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@end

@implementation MHPTitleBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = 0;
        _lineMargin = 8;
        _lineHeight = 1.5;
        _itemSpace = 36;
        _itemWidths = [NSMutableArray array];
        _normalColor = [UIColor blackColor];
        _selectColor = [UIColor redColor];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
}

- (void)setupUI {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 29, 0, 24+50);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, w, self.bounds.size.height) collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = self.backgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView registerClass:[MHPTitleBarCell class] forCellWithReuseIdentifier:@"MHPTitleBarCell"];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(self.bounds.size.width-50, 0, 50, self.bounds.size.height);
    [addButton setImage:[UIImage imageNamed:@"homepage_add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    addButton.alpha = 0.8;
    addButton.backgroundColor = [UIColor blackColor];
    addButton.layer.shadowColor = [UIColor blackColor].CGColor;
    addButton.layer.shadowOffset = CGSizeMake(-1, 0);
    addButton.layer.shadowRadius = 3;
    addButton.layer.shadowOpacity = 0.3;
    [self addSubview:addButton];
}

- (void)setHasLine:(BOOL)hasLine {
    _hasLine = hasLine;
    
    if (_lineView) return;
    UIView *line = [UIView new];
    line.backgroundColor = _lineColor ?: [UIColor blackColor];
    [_collectionView addSubview:line];
    _lineView = line;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;

    //计算item宽度
    [_itemWidths removeAllObjects];
    for (NSString *title in titles) {
        CGFloat width = [title boundingRectWithSize:CGSizeMake(1000, 50) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.width;
        [_itemWidths addObject:@(width+2)];
    }

    [_collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.index = self.index;
    });
}

- (void)clickAdd:(UIButton *)button {
    [self.delegate clickAddInTitleBar:self];
}


#pragma --mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MHPTitleBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MHPTitleBarCell" forIndexPath:indexPath];
    cell.label.textColor = indexPath.item == self.index ? _selectColor : _normalColor;
    cell.label.text = _titles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.index = indexPath.item;
    [self.delegate titleBar:self clickAtIndex:indexPath.item];
}

#pragma --mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([_itemWidths[indexPath.item] floatValue], collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _itemSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _itemSpace;
}



#pragma --mark  update ui

- (void)setIndex:(NSInteger)index {
    if (index < 0 || index >= _titles.count) {
        return ;
    }
    _index = index;
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.hasLine) {
        [self moveLineToIndex:index];
    }
}

- (void)moveLineToIndex:(NSInteger)index {
    if (index < 0 && index >= _titles.count) {
        return ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = [self calculateLineFrameAtIndex:index];
    }];
}

- (CGRect)calculateLineFrameAtIndex:(NSInteger)index {
    if (index < 0 && index >= _titles.count) {
        return CGRectZero;
    }
    UICollectionViewLayoutAttributes * layoutAttributes = [_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    CGRect frame = CGRectMake(0, 0, 0, _lineHeight);
    frame.origin.x = layoutAttributes.frame.origin.x - _lineMargin*0.5;
    frame.origin.y = _collectionView.bounds.size.height-2-_lineHeight;
    frame.size.width = layoutAttributes.frame.size.width+_lineMargin;
    return frame;
}


@end


@implementation MHPTitleBarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:15];
    _label.frame = self.bounds;
    [self.contentView addSubview:_label];
    
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}


@end

