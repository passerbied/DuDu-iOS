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

@interface CouponVC : UIViewController
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) id<CouponVCDelegate> delegate;

@end

@protocol CouponVCDelegate <NSObject>

- (void)couponVC:(CouponVC *)vc didSelectCouponIndex:(int)index;

@end
