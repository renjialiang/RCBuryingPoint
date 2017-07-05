//
//  RCBPBaseModel.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBPConfig.h"
#import "RCBPManager.h"

@interface RCBPBaseModel : NSObject

@property (nonatomic, assign) BuryingPointStrategy strategy;

@property (nonatomic, assign) NSUInteger deepSuperHeight;

@property (nonatomic, strong, readonly) NSMutableArray * _Nonnull deepViewArray;

//初始化Model
+ (nullable instancetype)initMaiDianWithType:(BuryPointType)type objcClass:(nonnull id)objc params:(NSDictionary * _Nullable )dic;

//创建model对象
- (nullable instancetype)initWithObjc:(nonnull id)objc params:(NSDictionary *_Nullable)dict;

//保存view对象
- (void)initSaveDeepViewObjc:(id _Nonnull )objc;

//搜索对应匹配的字符串
- (nullable NSString *)searchWithConfigFile:(nonnull id)objc sel:(nonnull SEL)action className:(nonnull NSString *)name;

@end
