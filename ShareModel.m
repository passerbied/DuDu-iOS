//
//  ShareModel.m
//  DuDu
//
//  Created by i-chou on 1/21/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"weixin_pic"            : @"weixin_pic",
             @"weixin_title"          : @"weixin_title",
             @"weixin_link"           : @"weixin_link",
             @"wait_order_time"       : @"wait_order_time",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"ShareModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

- (double)wait_order_time_seconds
{
   return [self.wait_order_time floatValue] * 60;
}

@end
