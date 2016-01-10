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
    OrderResultSuccess = 0,         //正常情况，等待司机接单
    OrderResultCouponCantUse = 5,   //优惠券不可用
    OrderResultNotCompleted = 11,   //订单未完成
    OrderResultNoCarUse = 12,       //没有车辆可用
    OrderResultHaveOtherCar = 17,   //当前选择车型不可用，有其他车型可用
    OrderResultChangedCar = 0       //修改车型以后的状态
};

typedef NS_ENUM(NSUInteger, OrderStatus) {
    OrderStatusWatingForDriver = 0, //等待派单
    OrderStatusDriverIsComing = 2,  //司机前往
    OrderStatusTravelStart = 3,     //开始乘车
    OrderStatusWatingForPay = 4,    //到达目的地等待付款
    OrderStatusComleted = 5,        //订单完成
    OrderStatusUserCancel = 6,      //乘客取消订单
    OrderStatusDriverCancel = 7     //司机取消订单
};

@interface OrderVC : BaseViewController

@property (nonatomic, strong) OrderModel *orderInfo;
//@property (nonatomic, assign) NSInteger resultStatus;
@property (readwrite, nonatomic, assign) OrderResult resultStatus;
@property (readwrite, nonatomic, assign) OrderStatus orderStatus;
@property (nonatomic, copy) NSString *orderStatusInfo;
@property (nonatomic, strong) CarStore *carStore;

+ (instancetype)sharedOrderVC;

- (void)calculateFrame;

@end
