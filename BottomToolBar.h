//
//  BottomToolBar.h
//  DuDu
//
//  Created by i-chou on 11/7/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

@protocol BottomToolBarDelegate;

@interface BottomToolBar : UIView

@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *fromAddressLabel;
@property (nonatomic, strong) UILabel *toAddressLabel;
@property (nonatomic, strong) UILabel *budgetLabel;
@property (nonatomic, strong) UILabel *couponLabel;

@property (nonatomic, strong) id<BottomToolBarDelegate> delegate;

- (void)updateLocation:(NSString *)location;
- (void)updateCharge:(NSString *)money coupon:(CouponModel *)coupon;
- (void)showChargeView:(BOOL)show;

@end

@protocol BottomToolBarDelegate <NSObject>

- (void)bottomToolBar:(BottomToolBar *)toolBar didTapped:(UILabel *)label;
- (void)didSubmited;

@end
