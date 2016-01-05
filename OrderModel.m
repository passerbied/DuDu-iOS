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
             @"relevance_id"         :@"relevance_id",
             @"evaluate_level"       :@"evaluate_level",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"OrderModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}

//order_status:
//0.等待派单   2.司机前往 3. 开始乘车, 4到达目的地等待付款 ,5 订单完成, 6.乘客取消订单, 7司机取消订单
- (NSString *)order_status_str
{
    switch ([_order_status intValue]) {
        case 0:
            return @"等待派单";
            break;
        case 2:
            return @"司机前往";
            break;
        case 3:
            return @"开始乘车";
            break;
        case 4:
            return @"待付款";
            break;
        case 5:
            return @"已付款";
            break;
        case 6:
            return @"乘客取消订单";
            break;
        case 7:
            return @"司机取消订单";
            break;
        default:
            return @"";
            break;
    }
}

//driver_status:
//4=到达目的地等待付费，5=完成，付费成功。7司机取消
- (NSString *)driver_status_str
{
    switch ([_driver_status intValue]) {
        case 4:
            return @"未付款";
            break;
        case 5:
            return @"已付费";
            break;
        case 7:
            return @"司机取消";
            break;
        default:
            return @"";
            break;
    }
}

//order_payStatus:
//支付区分 0。微信支付。1.现金支付
- (NSString *)order_payStatus_str
{
    switch ([_order_payStatus intValue]) {
        case 0:
            return @"微信支付";
            break;
        case 1:
            return @"现金支付";
            break;
        default:
            return @"";
            break;
    }
}

@end
