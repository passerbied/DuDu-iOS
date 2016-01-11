//
//  OrderVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/8.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderVC : BaseViewController

@property (nonatomic, strong) OrderModel *orderInfo;
//@property (nonatomic, assign) NSInteger resultStatus;
@property (readwrite, nonatomic, assign) OrderResult resultStatus; //下订单返回的错误类别
@property (readwrite, nonatomic, assign) OrderStatus orderStatus; //订单状态类别
@property (nonatomic, copy) NSString *orderStatusInfo;
@property (nonatomic, strong) CarStore *carStore;

+ (instancetype)sharedOrderVC;

- (void)calculateFrame;

@end
