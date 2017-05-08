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

@end

@implementation RCBPConfig

+(instancetype)shareInstance
{
    static dispatch_once_t once;
    static RCBPConfig *manager;
    dispatch_once(&once, ^{
        manager = [[RCBPConfig alloc]init];
        manager.mdConfigDict = [manager paserJsonConfig];
    });
    return manager;
}

- (nonnull NSMutableDictionary *)paserJsonConfig
{
    NSError *jsonError = nil;
    NSData *maiDianData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailPointText" ofType:@"json"]];
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


@end
