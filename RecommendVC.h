//
//  RecommendVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface RecommendVC : UIViewController<WXApiDelegate>

@property (nonatomic, copy) NSString *share_coupon;
@property (nonatomic, copy) NSString *share_title;
@property (nonatomic, copy) NSString *share_desc;
@property (nonatomic, copy) NSString *share_link;
@property (nonatomic, copy) NSString *share_thumb;

@end
