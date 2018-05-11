//
//  TabBarController.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeVC.h"
#import <CoreGraphics/CoreGraphics.h>

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titles = @[@"animation", @"scene", @"test", @"optimization"];
    UIFont *font = [UIFont systemFontOfSize:16];
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName: [UIColor blackColor],
                                     NSFontAttributeName: font};
    NSDictionary *textAttributes1 = @{
                                      NSForegroundColorAttributeName: [UIColor greenColor],
                                      NSFontAttributeName: font};
    UIImage *image = [UIImage six_imageWithColor:[UIColor clearColor]];
    CGFloat offset = (self.tabBarController.tabBar.frame.size.height - \
                      font.lineHeight) * 0.5;
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:titles.count];
    
    for (int i=0; i<titles.count; i++) {
        HomeVC *home = [HomeVC new];
        home.title = titles[i];
        [home.tabBarItem setImage:image];
        [home.tabBarItem setSelectedImage:image];
        [home.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
        [home.tabBarItem setTitleTextAttributes:textAttributes1 forState:UIControlStateSelected];
        [home.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, offset)];
        
        [controllers addObject:[[NavigationController alloc] initWithRootViewController:home]];
    }
    self.viewControllers = controllers.copy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
