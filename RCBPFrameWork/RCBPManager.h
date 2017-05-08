//
//  RCBPManager.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BuryPointType) {
    UIControlMaiDian = 1,
    UIViewMaiDian = 2,
    UITableViewMaiDian = 3
};

@interface RCBPManager : NSObject

+ (nonnull instancetype)shareInstance;

- (void)searchWithConfigFile:(nonnull id)objc sel:(nonnull SEL)action className:(nonnull NSString *)name mdType:(BuryPointType)type exParams:(nullable NSDictionary *)dict;


@end
