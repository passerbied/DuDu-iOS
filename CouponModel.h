//
//  CouponModel.h
//  DuDu
//
//  Created by i-chou on 12/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *userRef_id;
@property (nonatomic, strong) NSNumber *coupon_id;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *coupon_get_datetime;
@property (nonatomic, strong) NSString *coupon_discount;
@property (nonatomic, strong) NSString *coupon_title;
@property (nonatomic, strong) NSNumber *coupon_exp_day;
@property (nonatomic, strong) NSString *coupon_user_start_time;
@property (nonatomic, strong) NSString *coupon_user_end_time;
@property (nonatomic, strong) NSString *coupon_max_monny;
@property (nonatomic, strong) NSNumber *coupon_isUsed;
@property (nonatomic, strong) NSNumber *coupon_isShare;

@end
