//
//  TitleCollectionCell.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/12/9.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TitleCollectionCell.h"

@implementation TitleCollectionCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _imageView;
}

@end
