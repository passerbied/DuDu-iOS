//
//  OrderVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/8.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef NS_ENUM(NSUInteger, OrderResult) {
    OrderSuccess = 0,
    OrderCouponCantUse = 5,
    OrderNotCompleted = 11,
    OrderNoCarUse = 12,
    OrderHaveOtherCar = 17
};

@interface OrderVC : BaseViewController

@property (nonatomic, strong) OrderModel *orderInfo;
@property (nonatomic, assign) NSInteger resultStatus;
@property (readwrite, nonatomic, assign) OrderResult result;

@end
