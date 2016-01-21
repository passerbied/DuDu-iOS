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

+ (instancetype)sharedCouponStore;


@end
