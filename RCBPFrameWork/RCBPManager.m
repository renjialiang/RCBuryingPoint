//
//  RCBPManager.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "RCBPManager.h"
#import "RCBPBaseModel.h"

@interface RCBPManager ()

@property (nonatomic, strong) NSMutableArray *textArray;

@end

@implementation RCBPManager

+(instancetype)shareInstance
{
    static dispatch_once_t once;
    static RCBPManager *manager;
    dispatch_once(&once, ^{
        manager = [[RCBPManager alloc]init];
    });
    return manager;
}

- (NSMutableArray *)textArray
{
    if (_textArray == nil) {
        _textArray = [[NSMutableArray alloc]init];
    }
    return _textArray;
}

- (void)searchWithConfigFile:(id)objc sel:(SEL)action className:(NSString *)name mdType:(BuryPointType)type exParams:(NSDictionary *)dict
{
    RCBPBaseModel *model = [RCBPBaseModel initMaiDianWithType:type params:dict];
    if (model) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSString* text = [model searchWithConfigFile:objc sel:action className:name];
            if (text) {
                [weakSelf.textArray addObject:text];
            }
        });
    }
}

@end
