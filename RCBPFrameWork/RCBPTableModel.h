//
//  RCBPTableModel.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/5/8.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPBaseModel.h"

@interface RCBPTableModel : RCBPBaseModel

- (instancetype)initWithParams:(NSDictionary *)dict;

@property (nonatomic, strong, readonly) NSIndexPath *selectedPath;


@end
