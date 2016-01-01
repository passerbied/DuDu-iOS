//
//  MenuTableViewController.h
//  DuDu
//
//  Created by i-chou on 11/17/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponStore.h"

@interface MenuTableViewController : UITableViewController

+ (instancetype)sharedMenuTableViewController;

@property (nonatomic, strong) UserModel *userInfo;
@property (nonatomic, strong) CouponStore *coupons;
@end
