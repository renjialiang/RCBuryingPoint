//
//  RCBPBaseModel.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPBaseModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "RCBPViewModel.h"
#import "RCBPControlModel.h"
#import "RCBPTableModel.h"
#import "RCBPCollecionModel.h"

@interface RCBPBaseModel ()

@property (nonatomic, strong) NSMutableArray *deepViewArray;

@end

@implementation RCBPBaseModel

delay_property_impl(NSMutableArray, deepViewArray)

+ (instancetype)initMaiDianWithType:(BuryPointType)type objcClass:(id)objc params:(NSDictionary *)dic
{
    RCBPBaseModel *strategyBase = nil;
    switch (type) {
        case UIViewABCS:
            strategyBase = [[RCBPViewModel alloc]initWithObjc:objc params:dic];
            break;
        case UIControlABCS:
            strategyBase = [[RCBPControlModel alloc]initWithObjc:objc params:dic];
            break;
        case UITableViewABCS:
            strategyBase = [[RCBPTableModel alloc]initWithObjc:objc params:dic];
            break;
        case UICollectionViewABCS:
            strategyBase = [[RCBPCollecionModel alloc]initWithObjc:objc params:dic];
            break;
        default:
            break;
    }
    return strategyBase;
}


- (nullable instancetype)initWithObjc:(nonnull id)objc params:(NSDictionary *_Nullable)dict;
{
    // subClass Impl
    return nil;
}

- (void)initSaveDeepViewObjc:(id)objc
{
    [self.deepViewArray removeAllObjects];
    NSUInteger deep = 1;
    UIView *superView = objc;
    [self.deepViewArray addObject:superView];
    while (deep < 100)
    {
        if (superView.superview)
        {
            if ([[RCBPConfig shareInstance] isConfigTopSuper:NSStringFromClass([superView.superview class])])
            {
                break;
            }
            [self.deepViewArray addObject:superView.superview];
        }
        superView = superView.superview;
        deep++;
    }
    self.deepSuperHeight = deep;
}

- (NSString *)searchWithConfigFile:(id)objc sel:(SEL)action className:(NSString *)name
{
    NSString *returnText = nil;
    if (self.strategy & BuryingPointStrategySEL) {
        NSString *spliceStr = [name stringByAppendingString:[NSString stringWithFormat:@"_%@",NSStringFromSelector(action)]];
        NSDictionary *dict = [[RCBPConfig shareInstance] searchMaiDianSELStrategy];
        if ([dict objectForKey:spliceStr]) {
            returnText = [dict objectForKey:spliceStr];
        }
    }
    if (self.strategy & BuryingPointStrategySuperPath) {
        NSString *superPathText = nil;
        NSArray *array = [[RCBPConfig shareInstance] searchMaiDianSUPERPATHStrategy:[self deepGetSuperView]];
        if (array.count > 0) {
            superPathText = [self superPathStrategy:array object:objc deepH:self.deepSuperHeight];
            if (superPathText) {
                returnText = superPathText;
            }
        }
    }
    [self.deepViewArray removeAllObjects];
    return returnText;
}

#pragma mark Private-Method
//获取SuperView字符串
- (NSString *)deepGetSuperView
{
    NSString *superViewAllText = nil;
    if (self.deepViewArray && self.deepViewArray.count > 0)
    {
        superViewAllText = [NSString stringWithUTF8String:class_getName([[self.deepViewArray firstObject] class])];
        for (NSUInteger i = 1; i < self.deepViewArray.count; i++)
        {
            superViewAllText = [[NSString stringWithUTF8String:class_getName([[self.deepViewArray objectAtIndex:i] class])] stringByAppendingString:[NSString stringWithFormat:@"_%@",superViewAllText]];
        }
    }
    return superViewAllText;
}

//匹配路径对应的配置文本
- (NSString *)superPathStrategy:(NSArray *)array object:(id)objc deepH:(NSUInteger)height;
{
    NSString *returnText = nil;
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *subDict = [array objectAtIndex:i];
        BOOL matchFlag = NO;
        for (int j = 1; j < height; j++)
        {
            NSDictionary *subSubDict = [subDict objectForKey:[NSString stringWithFormat:@"%d",j]];
            if (subSubDict) {
                id superObjc = [self getSuperViewFormSuperDeep:j - 1];
                matchFlag = [self justObjcHaveMaiDian:superObjc keyValueDict:subSubDict];
                if (!matchFlag) {
                    break;
                }
            }
        }
        if (matchFlag) {
            returnText = [subDict objectForKey:bpText];
            break;
        }
    }
    return returnText;
}

//获取路径对应的对象
- (id)getSuperViewFormSuperDeep:(NSUInteger)deep
{
    if (self.deepViewArray.count > deep)
    {
        return [self.deepViewArray objectAtIndex:deep];
    }
    return nil;
}

//通过配置信息查找
- (BOOL)justObjcHaveMaiDian:(id)objc keyValueDict:(NSDictionary *)dict
{
    BOOL isMD = NO;
    if ([dict objectForKey:bpCellIndexPath])
    {
        if ([self isKindOfClass:[RCBPTableModel class]])
        {
            isMD = [((RCBPTableModel*)self) matchingCell:dict];
        }
    }
    NSString *key = [dict objectForKey:bpSubKey];
    if (key.length > 0) {
        @try
        {
            id value = [objc valueForKeyPath:key];
            if ([value isKindOfClass:[NSNumber class]])
            {
                value = [value stringValue];
            }
            if ([[dict objectForKey:bpSubValue] isEqualToString:value])
            {
                if ([dict objectForKey:bpCellCombine])
                {
                    if ([self isKindOfClass:[RCBPTableModel class]])
                    {
                        isMD = [((RCBPTableModel*)self) matchingComBineCell:dict];
                    }
                }
                else
                {
                    isMD = YES;
                }
            }
        }
        @catch (NSException *exception) {
            //TODO:
        }
        @finally {
            //TODO:
        }
    }
    return isMD;
}

@end
