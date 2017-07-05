//
//  RCBPManager.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBPConfig.h"

@class RCBPManager;
@protocol RCBPManagerDelegate <NSObject>
@optional
- (void)maiDianManager:(RCBPManager *_Nonnull)mgr shouldPostMaiDian:(NSString *_Nullable)str;
@end

@interface RCBPManager : NSObject

+ (nonnull instancetype)shareInstance;

- (void)searchWithConfigFile:(nonnull id)objc sel:(nonnull SEL)action className:(nonnull NSString *)name mdType:(BuryPointType)type exParams:(nullable NSDictionary *)dict;

- (void)setConfigFile:(NSString *_Nonnull)file;

@property (nonatomic, weak) _Nullable id<RCBPManagerDelegate> delegate;

@end
