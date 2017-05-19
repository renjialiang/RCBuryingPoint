//
//  UICollectionView+BuryingPoint.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/5/19.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "UICollectionView+BuryingPoint.h"
#import "RCTools.h"
#import "RCBPManager.h"

@interface BPUICollectionViewDelegateHook : NSObject <UICollectionViewDelegate>

@end

@implementation BPUICollectionViewDelegateHook

- (void)collectionViewBP:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [[RCBPManager shareInstance] searchWithConfigFile:cell sel:@selector(collectionViewBP:didSelectItemAtIndexPath:) className:[NSString stringWithUTF8String:class_getName([self class])] mdType:UICollectionViewABCS exParams:@{@"BPCollectionCellIndexPath":indexPath}];
    [self collectionViewBP:collectionView didSelectItemAtIndexPath:indexPath];
}

+ (void)enableHookUITableViewDelegateMethod:(Class)aClass {
    exChangeMethod(aClass, @selector(collectionView:didSelectItemAtIndexPath:), [self class], @selector(collectionViewBP:didSelectItemAtIndexPath:));
}

@end

@implementation UICollectionView (BuryingPoint)
+ (void)load
{
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"BPFunction"] boolValue])
    {
        Method originalMethod = class_getInstanceMethod([UICollectionView class], @selector(setDelegate:));
        Method replacedMethod = class_getInstanceMethod([UICollectionView class], @selector(setBPDelegate:));
        method_exchangeImplementations(originalMethod, replacedMethod);
    }
}

- (void)setBPDelegate:(id<UICollectionViewDelegate>)delegate
{
    [self setBPDelegate:delegate];
    if (delegate) {
        NSBundle *mBundle = [NSBundle bundleForClass:[self.delegate class]];
        if (mBundle == [NSBundle mainBundle]) {
            [BPUICollectionViewDelegateHook enableHookUITableViewDelegateMethod:[self.delegate class]];
        }
    }
}
@end
