//
//  OrderVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/8.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "OrderVC.h"
#import "SIAlertView.h"
#import "CouponStore.h"
#import "MainViewController.h"

@interface OrderVC ()
{
    UIView      *_routeView;
    UILabel     *_timeLabel;
    UILabel     *_startLabel;
    UILabel     *_endLabel;
    UIImageView *_timerImageView;
    UILabel     *_timerLabel;
    UIImageView *_bottomLine;
    
    UILabel     *_noticeLabel;
    
    UIView      *_driverView;
    UIImageView *_avator;
    UILabel     *_driverNameLabel;
    UILabel     *_carNumLabel;
    UILabel     *_carStyleLabel;
    UILabel     *_carColorLabel;
    
    int         _timerCount;
    NSTimer     *_countDownTimer;
    NSTimer     *_fetchDataTimer;
    SIAlertView *_alertView;
    UILabel     *_timerTitle;
    UIButton    *_cancelBtn;
    
    UIWebView   *_phoneCallWebView;
}

@end

@implementation OrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self setupCancelBtn];
    [self.view addSubview:[self routeView]];
    [self.view addSubview:[self noticeLabel]];
    [self.view addSubview:[self driverView]];
    [self showDriverView:NO];
    [self showOtherCars:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self flushOrderStatus:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _alertView = nil;
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    [_fetchDataTimer invalidate];
    _fetchDataTimer = nil;
}

- (void)cancelDidTapped
{
    _alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"\n您确定要取消订单吗？\n"];
    _alertView.messageFont = HSFONT(14);
    _alertView.buttonColor = COLORRGB(0xf39a00);
    _alertView.buttonFont = HSFONT(15);
    _alertView.cancelButtonColor = COLORRGB(0xf39a00);
    _alertView.didShowHandler = ^(SIAlertView *alertView) {
    };
    _alertView.didDismissHandler = ^(SIAlertView *alertView) {
        alertView = nil;
    };
    _alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    __weak id weakSelf = self;
    [_alertView addButtonWithTitle:@"取消订单"
                              type:SIAlertViewButtonTypeDefault
                           handler:^(SIAlertView *alert) {
                               [weakSelf cancelOrder];
                           }];
    [_alertView addButtonWithTitle:@"继续等待"
                              type:SIAlertViewButtonTypeCancel
                           handler:^(SIAlertView *alert) {
                               [alert dismissAnimated:YES];
                           }];
    [_alertView show];
}

- (UIView *)routeView
{
    if (!_routeView) {
        _routeView = [[UIView alloc] init];
    }
    
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:ccr(10, 10, 16, 16)];
    timeImage.image = IMG(@"tiny_clock");
    [_routeView addSubview:timeImage];
    
    _timeLabel = [UILabel labelWithFrame:ccr(36,
                                             10,
                                             SCREEN_WIDTH-36,
                                             16)
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [_routeView addSubview:_timeLabel];
    
    UIImageView *startImage = [[UIImageView alloc] initWithFrame:ccr(timeImage.origin.x,
                                                                     CGRectGetMaxY(timeImage.frame)+10,
                                                                     timeImage.width,
                                                                     timeImage.height)];
    startImage.image = IMG(@"tiny_circle_green");
    [_routeView addSubview:startImage];
    
    _startLabel = [UILabel labelWithFrame:ccr(_timeLabel.x,
                                              CGRectGetMaxY(_timeLabel.frame)+10,
                                              _timeLabel.width,
                                              16)
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [_routeView addSubview:_startLabel];
    
    UIImageView *endImage = [[UIImageView alloc] initWithFrame:ccr(startImage.origin.x,
                                                                   CGRectGetMaxY(startImage.frame)+10,
                                                                   startImage.width,
                                                                   startImage.height)];
    endImage.image = IMG(@"tiny_circle_red");
    [_routeView addSubview:endImage];
    
    _endLabel = [UILabel labelWithFrame:ccr(_startLabel.x,
                                            CGRectGetMaxY(_startLabel.frame)+10,
                                            _startLabel.width,
                                            16)
                                  color:COLORRGB(0x000000)
                                   font:HSFONT(12)
                                   text:@""
                              alignment:NSTextAlignmentLeft
                          numberOfLines:1];
    [_routeView addSubview:_endLabel];
    
    _timerTitle = [UILabel labelWithFrame:ccr(SCREEN_WIDTH-100-10,
                                              _timeLabel.y,
                                              100,
                                              _timeLabel.height)
                                    color:COLORRGB(0x63666b)
                                     font:HSFONT(12)
                                     text:@"嘟嘟为您提供服务"
                                alignment:NSTextAlignmentRight
                            numberOfLines:1];
    [_routeView addSubview:_timerTitle];
    _timerTitle.alpha = 0;
    
    _timerImageView = [[UIImageView alloc] initWithFrame:ccr(
                                                             SCREEN_WIDTH-30-40,
                                                             CGRectGetMaxY(_timerTitle.frame)+10,
                                                             40,
                                                             40)];
    _timerImageView.image = IMG(@"circle_orange");
    _timerImageView.alpha = 0;
    [_routeView addSubview:_timerImageView];
    
    _timerLabel = [UILabel labelWithFrame:ccr(0,
                                              0,
                                              _timerImageView.width,
                                              _timerImageView.height
                                              )
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(15)
                                     text:@"--"
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [_timerImageView addSubview:_timerLabel];
    
    _routeView.frame = ccr(0,
                           0,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_endLabel.frame)+20);
    
    return _routeView;
}

- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [UILabel labelWithFrame:ccr(0,
                                                   CGRectGetMaxY(_routeView.frame)+10,
                                                   SCREEN_WIDTH,
                                                   20)
                                         color:COLORRGB(0x63666b)
                                          font:HSFONT(15)
                                          text:@"欢迎使用嘟嘟出行"
                                     alignment:NSTextAlignmentCenter
                                 numberOfLines:0];
    }
    return _noticeLabel;
}

