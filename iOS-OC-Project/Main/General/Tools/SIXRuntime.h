//
//  SIXRuntime.h
//  Rumtime_NSObject
//
//  Created by liujiliu on 16/8/26.
//  Copyright © 2016年 yingu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXRuntime : NSObject

/** 获取实例变量列表 */
+ (NSArray<NSString *> *)six_instanceVarList:(Class)cls;

/** 获取属性列表 */
+ (NSArray<NSString *> *)six_propertyList:(Class)cls;

/** 获取实例方法列表 */
+ (NSArray<NSString *> *)six_intanceMethodList:(Class)cls;

/** 获取类方法列表 */
+ (NSArray<NSString *> *)six_classMethodList:(Class)cls;



/** 替换实例方法实现 */
+ (void)six_swizzleMethods:(Class)cla originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;

/** 替换类方法实现 */
+ (void)six_swizzleClassMethods:(Class)cla originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;

/** 获取类中指定名称实例成员变量的信息   Ivar class_getInstanceVariable ( Class cls, const char *name ) */
/** 获取指定的属性  objc_property_t class_getProperty ( Class cls, const char *name ); */


@end
