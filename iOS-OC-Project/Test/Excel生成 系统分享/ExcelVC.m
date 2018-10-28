//
//  ExcelVC.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/7/23.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "ExcelVC.h"
#import "ExcelShareItem.h"

@interface ExcelVC ()
@end

@implementation ExcelVC

+ (NSDictionary *)info {
    return @{HMVCName: @"ExcelVC",
             HMTitle: @"excel生成，原生分享",
             HMDetail: @""
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(clickShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [button setTitle:@"生成excel，并分享" forState:(UIControlStateNormal)];
    [button sizeToFit];
    button.center = self.view.center;
}

- (void)clickShare {
    //构建UIActivityViewController
    [self createExcel];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/export.csv"];
    NSArray *items = @[[NSURL fileURLWithPath:filePath]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    
    activityViewController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
    };
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)createExcel {
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
    
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    // 文件路径
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.csv"];
    NSLog(@"文件路径：\n%@",filePath);
    // 生成xls文件
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
}

@end
