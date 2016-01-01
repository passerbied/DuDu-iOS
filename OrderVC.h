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
    OrderSuccess = 0, //正常情况，等待司机接单
    OrderCouponCantUse = 5, //优惠券不可用
    OrderNotCompleted = 11, //订单未完成
    OrderNoCarUse = 12, //没有车辆可用
    OrderHaveOtherCar = 17, //当前选择车型不可用，有其他车型可用
    OrderChangedCar = 0 //修改车型以后的状态
};

@interface OrderVC : BaseViewController

@property (nonatomic, strong) OrderModel *orderInfo;
@property (nonatomic, assign) NSInteger resultStatus;
@property (readwrite, nonatomic, assign) OrderResult result;
@property (nonatomic, copy) NSString *orderStatusInfo;
@property (nonatomic, strong) CarStore *carStore;

+ (instancetype)sharedOrderVC;

- (void)calculateFrame;

@end
