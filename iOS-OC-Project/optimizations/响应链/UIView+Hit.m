//
//  UIView+Hit.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/11/3.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "UIView+Hit.h"
#import <objc/runtime.h>

@implementation UIView (Hit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origMethod = class_getInstanceMethod(self.class, @selector(pointInside:withEvent:));
        Method swizMethod = class_getInstanceMethod(self.class, @selector(hit_pointInside:withEvent:));
        
        method_exchangeImplementations(origMethod, swizMethod);
    });
}

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:hitTestEdgeInsets];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    return value ? value.UIEdgeInsetsValue : UIEdgeInsetsZero;
}

-(BOOL)hit_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self hit_pointInside:point withEvent:event]) {
        return YES;
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

@end
