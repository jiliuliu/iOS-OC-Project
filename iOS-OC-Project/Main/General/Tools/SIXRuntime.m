//
//  SIXRuntime.m
//  Rumtime_NSObject
//
//  Created by liujiliu on 16/8/26.
//  Copyright © 2016年 yingu. All rights reserved.
//

#import "SIXRuntime.h"
#import <objc/runtime.h>

@implementation SIXRuntime

/** 获取实例变量列表 */
+ (NSArray<NSString *> *)six_instanceVarList:(Class)cls {
    u_int               count;
    Ivar*    ivars = class_copyIvarList(cls, &count);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* ivarName = ivar_getName(ivars[i]);
        NSString *strName = [NSString  stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        [arr addObject:strName];
    }
    return arr.copy;
}

/** 获取属性列表 */
+ (NSArray<NSString *> *)six_propertyList:(Class)cls {
    u_int               count;
    objc_property_t*    properties= class_copyPropertyList(cls, &count);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        NSString *strName = [NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        [arr addObject:strName];
    }
    return arr.copy;
}

/** 获取实例方法列表 */
+ (NSArray<NSString *> *)six_intanceMethodList:(Class)cls {
    u_int               count;
    Method*    methods= class_copyMethodList(cls, &count);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL sel = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];
        [arr addObject:strName];
    }
    return arr.copy;
}

/** 获取实例方法列表 */
+ (NSArray<NSString *> *)six_classMethodList:(Class)cls {
    u_int               count;
    Class meta_cls =object_getClass(cls);
    Method*    methods= class_copyMethodList(meta_cls, &count);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL sel = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];
        [arr addObject:strName];
    }
    return arr.copy;
}

/** 替换实例方法实现 */
+ (void)six_swizzleMethods:(Class)cla originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    Method origMethod = class_getInstanceMethod(cla, origSel);
    Method swizMethod = class_getInstanceMethod(cla, swizSel);
    
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(cla, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(cla, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

/** 替换类方法实现 */
+ (void)six_swizzleClassMethods:(Class)cla originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    [self six_swizzleMethods:object_getClass(cla) originalSelector:origSel swizzledSelector:swizSel];
}


@end

