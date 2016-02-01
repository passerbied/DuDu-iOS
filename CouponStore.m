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

- (NSArray *)sortedCouponsWithMoney:(float)money
{
    if (_info.count > 1) {
        NSMutableArray *coupons = [_info mutableCopy];
        
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
    return _info;
}

//- (NSArray *)info
//{
//    if (_info.count > 1) {
//        float money = 20.0;
//        NSMutableArray *coupons = [_info mutableCopy];
//        
//        //冒泡排序找出最优惠的券
//        for (int i = 0;i < coupons.count; i++) {
//            for (int j = i+1; j < coupons.count; j++) {
//                CouponModel *couponA = coupons[i];
//                float a;
//                if ([couponA.coupon_discount floatValue] < 1) { //折扣
//                    a = money * [couponA.coupon_discount floatValue];
//                } else {
//                    a = money - [couponA.coupon_discount floatValue];
//                }
//                CouponModel *couponB = coupons[j];
//                float b;
//                if ([couponB.coupon_discount floatValue] < 1) { //折扣
//                    b = money * [couponB.coupon_discount floatValue];
//                } else {
//                    b = money - [couponB.coupon_discount floatValue];
//                }
//                
//                if (a > b) {
//                    [coupons replaceObjectAtIndex:i withObject:couponB];
//                    [coupons replaceObjectAtIndex:j withObject:couponA];
//                }
//            }
//        }
//        return coupons;
//    }
//    return _info;
//}

- (CouponModel *)cheapestCoupon:(float)money
{
    CouponModel *cheapestCoupon = [[CouponModel alloc] init];
    if (self.info.count>1) {
        
        NSMutableArray *coupons = [self.info mutableCopy];
        
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
        cheapestCoupon = self.info[0];
    }
    
    return cheapestCoupon;
}

@end