- (UIButton *)setupCancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithImageName:@""
                                       hlImageName:@""
                                             title:@"取消"
                                        titleColor:COLORRGB(0xffffff)
                                              font:HSFONT(15)
                                        onTapBlock:^(UIButton *btn) {
                                            [self cancelDidTapped];
                                        }];
        _cancelBtn.frame = ccr(0, 0, 40, 40);
    }
    return _cancelBtn;
}

- (UIView *)driverView
{
    if (!_driverView) {
        _driverView = [[UIView alloc] init];
    }
    
    UILabel *driverTitleLabel = [UILabel labelWithFrame:ccr((SCREEN_WIDTH-70)/2, 20, 70, 20)
                                                  color:COLORRGB(0xd7d7d7)
                                                   font:HSFONT(12)
                                                   text:@"车辆信息"
                                              alignment:NSTextAlignmentCenter
                                          numberOfLines:1];
    [_driverView addSubview:driverTitleLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:ccr(driverTitleLabel.x-5-50, 30, 50, 0.5)];
    leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_driverView addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:ccr(CGRectGetMaxX(driverTitleLabel.frame)+5, leftLine.y, leftLine.width, leftLine.height)];
    rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_driverView addSubview:rightLine];
    
    _avator = [[UIImageView alloc] initWithFrame:ccr(10,
                                                     CGRectGetMaxY(driverTitleLabel.frame)+10,
                                                     50,
                                                     50)];
    [_avator setImageWithURL:URL([Utils emptyIfNull:self.orderInfo.driver_photo])
            placeholderImage:IMG(@"account")];
    _avator.layer.cornerRadius = _avator.width/2;
    _avator.layer.masksToBounds = YES;
    
    [_driverView addSubview:_avator];
    
    
    NSString *driver_acount = [NSString stringWithFormat:@"%@",self.orderInfo.driver_nickname];
    _driverNameLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(_avator.frame)+10,
                                                   _avator.y,
                                                   150,
                                                   _avator.height/2)
                                         color:COLORRGB(0x000000)
                                          font:HSFONT(12)
                                          text:driver_acount];
    [_driverView addSubview:_driverNameLabel];
    
    _carNumLabel = [UILabel labelWithFrame:ccr(_driverNameLabel.x,
                                               CGRectGetMaxY(_driverNameLabel.frame),
                                               60,
                                               _avator.height/2)
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(12)
                                      text:self.orderInfo.car_plate_number];
    [_driverView addSubview:_carNumLabel];
    
    _carStyleLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(_carNumLabel.frame)+10,
                                                 _carNumLabel.y+5,
                                                 70,
                                                 15)
                                       color:COLORRGB(0x63666b)
                                        font:HSFONT(12)
                                        text:@"未知车型"
                                   alignment:NSTextAlignmentCenter
                               numberOfLines:1];
    _carStyleLabel.layer.borderColor = COLORRGB(0xf39a00).CGColor;
    _carStyleLabel.layer.borderWidth = 1;
    _carStyleLabel.layer.cornerRadius = 5.0f;
    [_driverView addSubview:_carStyleLabel];
    
    UIButton *phoneBtn = [UIButton buttonWithImageName:@"phone-icon2" hlImageName:@"phone-icon2" onTapBlock:^(UIButton *btn) {
        [self makeACall:self.orderInfo.driver_telephone];
    }];
    phoneBtn.frame = ccr(SCREEN_WIDTH-35-20, _avator.y+5, 35, 35);
    [_driverView addSubview:phoneBtn];
    
    _driverView.frame = ccr(0,
                            CGRectGetMaxY(_noticeLabel.frame),
                            SCREEN_WIDTH,
                            CGRectGetMaxY(_avator.frame));
    return _driverView;
}

