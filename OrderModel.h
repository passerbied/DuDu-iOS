//
//  OrderModel.h
//  DuDu
//
//  Created by i-chou on 12/28/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *start_lat;
@property (nonatomic, strong) NSString *start_lng;
@property (nonatomic, strong) NSString *start_loc_str;
@property (nonatomic, strong) NSString *dest_lat;
@property (nonatomic, strong) NSString *dest_lng;
@property (nonatomic, strong) NSString *dest_loc_str;
@property (nonatomic, strong) NSString *car_style;
@property (nonatomic, strong) NSString *startTimeType;
@property (nonatomic, strong) NSString *startTimeStr;
@property (nonatomic, strong) NSNumber *coupon_id;
@property (nonatomic, strong) NSString *order_time;
@property (nonatomic, strong) NSNumber *order_id;

@end
