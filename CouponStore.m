//
//  CouponStore.m
//  DuDu
//
//  Created by i-chou on 12/31/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "CouponStore.h"
#import "CouponModel.h"

@implementation CouponStore

+ (instancetype)sharedCouponStore
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedCouponStore = nil;
    dispatch_once(&pred, ^{
        _sharedCouponStore = [[self alloc] init];
    });
    return _sharedCouponStore;
}

- (id)init
{
    return [super init];
}

- (NSArray *)sortedCouponsWithMoney:(float)money carStyle:(CarModel *)carStyle
{
    _useableCoupons = [self useableCouponsForCarStyle:carStyle money:money];
    if (_useableCoupons.count > 1) {
        NSMutableArray *coupons = [_useableCoupons mutableCopy];
        
        //冒泡排序找出最优惠的券
        for (int i = 0;i < coupons.count; i++) {
            for (int j = i+1; j < coupons.count; j++) {
                CouponModel *couponA = coupons[i];
                float a;
                if ([couponA.coupon_discount floatValue] < 1) { //折扣
                    a = money * [couponA.coupon_discount floatValue];
                } else {
                    a = money - [couponA.coupon_discount floatValue];
                }
                CouponModel *couponB = coupons[j];
                float b;
                if ([couponB.coupon_discount floatValue] < 1) { //折扣
                    b = money * [couponB.coupon_discount floatValue];
                } else {
                    b = money - [couponB.coupon_discount floatValue];
                }
                
                if (a > b) {
                    [coupons replaceObjectAtIndex:i withObject:couponB];
                    [coupons replaceObjectAtIndex:j withObject:couponA];
                }
            }
        }
        return coupons;
    }
    return _useableCoupons;
}

//- (NSArray *)useableCoupons
//{
//    return [self useableCouponsForCarStyle:nil money:0];
//}

- (NSArray *)useableCouponsForCarStyle:(CarModel *)carStyle money:(float)money
{
    for (CouponModel *coupon in _info) {
        //过期券
        if (coupon.coupon_exp_at_date) {
            NSDate *date = [NSDate date];
            NSTimeInterval sec = [date timeIntervalSinceNow];
            NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
            if (currentDate > coupon.coupon_exp_at_date){
                coupon.invalid = YES;
            }
        }
        //不在使用时间范围内
        if (coupon.coupon_user_start_time && [coupon.coupon_user_start_time length] && coupon.coupon_user_end_time && [coupon.coupon_user_end_time length]) {
            
            NSString *startTime = [coupon.coupon_user_start_time stringByReplacingOccurrencesOfString:@":" withString:@"."];
            NSString *endTime = [coupon.coupon_user_end_time stringByReplacingOccurrencesOfString:@":" withString:@"."];
            
            
            NSDate *date = [NSDate date];
            NSTimeInterval sec = [date timeIntervalSinceNow];
            NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
            NSString *currentTime = [NSString stringWithFormat:@"%d.%d",(int)[dateComponent hour],(int)[dateComponent minute]];
            
            if ([currentTime floatValue] < [startTime floatValue] || [currentTime floatValue] > [endTime floatValue]) {
                coupon.invalid = YES;
            }
        }
        //不是适用车型
        if (carStyle && [carStyle.car_style_id intValue] != [coupon.car_style_id intValue]) {
            coupon.invalid = YES;
        }
        //不在适用金额范围内
        if (money && money < [coupon.coupon_max_monny floatValue]) {
            coupon.invalid = YES;
        }
    }
    NSMutableArray *coupons = [NSMutableArray array];
    for (CouponModel *coupon in _info) {
        if (!coupon.invalid) {
            [coupons addObject:coupon];
        }
    }
    return coupons;
}

- (CouponModel *)cheapestCoupon:(float)money carStyle:(CarModel *)carStyle
{
    CouponModel *cheapestCoupon = [[CouponModel alloc] init];
    _useableCoupons = [self useableCouponsForCarStyle:carStyle money:money];
    if (_useableCoupons.count>1) {
        
        NSMutableArray *coupons = [_useableCoupons mutableCopy];
        
        //冒泡排序找出最优惠的券
        for (int i = 0;i < coupons.count; i++) {
            for (int j = i+1; j < coupons.count; j++) {
                CouponModel *couponA = coupons[i];
                float a;
                if ([couponA.coupon_discount floatValue] < 1) { //折扣
                    a = money * [couponA.coupon_discount floatValue];
                } else {
                    a = money - [couponA.coupon_discount floatValue];
                }
                CouponModel *couponB = coupons[j];
                float b;
                if ([couponB.coupon_discount floatValue] < 1) { //折扣
                    b = money * [couponB.coupon_discount floatValue];
                } else {
                    b = money - [couponB.coupon_discount floatValue];
                }
                
                if (a > b) {
                    [coupons replaceObjectAtIndex:i withObject:couponB];
                    [coupons replaceObjectAtIndex:j withObject:couponA];
                }
            }
        }
        cheapestCoupon = coupons[0];
    } else {
        cheapestCoupon = _useableCoupons[0];
    }
    
    return cheapestCoupon;
}

@end
