//
//  adModel.m
//  DuDu
//
//  Created by i-chou on 1/22/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "adModel.h"

@implementation adModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"advertisement_id"            : @"advertisement_id",
             @"advertisement_name"          : @"advertisement_name",
             @"advertisement_url"           : @"advertisement_url",
             @"advertisement_status"        : @"advertisement_status",
             @"advertisement_add_time"      : @"advertisement_add_time",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"adModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
