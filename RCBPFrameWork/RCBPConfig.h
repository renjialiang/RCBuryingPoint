//
//  RCBPConfig.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define bpSubKey @"subkey"
#define bpSubValue @"subvalue"
#define bpCellIndexPath @"cellindexPath"
#define bpCellCombine @"cellCombine"
#define bpText @"bPText"

typedef NS_OPTIONS(NSUInteger, BuryingPointStrategy)
{
    BuryingPointStrategyNone                                        = 0,
    BuryingPointStrategySEL                                         = 1 <<  0,
    BuryingPointStrategySuperPath                                   = 1 <<  1,
};

@interface RCBPConfig : NSObject

+ (instancetype _Nonnull )shareInstance;

@property (nonatomic, strong, readonly) NSMutableDictionary * _Nonnull mdConfigDict;

- (nonnull NSDictionary *)searchMaiDianSELStrategy;

- (nonnull NSArray *)searchMaiDianSUPERPATHStrategy:(nonnull NSString *)superPath;

@end
