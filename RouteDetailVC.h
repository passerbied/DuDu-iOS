//
//  RouteDetailVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentVC.h"

@interface RouteDetailVC : UIViewController
<CommentVCDelegate>

@property (nonatomic, strong) OrderModel *orderInfo;

@end
