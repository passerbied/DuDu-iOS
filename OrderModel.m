//
//  OrderModel.m
//  DuDu
//
//  Created by i-chou on 12/28/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"user_id"         : @"user_id",
             @"start_lat"       : @"start_lat",
             @"start_lng"       : @"start_lng",
             @"start_loc_str"    : @"star_loc_str",
             @"dest_lat"        : @"dest_lat",
             @"dest_lng"        : @"dest_lng",
             @"dest_loc_str"    : @"dest_loc_str",
             @"car_style"       : @"car_style",
             @"startTimeType"   : @"startTimeType",
             @"startTimeStr"    : @"startTimeStr",
             @"coupon_id"       : @"coupon_id",
             @"order_time"      : @"order_time",
             @"order_id"        : @"order_id",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"UserModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