-(void)makeACall:(NSNumber *)num
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",num]];
    if (!_phoneCallWebView) {
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_phoneCallWebView];
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}

- (void)cancelOrder
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:CANCEL_ORDER(self.orderInfo.order_id) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [ZBCToast showMessage:@"订单已取消"];
//        [[MainViewController sharedMainViewController] clearData];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)showTimerView:(BOOL)show
{
    _timerTitle.alpha = show;
    _timerImageView.alpha = show;
}

- (void)showDriverView:(BOOL)show
{
    _driverView.alpha = show;
//    if (show) {
//        _noticeLabel.y = CGRectGetMaxY(_driverView.frame)+30;
//    } else {
//        _noticeLabel.y = CGRectGetMaxY(_routeView.frame)+30;
//    }
}

- (void)showOtherCars:(BOOL)show
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (show) {
        
        for (int i=0; i<self.carStore.cars.count; i++) {
            CarModel *car = self.carStore.cars[i];
            UIButton *carBtn = [UIButton buttonWithImageName:@"orgbtn"
                                                 hlImageName:@"orgbtn_pressed"
                                                       title:car.car_style_name
                                                  titleColor:COLORRGB(0xffffff)
                                                        font:HSFONT(15)
                                                  onTapBlock:^(UIButton *btn) {
                                                      [self changeOrderToCarStyle:car];
                                                  }];
            carBtn.frame = ccr(10, CGRectGetMaxY(_noticeLabel.frame) + 10 + 40*i, SCREEN_WIDTH-20, 40);
            [self.view addSubview:carBtn];
        }
    }
}

- (void)flushOrderStatus:(NSTimer *)timer
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [_fetchDataTimer invalidate];
        _fetchDataTimer = nil;
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:FLUSH_ORDER_STATUS([self.orderInfo.order_id intValue]) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        
        if (dic && dic[@"info"]) {
            self.orderInfo.car_position_id = dic[@"info"][@"car_position_id"];
            self.orderInfo.car_color = dic[@"info"][@"car_color"];
            self.orderInfo.car_plate_number = dic[@"info"][@"car_plate_number"];
            self.orderInfo.driver_nickname = dic[@"info"][@"driver_nickname"];
            self.orderInfo.driver_telephone = dic[@"info"][@"driver_telephone"];
            self.orderInfo.driver_photo = dic[@"info"][@"driver_photo"];
            self.orderInfo.order_status = dic[@"info"][@"order_status"];
            self.orderInfo.car_brand = dic[@"info"][@"car_brand"];
            self.orderInfo.order_initiate_rate = dic[@"info"][@"order_initiate_rate"];
            self.orderInfo.order_mileage = dic[@"info"][@"order_mileage"];
            self.orderInfo.order_mileage_money = dic[@"info"][@"order_mileage_money"];
            self.orderInfo.order_duration_money = dic[@"info"][@"order_duration_money"];
            self.orderInfo.order_allTime = dic[@"info"][@"order_allTime"];
            self.orderInfo.order_allMoney = dic[@"info"][@"order_allMoney"];
            self.orderInfo.startTimeType = dic[@"info"][@"startTimeType"];
            self.orderInfo.location = dic[@"info"][@"location"];
        } else {
            self.orderInfo.car_color = @"";
            self.orderInfo.car_brand = @"未知车型";
            self.orderInfo.car_plate_number = @"未知车牌号";
            self.orderInfo.driver_nickname = @"未知司机";
            self.orderInfo.driver_telephone = [NSNumber numberWithInt:0];
        }
        [self setData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self setData];
    }];
}

