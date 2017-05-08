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

- (instancetype)initWithParams:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.strategy = BuryingPointStrategySEL | BuryingPointStrategySuperPath;
        self.deepSuperHeight = 5;
        self.selectedPath = dict[@"BPTableViewCellIndexPath"];
    }
    return self;
}

@end
