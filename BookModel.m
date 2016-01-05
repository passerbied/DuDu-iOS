//
//  BookModel.m
//  DuDu
//
//  Created by i-chou on 1/6/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"order_id"            : @"order_id",
             @"user_id"             : @"user_id",
             @"relevance_id"        : @"relevance_id",
             @"start_lat"           : @"start_lat",
             @"start_lat"           : @"start_lat",
             @"start_lng"           : @"start_lng",
             @"star_loc_str"        : @"star_loc_str",
             @"dest_lat"            : @"dest_lat",
             @"dest_lng"            : @"dest_lng",
             @"dest_loc_str"        : @"dest_loc_str",
             @"car_style"           : @"car_style",
             @"startTimeType"       : @"startTimeType",
             @"startTimeStr"        : @"startTimeStr",
             @"order_initiate_rate" : @"order_initiate_rate",
             @"order_mileage"       : @"order_mileage",
             @"order_mileage_money" : @"order_mileage_money",
             @"order_duration_money": @"order_duration_money",
             @"order_allMoney"      : @"order_allMoney",
             @"order_allTime"       : @"order_allTime",
             @"order_status"        : @"order_status",
             @"driver_status"       : @"driver_status",
             @"coupon_id"           : @"coupon_id",
             @"order_time"          : @"order_time",
             @"order_payStatus"     : @"order_payStatus",
             @"isbook"              : @"isbook",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"CouponModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
