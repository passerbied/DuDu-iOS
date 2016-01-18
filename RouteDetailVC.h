//
//  RouteDetailVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentVC.h"
#import "ZBCStarRating.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "AppDelegate.h"

@interface RouteDetailVC : BaseViewController
<CommentVCDelegate,
EDStarRatingProtocol,
WXApiDelegate,
AppDelegateDelegate>

@property (nonatomic, strong) OrderModel *orderInfo;
@property (nonatomic, strong) ZBCStarRating *starRating;
@property (nonatomic, assign) BOOL isHistory;
@property (nonatomic, assign) BOOL isForCharge;
@property (nonatomic, assign) NSInteger modelIndex;
@property (readwrite, nonatomic, assign) OrderResult resultStatus; //下订单返回的错误类别
@property (readwrite, nonatomic, assign) OrderStatus orderStatus; //订单状态类别
@property (nonatomic, assign) BOOL isModal;

@end
