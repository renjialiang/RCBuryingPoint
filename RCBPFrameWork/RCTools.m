//
//  RCTools.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCTools.h"

@implementation RCTools

+ (void)SwizzlingClass:(Class)cls originalSelector:(SEL)orSlt swizzleMethod:(SEL)swSlt
{
    Method originalMethod = class_getInstanceMethod(cls, orSlt);
    Method swizzledMethod = class_getInstanceMethod(cls, swSlt);
    BOOL didAddMethod = class_addMethod(cls,
                                        orSlt,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swSlt,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


void exChangeMethod(Class originalClass, SEL originalSEL, Class replacedClass, SEL replacedSEL)
{
    static NSMutableArray *classList = nil;
    if (classList == nil) {
        classList = [[NSMutableArray alloc]init];
    }
    NSString *className = [NSString stringWithFormat:@"%@__%@", NSStringFromClass(originalClass), NSStringFromSelector(replacedSEL)];
    for (NSString *item in classList)
    {
        if ([className isEqualToString:item]) {
            return;
        }
    }
    [classList addObject:className];
    Method originalMethod = class_getInstanceMethod(originalClass, originalSEL);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSEL);
    IMP originalMethodIMP = method_getImplementation(originalMethod);
    if (!class_addMethod(originalClass, originalSEL, originalMethodIMP, method_getTypeEncoding(replacedMethod))) {
        //添加方法不成功
    }
    originalMethod = class_getInstanceMethod(originalClass, originalSEL);
    IMP replacedMethodIMP = method_getImplementation(replacedMethod);
    if (!class_addMethod(originalClass, replacedSEL, replacedMethodIMP, method_getTypeEncoding(replacedMethod))) {
        //添加方法不成功
    }
    Method newMethod = class_getInstanceMethod(originalClass, replacedSEL);
    method_exchangeImplementations(originalMethod, newMethod);
}

@end
