//
//  OrderHistoryModel.m
//  DuDu
//
//  Created by i-chou on 1/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "OrderHistoryModel.h"

@implementation OrderHistoryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"user_id"         : @"user_id",
             @"start_lat"       : @"start_lat",
             @"start_lng"       : @"start_lng",
             @"star_loc_str"    : @"star_loc_str",
             @"dest_lat"        : @"dest_lat",
             @"dest_lng"        : @"dest_lng",
             @"dest_loc_str"    : @"dest_loc_str",
             @"car_style"       : @"car_style",
             @"startTimeType"   : @"startTimeType",
             @"startTimeStr"    : @"startTimeStr",
             @"coupon_id"       : @"coupon_id",
             @"order_time"      : @"order_time",
             @"order_id"        : @"order_id",
             @"order_initiate_rate"  : @"order_initiate_rate",
             @"order_mileage"        : @"order_mileage",
             @"order_mileage_money"  : @"order_mileage_money",
             @"order_duration_money" : @"order_duration_money",
             @"order_allMoney"       : @"order_allMoney",
             @"order_allTime"        : @"order_allTime",
             @"order_status"         : @"order_status",
             @"driver_status"        : @"driver_status",
             @"order_payStatus"      : @"order_payStatus",
             @"isbook"               : @"isbook",
             @"coupon_title"         : @"coupon_title",
             @"coupon_discount"      : @"coupon_discount",
             @"relevance_id"         : @"relevance_id",
             @"evaluate_level"       : @"evaluate_level",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"OrderHistoryModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
