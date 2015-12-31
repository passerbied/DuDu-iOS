//
//  CouponModel.m
//  DuDu
//
//  Created by i-chou on 12/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userRef_id"            : @"userRef_id",
             @"coupon_id"             : @"coupon_id",
             @"user_id"               : @"user_id",
             @"coupon_get_datetime"   : @"coupon_get_datetime",
             @"coupon_isUsed"         : @"coupon_isUsed",
             @"coupon_discount"       : @"coupon_discount",
             @"coupon_title"          : @"coupon_title",
             @"coupon_exp_day"        : @"coupon_exp_day",
             @"coupon_user_start_time" : @"coupon_user_start_time",
             @"coupon_user_end_time"   : @"coupon_user_end_time",
             @"coupon_max_monny"       : @"coupon_max_monny",
             @"coupon_isShare"         : @"coupon_isShare",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"CouponModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

@end
