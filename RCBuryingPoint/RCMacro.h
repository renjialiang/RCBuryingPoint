//
//  RCMacro.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/7/5.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#ifndef RCMacro_h
#define RCMacro_h

#define delay_property_impl(type, name) \
- (type *)name                          \
{                                       \
    if (nil == _##name)                 \
{                                       \
    _##name = [type new];               \
}                                       \
    return _##name;                     \
}

#define decl_single_instance(className)                         \
+ (instancetype)shareInstance;

#define impl_single_instance(className)                         \
static className* className##_single = nil;                     \
+ (instancetype)shareInstance                                   \
{                                                               \
    static dispatch_once_t className##_onceToken;               \
    dispatch_once(&className##_onceToken, ^{                    \
    if (!className##_single) {                                  \
            className##_single = [[self alloc] init];           \
        }                                                       \
    } );                                                        \
    return className##_single;                                  \
}
#endif /* RCMacro_h */

