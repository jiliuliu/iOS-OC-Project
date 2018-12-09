//
//  TitleCollectionHeaderView.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/12/9.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TitleCollectionHeaderView.h"

@implementation TitleCollectionHeaderView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:16];
        [self addSubview:label];
        _titleLabel = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(21, 25, 10, 25));
            make.height.mas_equalTo(23);
        }];
    }
    return _titleLabel;
}
@end
