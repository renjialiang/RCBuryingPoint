//
//  RCBPControlModel.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPControlModel.h"

@implementation RCBPControlModel

- (instancetype)initWithObjc:(id)objc params:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.strategy = BuryingPointStrategySEL | BuryingPointStrategySuperPath;
        [self initSaveDeepViewObjc:objc];
    }
    return self;
}

@end
