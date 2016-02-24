//
//  CouponStore.h
//  DuDu
//
//  Created by i-chou on 12/31/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponModel.h"
#import "ShareModel.h"

@interface CouponStore : NSObject

@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) ShareModel *shareInfo;
@property (nonatomic, strong) NSArray *useableCoupons;

+ (instancetype)sharedCouponStore;
- (CouponModel *)cheapestCoupon:(float)money carStyle:(CarModel *)carStyle;
- (NSArray *)sortedCouponsWithMoney:(float)money carStyle:(CarModel *)carStyle;
- (NSArray *)useableCouponsForCarStyle:(CarModel *)carStyle money:(float)money;

@end
