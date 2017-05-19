//
//  UIControl+BuryingPoint.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "UIControl+BuryingPoint.h"
#import "RCBPManager.h"
#import <objc/runtime.h>
#import "RCTools.h"

@implementation UIControl (BuryingPoint)

+ (void)load
{
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"BPFunction"] boolValue])
    {
        [RCTools SwizzlingClass:[self class] originalSelector:@selector(sendAction:to:forEvent:) swizzleMethod:@selector(sendActionMD:to:forEvent:)];
    }
}

- (void)sendActionMD:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [[RCBPManager shareInstance] searchWithConfigFile:self sel:action className:[NSString stringWithUTF8String:class_getName([target class])] mdType:UIControlABCS exParams:nil];
    [self sendActionMD:action to:target forEvent:event];
}

@end
