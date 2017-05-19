//
//  RCBPCollecionModel.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/5/19.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPCollecionModel.h"

@interface RCBPCollecionModel ()

@property (nonatomic, strong) NSIndexPath *selectedPath;

@end

@implementation RCBPCollecionModel

- (instancetype)initWithParams:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.strategy = BuryingPointStrategySEL | BuryingPointStrategySuperPath;
        self.deepSuperHeight = 5;
        self.selectedPath = dict[@"BPCollectionCellIndexPath"];
    }
    return self;
}

- (NSIndexPath *)getSpecialModel
{
    return self.selectedPath;
}

@end
