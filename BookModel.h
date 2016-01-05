//
//  BookModel.h
//  DuDu
//
//  Created by i-chou on 1/6/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *order_id;
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSNumber *relevance_id;
@property (nonatomic, copy) NSNumber *start_lat;
@property (nonatomic, copy) NSNumber *start_lng;
@property (nonatomic, copy) NSString *star_loc_str;
@property (nonatomic, copy) NSNumber *dest_lat;
@property (nonatomic, copy) NSNumber *dest_lng;
@property (nonatomic, copy) NSString *dest_loc_str;
@property (nonatomic, copy) NSNumber *car_style;
@property (nonatomic, copy) NSNumber *startTimeType;
@property (nonatomic, copy) NSString *startTimeStr;
@property (nonatomic, copy) NSNumber *order_initiate_rate;
@property (nonatomic, copy) NSNumber *order_mileage;
@property (nonatomic, copy) NSNumber *order_mileage_money;
@property (nonatomic, copy) NSNumber *order_allMoney;
@property (nonatomic, copy) NSNumber *order_allTime;
@property (nonatomic, copy) NSNumber *order_status;
@property (nonatomic, copy) NSNumber *driver_status;
@property (nonatomic, copy) NSNumber *coupon_id;
@property (nonatomic, copy) NSString *order_time;
@property (nonatomic, copy) NSNumber *order_payStatus;
@property (nonatomic, assign) BOOL   isbook;

@end
