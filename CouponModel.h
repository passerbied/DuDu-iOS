//
//  CouponModel.h
//  DuDu
//
//  Created by i-chou on 12/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, assign) NSInteger exp_day;
@property (nonatomic, strong) NSString *user_start_time;
@property (nonatomic, strong) NSString *user_end_time;
@property (nonatomic, strong) NSString *max_money;
@property (nonatomic, assign) BOOL isShare;
@property (nonatomic, assign) BOOL isUsed;

@end
