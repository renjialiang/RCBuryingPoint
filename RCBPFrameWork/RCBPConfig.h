//
//  RCBPConfig.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define bpSubKey @"subkey"                  //KVC区分 设定的key
#define bpSubValue @"subvalue"              //KVC区分 设定的value
#define bpText @"bPText"                    //配置对应事件的文本key
#define bpCellIndexPath @"cellindexPath"    //cell通过indexpath区分
#define bpCellCombine @"cellCombine"        //cell通过indexpath区分同时使用kvc区分
#define bpSEL @"SEL"                        //selector事件类型配置key
#define bpSUPERPATH @"SUPERPATH"            //路径类型配置key
#define bpTOPLevel @"TOPDEEP"               //路径类型最深遍历Class


typedef NS_ENUM(NSUInteger, BuryPointType) {
    UIControlABCS = 1,
    UIViewABCS = 2,
    UITableViewABCS = 3,
    UICollectionViewABCS = 4
};

typedef NS_OPTIONS(NSUInteger, BuryingPointStrategy)
{
    BuryingPointStrategyNone                                        = 0,
    BuryingPointStrategySEL                                         = 1 <<  0,
    BuryingPointStrategySuperPath                                   = 1 <<  1,
};

@interface RCBPConfig : NSObject

+ (instancetype _Nonnull )shareInstance;

@property (nonatomic, copy) NSString * _Nonnull configFile;

- (nonnull NSDictionary *)searchMaiDianSELStrategy;

- (nonnull NSArray *)searchMaiDianSUPERPATHStrategy:(nonnull NSString *)superPath;

- (BOOL)isConfigTopSuper:(NSString *_Nonnull)cls;

@end
