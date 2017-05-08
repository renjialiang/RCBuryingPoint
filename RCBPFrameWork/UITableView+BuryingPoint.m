//
//  UITableView+BuryingPoint.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "UITableView+BuryingPoint.h"
#import "RCTools.h"
#import "RCBPManager.h"

@interface BPUITableViewDelegateHook : NSObject <UITableViewDelegate>

@end

@implementation BPUITableViewDelegateHook

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
    IMP replacedMethodIMP = method_getImplementation(replacedMethod);
    if (!class_addMethod(originalClass, replacedSEL, replacedMethodIMP, method_getTypeEncoding(replacedMethod))) {
    }
    Method newMethod = class_getInstanceMethod(originalClass, replacedSEL);
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)tableViewBP:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[RCBPManager shareInstance] searchWithConfigFile:cell sel:@selector(tableViewBP:didSelectRowAtIndexPath:) className:[NSString stringWithUTF8String:class_getName([self class])] mdType:UITableViewMaiDian exParams:@{@"BPTableViewCellIndexPath":indexPath}];
    [self tableViewBP:tableView didSelectRowAtIndexPath:indexPath];
}

+ (void)enableHookUITableViewDelegateMethod:(Class)aClass {
    exChangeMethod(aClass, @selector(tableView:didSelectRowAtIndexPath:), [self class], @selector(tableViewBP:didSelectRowAtIndexPath:));
}

@end

@implementation UITableView (BuryingPoint)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod([UITableView class], @selector(setDelegate:));
    Method replacedMethod = class_getInstanceMethod([UITableView class], @selector(setBPDelegate:));
    method_exchangeImplementations(originalMethod, replacedMethod);
}

- (void)setBPDelegate:(id<UITableViewDelegate>)delegate
{
    [self setBPDelegate:delegate];
    if (delegate) {
        NSBundle *mBundle = [NSBundle bundleForClass:[self.delegate class]];
        if (mBundle == [NSBundle mainBundle]) {
            [BPUITableViewDelegateHook enableHookUITableViewDelegateMethod:[self.delegate class]];
        }
    }
}
@end
