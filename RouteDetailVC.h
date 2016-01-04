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

@interface RouteDetailVC : UIViewController
<CommentVCDelegate,
EDStarRatingProtocol>

@property (nonatomic, strong) OrderModel *orderInfo;
@property (nonatomic, strong) ZBCStarRating *starRating;
@property (nonatomic, assign) BOOL isHistory;
@property (nonatomic, assign) NSInteger modelIndex;

@end
