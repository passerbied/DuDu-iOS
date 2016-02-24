//
//  CouponVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponStore.h"
#import "CouponModel.h"

@protocol CouponVCDelegate;

@interface CouponVC : BaseViewController
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) id<CouponVCDelegate> delegate;
@property (nonatomic, assign) BOOL showUnuseHeader;
@property (assign) float money;
@property (nonatomic, strong) CarModel *carStyle;

@end

@protocol CouponVCDelegate <NSObject>

- (void)couponVC:(CouponVC *)vc didSelectCouponIndex:(int)index;
- (void)didSelectUnuseCoupon;

@end
