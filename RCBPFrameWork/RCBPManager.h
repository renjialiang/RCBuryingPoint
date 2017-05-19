//
//  RCBPManager.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BuryPointType) {
    UIControlABCS = 1,
    UIViewABCS = 2,
    UITableViewABCS = 3,
    UICollectionViewABCS = 4
};

@interface RCBPManager : NSObject

+ (nonnull instancetype)shareInstance;

- (void)searchWithConfigFile:(nonnull id)objc sel:(nonnull SEL)action className:(nonnull NSString *)name mdType:(BuryPointType)type exParams:(nullable NSDictionary *)dict;


@end
