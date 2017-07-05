//
//  RCBPTableModel.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/5/8.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPTableModel.h"

@interface RCBPTableModel ()

@property (nonatomic, strong) NSIndexPath *selectedPath;

@end

@implementation RCBPTableModel

- (instancetype)initWithObjc:(id)objc params:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.strategy = BuryingPointStrategySEL | BuryingPointStrategySuperPath;
        self.selectedPath = dict[@"BPTableViewCellIndexPath"];
        [self initSaveDeepViewObjc:objc];
    }
    return self;
}

- (BOOL)matchingCell:(NSDictionary *)dict
{
    NSArray *pathArray = [[dict objectForKey:bpCellIndexPath] componentsSeparatedByString:@"_"];
    NSIndexPath *path = [NSIndexPath indexPathForRow:[[pathArray lastObject] integerValue] inSection:[[pathArray firstObject] integerValue]];
    return  ([self.selectedPath compare:path] == NSOrderedSame) ? YES : NO;
}

- (BOOL)matchingComBineCell:(NSDictionary *)dict
{
    NSArray *pathArray = [[dict objectForKey:bpCellCombine] componentsSeparatedByString:@"_"];
    NSIndexPath *path = [NSIndexPath indexPathForRow:[[pathArray lastObject] integerValue] inSection:[[pathArray firstObject] integerValue]];
    return  ([self.selectedPath compare:path] == NSOrderedSame) ? YES : NO;
}

@end
