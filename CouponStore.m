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

@end
