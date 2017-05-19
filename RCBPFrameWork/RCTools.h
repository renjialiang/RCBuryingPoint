//
//  RCTools.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface RCTools : NSObject

+ (void)SwizzlingClass:(Class)cls originalSelector:(SEL)orSlt swizzleMethod:(SEL)swSlt;

void exChangeMethod(Class originalClass, SEL originalSEL, Class replacedClass, SEL replacedSEL);

@end
