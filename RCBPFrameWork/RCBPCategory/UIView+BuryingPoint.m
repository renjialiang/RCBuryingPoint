//
//  UIView+BuryingPoint.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "UIView+BuryingPoint.h"
#import "RCBPManager.h"
#import <objc/runtime.h>
#import "RCTools.h"

static void *weakGesture = &weakGesture;

@interface GestureItem : NSObject

@property (nonatomic, weak) id target;

@property (nonatomic) SEL action;

@property (nonatomic, weak) UIView *viewObject;

@end

@implementation GestureItem

- (void)mdGestureItem:(UIGestureRecognizer *)gesture
{
    [[RCBPManager shareInstance] searchWithConfigFile:self.viewObject sel:self.action className:[NSString stringWithUTF8String:class_getName([self.target class])] mdType:UIViewABCS exParams:nil];
    [self.target performSelector:self.action withObject:gesture];
}

@end

@implementation UIView (BuryingPoint)

+ (void)load
{
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"BPFunction"] boolValue])
    {
        [RCTools SwizzlingClass:[self class] originalSelector:@selector(addGestureRecognizer:) swizzleMethod:@selector(addBPGestureRecognizer:)];
    }
}

- (void)addBPGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    Ivar targetsIvar = class_getInstanceVariable([UIGestureRecognizer class], "_targets");
    id targetActionPairs = object_getIvar(gestureRecognizer, targetsIvar);
    Class targetAcitonPairClass = NSClassFromString(@"UIGestureRecognizerTarget");
    Ivar targetIvar = class_getInstanceVariable(targetAcitonPairClass, "_target");
    Ivar actionIvar = class_getInstanceVariable(targetAcitonPairClass, "_action");
    BOOL saveGestureFlag = YES;
    if ([gestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")])
    {
        saveGestureFlag = NO;
    }
    if (saveGestureFlag) {
        for (id targetActionPair in targetActionPairs)
        {
            id tTarget= object_getIvar(targetActionPair, targetIvar);
            NSBundle *minv = [NSBundle bundleForClass:[tTarget class]];
            //FrameWork的还需要单独判断
            if (minv == [NSBundle mainBundle]) {
                GestureItem *item = [GestureItem new];
                item.target = tTarget;
                item.action = (__bridge void *)object_getIvar(targetActionPair, actionIvar);
                item.viewObject = self;
                object_setIvar(targetActionPair, targetIvar, item);
                object_setIvar(targetActionPair, actionIvar, (__bridge id)(void *)(@selector(mdGestureItem:)));
                objc_setAssociatedObject(self, weakGesture, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    }
    [self addBPGestureRecognizer:gestureRecognizer];
}

@end
