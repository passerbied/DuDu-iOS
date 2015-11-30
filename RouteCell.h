//
//  RouteCell.h
//  DuDu
//
//  Created by 教路浩 on 15/11/30.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteCell : UITableViewCell

@property (nonatomic, copy)NSString *routeTime;
@property (nonatomic, copy)NSString *routeType;
@property (nonatomic, copy)NSString *routeStatus;
@property (nonatomic, copy)NSString *startSite;
@property (nonatomic, copy)NSString *endSite;

- (CGRect)calculateFrame;

@end
