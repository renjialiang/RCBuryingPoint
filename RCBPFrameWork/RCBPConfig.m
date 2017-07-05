//
//  RCBPConfig.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPConfig.h"

@interface RCBPConfig ()

@property (nonatomic, strong) NSMutableDictionary *mdConfigDict;

@property (nonatomic, strong) NSMutableArray *mdDeepTopClassArray;

@end

@implementation RCBPConfig

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static RCBPConfig *manager;
    dispatch_once(&once, ^{
        manager = [[RCBPConfig alloc]init];
    });
    return manager;
}

- (NSMutableDictionary *)mdConfigDict{
    if (!_mdConfigDict) {
        _mdConfigDict = [self paserJsonConfig];
    }
    return _mdConfigDict;
}

- (NSMutableArray *)mdDeepTopClassArray
{
    if (_mdDeepTopClassArray == nil) {
        _mdDeepTopClassArray = [[NSMutableArray alloc]initWithArray:[self getSuperTopClassArray]];
    }
    return _mdDeepTopClassArray;
}

- (nonnull NSMutableDictionary *)paserJsonConfig
{
    NSError *jsonError = nil;
    NSData *maiDianData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.configFile ofType:nil]];
    if (maiDianData)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:maiDianData options:NSJSONReadingAllowFragments error:&jsonError];
        if (!jsonError)
        {
            return [[NSMutableDictionary alloc]initWithDictionary:dict];
        }
    }
    return [NSMutableDictionary dictionary];
}

- (NSDictionary *)searchMaiDianSELStrategy
{
    return [self.mdConfigDict objectForKey:@"SEL"];
}

- (NSArray *)searchMaiDianSUPERPATHStrategy:(NSString *)superPath
{
    NSArray *superArray = [NSArray array];
    NSDictionary *dicSuper = [self.mdConfigDict objectForKey:@"SUPERPATH"];
    if ([dicSuper objectForKey:superPath]) {
        superArray = [dicSuper objectForKey:superPath];
    }
    return superArray;
}

- (NSArray *)getSuperTopClassArray
{
    if ([self.mdConfigDict objectForKey:@"TOPDEEP"]) {
        NSString *topDeep = [self.mdConfigDict objectForKey:@"TOPDEEP"];
        if (topDeep.length > 0) {
            return [topDeep componentsSeparatedByString:@","];
        }
    }
    return @[];
}

- (BOOL)isConfigTopSuper:(NSString *)cls
{
    BOOL flag = NO;
    for (NSString *str in self.mdDeepTopClassArray)
    {
        if ([str isEqualToString:cls])
        {
            flag = YES;
            break;
        }
    }
    return flag;
}

@end
