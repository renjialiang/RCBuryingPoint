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

@implementation RCBPBaseModel

+ (instancetype)initMaiDianWithType:(BuryPointType)type params:(NSDictionary *)dic
{
    RCBPBaseModel *strategyBase = nil;
    switch (type) {
        case UIControlMaiDian:
            strategyBase = [[RCBPViewModel alloc]init];
            break;
        case UIViewMaiDian:
            strategyBase = [[RCBPControlModel alloc]init];
            break;
        case UITableViewMaiDian:
            strategyBase = [[RCBPTableModel alloc]initWithParams:dic];
            break;
        default:
            break;
    }
    return strategyBase;
}

- (NSString *)searchWithConfigFile:(id)objc sel:(SEL)action className:(NSString *)name
{
    NSString *returnText = nil;
    if (self.strategy & BuryingPointStrategySEL) {
        NSString *spliceStr = [name stringByAppendingString:[NSString stringWithFormat:@"_%@",NSStringFromSelector(action)]];
        NSDictionary *dict = [[RCBPConfig shareInstance] searchMaiDianSELStrategy];
        if ([dict objectForKey:spliceStr]) {
            return [dict objectForKey:spliceStr];
        }
    }
    if (self.strategy & BuryingPointStrategySuperPath) {
        NSString *superPathText = nil;
        NSArray *array = [[RCBPConfig shareInstance] searchMaiDianSUPERPATHStrategy:[self deepGetSuperView:objc deepHeight:self.deepSuperHeight]];
        if (array.count > 0) {
            superPathText = [self superPathStrategy:array object:objc deepH:self.deepSuperHeight];
            if (superPathText) {
                return superPathText;
            }
        }
    }
    return returnText;
}

- (NSString *)deepGetSuperView:(id)objc deepHeight:(NSUInteger)dHeight
{
    NSUInteger deep = 1;
    NSString *superViewAllText = [NSString stringWithUTF8String:class_getName([objc class])];
    UIView *superView = objc;
    while (deep < dHeight)
    {
        if (superView.superview) {
            superViewAllText = [[NSString stringWithUTF8String:class_getName([superView.superview class])] stringByAppendingString:[NSString stringWithFormat:@"_%@",superViewAllText]];
        }
        superView = superView.superview;
        deep++;
    }
    return superViewAllText;
}

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
                id superObjc = [self getSuperViewFormObjc:objc superDeep:j];
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


- (id)getSuperViewFormObjc:(id)objc superDeep:(NSUInteger)deep
{
    UIView *view = objc;
    for (int i = 1; i < deep; i++)
    {
        view = view.superview;
    }
    return view;
}

- (BOOL)justObjcHaveMaiDian:(id)objc keyValueDict:(NSDictionary *)dict
{
    BOOL isMD = NO;
    if ([dict objectForKey:bpCellIndexPath])
    {
        isMD = ([((RCBPTableModel *)self).selectedPath compare:[self getFromConfigUserData:[dict objectForKey:bpCellIndexPath]]] == NSOrderedSame) ? YES : NO;
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
                    isMD = ([((RCBPTableModel *)self).selectedPath compare:[self getFromConfigUserData:[dict objectForKey:bpCellCombine]]] == NSOrderedSame) ? YES : NO;
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

- (NSIndexPath *)getFromConfigUserData:(NSString *)indexPathStr
{
    NSArray *pathStringArray = [indexPathStr componentsSeparatedByString:@"_"];
    NSIndexPath *path = [NSIndexPath indexPathForRow:[[pathStringArray lastObject] integerValue] inSection:[[pathStringArray firstObject] integerValue]];
    return path;
}

@end
