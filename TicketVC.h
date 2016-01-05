//
//  TicketVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponStore.h"
#import "CouponModel.h"

@interface TicketVC : UIViewController
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) NSArray *coupons;

@end
