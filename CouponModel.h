//
//  CouponModel.h
//  DuDu
//
//  Created by i-chou on 12/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *userRef_id;
@property (nonatomic, copy) NSNumber *coupon_id;
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSNumber *car_style_id;
@property (nonatomic, copy) NSString *car_style_name;
@property (nonatomic, copy) NSString *coupon_get_datetime;
@property (nonatomic, copy) NSString *coupon_discount;
@property (nonatomic, copy) NSString *coupon_title;
@property (nonatomic, copy) NSString *coupon_type;
@property (nonatomic, copy) NSNumber *coupon_exp_day;
@property (nonatomic, copy) NSString *coupon_user_start_time;
@property (nonatomic, copy) NSString *coupon_user_end_time;
@property (nonatomic, copy) NSString *coupon_max_monny;
@property (nonatomic, copy) NSNumber *coupon_isUsed;
@property (nonatomic, copy) NSNumber *coupon_isShare;
@property (nonatomic, copy) NSString *coupon_exp_at;

@end
