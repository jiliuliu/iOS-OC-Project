//
//  ExcelShareItem.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/7/23.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "ExcelShareItem.h"

@implementation ExcelShareItem

#pragma mark - UIActivityItemSource
-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return [NSData data];
}

-(id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return self.data;
}

-(NSString*)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType
{
    return @"port.csv";
}

-(NSString*)activityViewController:(UIActivityViewController *)activityViewController dataTypeIdentifierForActivityType:(NSString *)activityType
{
    return @"com.hsun.customUTI.csv";
}

- (NSData *)data {
    if (_data) return _data;
    
    // 创建存放XLS文件数据的数组
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    // 第一行内容
    [xlsDataMuArr addObject:@"Time"];
    [xlsDataMuArr addObject:@"Address"];
    [xlsDataMuArr addObject:@"Person"];
    [xlsDataMuArr addObject:@"Reason"];
    [xlsDataMuArr addObject:@"Process"];
    [xlsDataMuArr addObject:@"Result"];
    
    // 100行数据
    for (int i = 0; i < 100; i ++) {
        [xlsDataMuArr addObject:@"2016-12-06 17:18:40"];
        [xlsDataMuArr addObject:@"GuangZhou"];
        [xlsDataMuArr addObject:@"Mr.Liu"];
        [xlsDataMuArr addObject:@"Buy"];
        [xlsDataMuArr addObject:@"TaoBao"];
        [xlsDataMuArr addObject:@"Debt"];
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%6 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    
    _data = fileData;
    return _data;
}

@end
