//
//  RCBPManager.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPManager.h"
#import "RCBPBaseModel.h"

@implementation RCBPManager

impl_single_instance(RCBPManager)

- (void)setConfigFile:(NSString *)file
{
    [RCBPConfig shareInstance].configFile = file;
}

- (void)searchWithConfigFile:(id)objc sel:(SEL)action className:(NSString *)name mdType:(BuryPointType)type exParams:(NSDictionary *)dict
{
    RCBPBaseModel *model = [RCBPBaseModel initMaiDianWithType:type objcClass:objc params:dict];
    if (model) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSString* text = [model searchWithConfigFile:objc sel:action className:name];
            if (text) {
                if ([weakSelf.delegate respondsToSelector:@selector(maiDianManager:shouldPostMaiDian:)]) {
                    [weakSelf.delegate maiDianManager:weakSelf shouldPostMaiDian:text];
                }
            }
        });
    }
}

@end
