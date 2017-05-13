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

+ (nullable instancetype)initMaiDianWithType:(BuryPointType)type params:(NSDictionary * _Nullable )dic;

@property (nonatomic, assign) BuryingPointStrategy strategy;

@property (nonatomic, assign) NSUInteger deepSuperHeight;

- (nullable NSString *)searchWithConfigFile:(nonnull id)objc sel:(nonnull SEL)action className:(nonnull NSString *)name;

- (nonnull NSString *)deepGetSuperView:(nonnull id)objc deepHeight:(NSUInteger)dHeight;

- (nullable NSString *)superPathStrategy:(nonnull NSArray *)array object:(nonnull id)objc deepH:(NSUInteger)height;

@end