- (void)setData
{
    if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver) {
        [self showRightTitle:YES withButton:_cancelBtn];
        if (![self.orderInfo.startTimeType intValue]) {
            self.orderStatusInfo = @"嘟嘟正在为您派车，请耐心等候";
            if (!_countDownTimer && self.canTimerShow) {
                _timerCount = [CouponStore sharedCouponStore].shareInfo.wait_order_time_seconds;
                [_countDownTimer setFireDate:[NSDate distantPast]];
                _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                   target:self
                                                                 selector:@selector(timerFireMethod:)
                                                                 userInfo:nil
                                                                  repeats:YES];
            }
        } else {
            self.orderStatusInfo = @"嘟嘟已经接单，出发前20分钟司机会主动联系您";
        }
        
    } else if ([self.orderInfo.order_status intValue] == OrderStatusDriverIsComing) {
        self.orderStatusInfo = @"司机正在前往，请耐心等待";
        [self showRightTitle:YES withButton:_cancelBtn];
        [ZBCToast showMessage:@"司机正在前往，请耐心等待"];
    } else if ([self.orderInfo.order_status intValue] == OrderStatusDriverCancel) {
        self.orderStatusInfo = @"司机取消订单";
        [self showRightTitle:NO withButton:nil];
        [ZBCToast showMessage:@"司机取消订单"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.orderInfo.order_status intValue] == OrderStatusTravelStart) {
        self.orderStatusInfo = [NSString stringWithFormat:@"行程中，%@正在为您服务",[MainViewController sharedMainViewController].currentCar.car_style_name];
        [self showRightTitle:NO withButton:nil];
        [ZBCToast showMessage:[NSString stringWithFormat:@"行程中，%@正在为您服务",[MainViewController sharedMainViewController].currentCar.car_style_name] ];
    } else if ([self.orderInfo.order_status intValue] == OrderStatusComleted) {
        self.orderStatusInfo = @"订单完成";
        [self showRightTitle:NO withButton:nil];
        [[MainViewController sharedMainViewController] clearData];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.orderInfo.order_status intValue] == OrderStatusWatingForPay) {
        self.orderStatusInfo = @"行程结束，请尽快付款";
        [self showRightTitle:NO withButton:nil];
//        [[MainViewController sharedMainViewController] clearData];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    _timeLabel.text = [date displayWithFormat:@"d号H点mm分"];
    _startLabel.text = self.orderInfo.star_loc_str;
    _endLabel.text = self.orderInfo.dest_loc_str;
    _noticeLabel.text = self.orderStatusInfo;
    [_avator setImageWithURL:URL([Utils emptyIfNull:self.orderInfo.driver_photo])
            placeholderImage:IMG(@"account")];
    _carStyleLabel.text = [NSString stringWithFormat:@"%@ %@",self.orderInfo.car_color, self.orderInfo.car_brand];
    _carColorLabel.text = self.orderInfo.car_color;
    
    _driverNameLabel.text = [NSString stringWithFormat:@"%@",self.orderInfo.driver_nickname];
    _carNumLabel.text = self.orderInfo.car_plate_number;
    
    
    if (!_fetchDataTimer) {
        [_fetchDataTimer setFireDate:[NSDate distantPast]];
        _fetchDataTimer = [NSTimer scheduledTimerWithTimeInterval:15.0
                                                           target:self
                                                         selector:@selector(flushOrderStatus:)
                                                         userInfo:nil
                                                          repeats:YES];

    }
    
    [self showTimerView:([self.orderInfo.order_status intValue]==OrderStatusWatingForDriver && ![self.orderInfo.startTimeType intValue] && self.canTimerShow)];
    [self showDriverView:([self.orderInfo.order_status intValue]>OrderStatusWatingForDriver)];
    [self showOtherCars:(self.resultStatus==OrderResultHaveOtherCar)];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    if (_timerCount>0) {
        _timerLabel.text = STR_I(_timerCount--);
    } else {
        _timerLabel.text = @"--";
        [_countDownTimer setFireDate:[NSDate distantFuture]];
        [_countDownTimer invalidate];
        
        if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver) {
            _alertView = [[SIAlertView alloc] initWithTitle:@"亲，很抱歉，让您久等了"
                                                 andMessage:@"我们的服务正在逐步完善中，请给我时间\n\n系统会赠送给您优惠券,\n\n是否继续等待嘟嘟为您服务？"];
            _alertView.messageFont = HSFONT(13);
            _alertView.titleFont = HSFONT(13);
            _alertView.titleColor = [UIColor darkGrayColor];
            _alertView.buttonColor = COLORRGB(0xf39a00);
            _alertView.buttonFont = HSFONT(15);
            _alertView.cancelButtonColor = COLORRGB(0xf39a00);
            __weak id weakSelf = self;
            [_alertView addButtonWithTitle:@"取消订单"
                                      type:SIAlertViewButtonTypeDefault
                                   handler:^(SIAlertView *alert) {
                                       [weakSelf cancelOrder];
                                   }];
            [_alertView addButtonWithTitle:@"继续等待"
                                      type:SIAlertViewButtonTypeCancel
                                   handler:^(SIAlertView *alert) {
                                       [alert dismissAnimated:YES];
                                   }];
            _alertView.didShowHandler = ^(SIAlertView *alertView) {
            };
            _alertView.didDismissHandler = ^(SIAlertView *alertView) {
                alertView = nil;
            };
            _alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [_alertView show];
        }
    }
}

- (void)changeOrderToCarStyle:(CarModel *)car
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:
                    ORDER_CHANGE_ORDER_CAR_STYLE([self.orderInfo.order_id stringValue],
                                                 [car.car_style_id stringValue])
                           parameters:nil
                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                  [self.carStore.cars removeAllObjects];
                                  self.resultStatus = OrderResultChangedCar;
                                  [self setData];
                                  [ZBCToast showMessage:@"修改车型成功，请耐心等候"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
