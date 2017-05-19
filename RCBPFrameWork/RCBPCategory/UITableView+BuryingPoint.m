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

- (void)tableViewBP:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[RCBPManager shareInstance] searchWithConfigFile:cell sel:@selector(tableViewBP:didSelectRowAtIndexPath:) className:[NSString stringWithUTF8String:class_getName([self class])] mdType:UITableViewABCS exParams:@{@"BPTableViewCellIndexPath":indexPath}];
    [self tableViewBP:tableView didSelectRowAtIndexPath:indexPath];
}

+ (void)enableHookUITableViewDelegateMethod:(Class)aClass {
    exChangeMethod(aClass, @selector(tableView:didSelectRowAtIndexPath:), [self class], @selector(tableViewBP:didSelectRowAtIndexPath:));
}

@end

@implementation UITableView (BuryingPoint)

+ (void)load
{
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"BPFunction"] boolValue])
    {
        Method originalMethod = class_getInstanceMethod([UITableView class], @selector(setDelegate:));
        Method replacedMethod = class_getInstanceMethod([UITableView class], @selector(setBPDelegate:));
        method_exchangeImplementations(originalMethod, replacedMethod);
    }
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
