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

- (instancetype)initWithObjc:(id)objc params:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.strategy = BuryingPointStrategySEL | BuryingPointStrategySuperPath;
        self.selectedPath = dict[@"BPCollectionCellIndexPath"];
        [self initSaveDeepViewObjc:objc];
    }
    return self;
}

@end
