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

@end
