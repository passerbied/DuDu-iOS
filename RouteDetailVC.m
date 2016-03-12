//
//  RouteDetailVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RouteDetailVC.h"
#import "CheckDetailVC.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WXUtil.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import "MainViewController.h"

@interface RouteDetailVC ()<WXApiManagerDelegate>
{
    UIScrollView *_scrollView;
    
    //**************  行程Info start ************
    UIView      *_routeView;
    UILabel     *_timeLabel;
    UILabel     *_startLabel;
    UILabel     *_endLabel;
    //**************  行程Info end ************
    
    
    //**************  司机Info start ************
    UIView      *_driverView;
    UIImageView *_avator;
    UILabel     *_driverNameLabel;
    UILabel     *_carNumLabel;
    UILabel     *_carStyleLabel;
    UILabel     *_carColorLabel;
    //**************  司机Info end ************
    
    
    //**************  费用Info start ************
    UIView      *_chargeView;
    UILabel     *_priceLabel;
    
    UILabel     *_mileageLabel;
    UILabel     *_duringLabel;
//    UILabel     *_nightLabel;
    UILabel     *_minPriceLabel;
    UILabel     *_couponLabel;
    UILabel     *_payTypeLabel;
    
    UILabel     *_mileagePrice;
    UILabel     *_duringPrice;
    UILabel     *_nightPrice;
    UILabel     *_minPrice;
    UILabel     *_couponPrice;
    UILabel     *_payPrice;
    
    UIImageView *_mileageLine;
    UIImageView *_duringLine;
    UIImageView *_nightLine;
    UIImageView *_minPriceLine;
    UIImageView *_couponLine;
    UIImageView *_payLine;
    //**************  费用Info  end ************
    
    
    //**************  评星Info  start ************
    UIView      *_ratingView;
    //**************  评星Info  end ************
    
    
    //**************  支付Info  start ************
    UIButton    *_payBtn;
    UIButton    *_shareBtn;
    //**************  支付Info  end ************
    
    
    BOOL        _isRatingChanged;
    BOOL        _isPayed;
    
    NSTimer     *_fetchDataTimer;
}

@end

@implementation RouteDetailVC

- (void)loadView
{
    [super loadView];
    _scrollView = [[UIScrollView alloc] initWithFrame:ccr(0, -NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, SCREEN_HEIGHT+NAV_BAR_HEIGHT_IOS7)];
    [self.view addSubview:_scrollView];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self flushOrderStatus:nil];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.delegate = self;
    
    if (self.isModal) {
        UIButton *btn = [UIButton buttonWithImageName:@"gn_pop_icon_shut" hlImageName:@"gn_pop_icon_shut_hl" onTapBlock:^(UIButton *btn) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];
        [self showLeftBarItem:YES withButton:btn];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_fetchDataTimer invalidate];
    _fetchDataTimer = nil;
}

- (void)createSubViews
{
    [_scrollView addSubview:[self routeView]];
    [_scrollView addSubview:[self driverView]];
    [_scrollView addSubview:[self chargeView]];
    [_scrollView addSubview:[self ratingView]];
    _payBtn = [self weixinPayBtn];
    [_scrollView addSubview:_payBtn];
    [_scrollView addSubview:[self shareBtn]];
    
    _driverView.alpha = 0;
    _payBtn.alpha = 0;
    _ratingView.alpha = 0;
    _shareBtn.alpha = 0;
    
//    [self calculateFrame];
}

- (void)calculateFrame
{
    [self setData];
    
    CGSize carStyleSize = [self getTextFromLabel:_carStyleLabel];
    _carStyleLabel.frame = ccr(SCREEN_WIDTH-20-carStyleSize.width-6, _carStyleLabel.y, carStyleSize.width+6, _carStyleLabel.height+4);
    
    CGSize mileageSize = [self getTextFromLabel:_mileageLabel];
    _mileageLabel.frame = ccr(20,
                              CGRectGetMaxY(_priceLabel.frame)+15,
                              mileageSize.width,
                              mileageSize.height);
    CGSize mileagePriceSize = [self getTextFromLabel:_mileagePrice];
    _mileagePrice.frame = ccr(SCREEN_WIDTH-20-mileagePriceSize.width,
                              _mileageLabel.y,
                              mileagePriceSize.width,
                              mileagePriceSize.height);
    _mileageLine.frame = ccr(CGRectGetMaxX(_mileageLabel.frame)+5,
                             CGRectGetMaxY(_mileageLabel.frame)-mileageSize.height/2,
                             _mileagePrice.origin.x-5*2-CGRectGetMaxX
                             (_mileageLabel.frame),
                             0.5);
    
    CGSize duringSize = [self getTextFromLabel:_duringLabel];
    _duringLabel.frame = ccr(_mileageLabel.origin.x,
                           CGRectGetMaxY(_mileageLabel.frame)+5,
                           duringSize.width,
                           duringSize.height);
    
    CGSize duringPriceSize = [self getTextFromLabel:_duringPrice];
    _duringPrice.frame = ccr(SCREEN_WIDTH-20-duringPriceSize.width,
                           CGRectGetMaxY(_mileagePrice.frame)+5,
                           duringPriceSize.width,
                           duringPriceSize.height);
    
    _duringLine.frame = ccr(CGRectGetMaxX(_duringLabel.frame)+5,
                          CGRectGetMaxY(_duringLabel.frame)-duringSize.height/2,
                          _duringPrice.origin.x-5*2-CGRectGetMaxX(_duringLabel.frame),
                          0.5);
    
    CGFloat minPriceY = CGRectGetMaxY(_duringLabel.frame)+5;
    
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    
//    if ([Utils checkNightService:date]) { //夜间服务
//        CGSize nightLabelSize = [self getTextFromLabel:_nightLabel];
//        _nightLabel.frame = ccr(_mileageLabel.x,
//                                CGRectGetMaxY(_duringLabel.frame)+5,
//                                nightLabelSize.width,
//                                nightLabelSize.height);
//        
//        CGSize nightPriceSize = [self getTextFromLabel:_nightPrice];
//        _nightPrice.frame = ccr(SCREEN_WIDTH-20-nightPriceSize.width,
//                                       CGRectGetMaxY(_duringPrice.frame)+5,
//                                       nightPriceSize.width,
//                                       nightPriceSize.height);
//        
//        
//        _nightLine.frame = ccr(CGRectGetMaxX(_nightLabel.frame)+5,
//                                      CGRectGetMaxY(_nightLabel.frame)-_nightLabel.height/2,
//                                      _nightPrice.x-5*2-CGRectGetMaxX(_nightLabel.frame),
//                                      0.5);
//        
//        minPriceY = CGRectGetMaxY(_nightLabel.frame)+5;
//    }
    
    CGSize minSize = [self getTextFromLabel:_minPriceLabel];
    _minPriceLabel.frame = ccr(_mileageLabel.x,
                               minPriceY,
                               minSize.width,
                               minSize.height);
    CGSize minPriceSize = [self getTextFromLabel:_minPrice];
    _minPrice.frame = ccr(SCREEN_WIDTH-20-minPriceSize.width,
                          minPriceY,
                          minPriceSize.width,
                          minPriceSize.height);
    _minPriceLine.frame = ccr(CGRectGetMaxX(_minPriceLabel.frame)+5,
                              CGRectGetMaxY(_minPriceLabel.frame)-minPriceSize.height/2,
                              _minPrice.x-5*2-CGRectGetMaxX(_minPriceLabel.
                                                            frame),
                              0.5);
    
    CGFloat payPriceY = CGRectGetMaxY(_minPriceLabel.frame)+5;
    
    if ([self.orderInfo.coupon_id intValue]) { //有优惠
        
        CGSize couponSize = [self getTextFromLabel:_couponLabel];
        _couponLabel.frame = ccr(_mileageLabel.origin.x,
                                 CGRectGetMaxY(_minPriceLabel.frame)+5,
                                 couponSize.width,
                                 couponSize.height);
        CGSize couponTitleSize = [self getTextFromLabel:_couponPrice];
        _couponPrice.frame = ccr(SCREEN_WIDTH-20-couponTitleSize.width,
                                 _couponLabel.y,
                                 couponTitleSize.width,
                                 couponTitleSize.height);
        _couponLine.frame = ccr(CGRectGetMaxX(_couponLabel.frame)+5,
                                CGRectGetMaxY(_couponLabel.frame)-couponTitleSize.height/2,
                                _couponPrice.origin.x-5*2-CGRectGetMaxX(_couponLabel.
                                                                        frame),
                                0.5);
        
        payPriceY = CGRectGetMaxY(_couponLabel.frame)+5;
    }
    
    if ([self.orderInfo.order_status intValue] == OrderStatusComleted) {
        CGSize payTypeSize = [self getTextFromLabel:_payTypeLabel];
        _payTypeLabel.frame = ccr(_mileageLabel.origin.x,
                                  payPriceY + 5,
                                  payTypeSize.width,
                                  payTypeSize.height);
        CGSize payPriceSize = [self getTextFromLabel:_payPrice];
        _payPrice.frame = ccr(SCREEN_WIDTH-20-payPriceSize.width,
                              _payTypeLabel.y,
                              payPriceSize.width,
                              payPriceSize.height);
        _payLine.frame = ccr(CGRectGetMaxX(_payTypeLabel.frame)+5,
                             CGRectGetMaxY(_payTypeLabel.frame)-payTypeSize.
                             height/2,
                             _payPrice.origin.x-5*2-CGRectGetMaxX(_payTypeLabel
                                                                  .frame),
                             0.5);
        _chargeView.height = CGRectGetMaxY(_payLine.frame);
    } else {
        _chargeView.height = payPriceY;
    }
    
    if ([self.orderInfo.car_style_flg intValue] == 2) { //顺风车订单
        _mileageLabel.alpha = 0;
        _mileageLine.alpha  = 0;
        _mileagePrice.alpha = 0;
        _duringLabel.alpha  = 0;
        _duringLine.alpha   = 0;
        _duringPrice.alpha  = 0;
//        _nightLabel.alpha   = 0;
        _nightLine.alpha    = 0;
        _nightPrice.alpha   = 0;
        _couponLabel.alpha  = 0;
        _couponLine.alpha   = 0;
        _couponPrice.alpha  = 0;
        _minPriceLabel.alpha = 0;
        _minPriceLine.alpha = 0;
        _minPrice.alpha     = 0;
        _payTypeLabel.alpha = 0;
        _payLine.alpha      = 0;
        _payPrice.alpha     = 0;
        _chargeView.height = 50;
        _payBtn.frame = ccr((SCREEN_WIDTH-260)/2, SCREEN_HEIGHT - 50, 260, 40);
    }
    
    _driverView.alpha = 1;
    _chargeView.y = CGRectGetMaxY(_driverView.frame)+10;
    _ratingView.y = CGRectGetMaxY(_chargeView.frame)+30;
    
    if(self.isForCharge) {
        _ratingView.alpha = 0;
        _scrollView.contentSize = ccs(SCREEN_WIDTH, CGRectGetMaxY(_payBtn.frame));
    } else {
        _ratingView.alpha = 1;
    }
    if (([self.orderInfo.order_status intValue] == 5 || _isPayed)) {
        _scrollView.contentSize = ccs(SCREEN_WIDTH, CGRectGetMaxY(_shareBtn.frame)+10);
        _payBtn.alpha = 0;
        _shareBtn.alpha = 1;
    } else {
        _scrollView.contentSize = ccs(SCREEN_WIDTH, CGRectGetMaxY(_payBtn.frame)+10);
        _payBtn.alpha = 1;
        _shareBtn.alpha = 0;
    }
    
}

- (void)flushOrderStatus:(NSTimer *)timer
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        if (self.isModal) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    [[DuDuAPIClient sharedClient] GET:FLUSH_ORDER_STATUS([self.orderInfo.order_id intValue]) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        
        if (dic && dic[@"info"]) {
            self.orderInfo.car_position_id = dic[@"info"][@"car_position_id"];
            self.orderInfo.car_color = dic[@"info"][@"car_color"];
            self.orderInfo.car_style = dic[@"info"][@"car_style_id"];
            self.orderInfo.car_style_flg = dic[@"info"][@"car_style_flg"];
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
            self.orderInfo.location = dic[@"info"][@"location"];
            self.orderInfo.order_payStatus = dic[@"info"][@"order_payStatus"];
            self.orderInfo.free_ride_telephone = dic[@"info"][@"free_ride_telephone"];
        } else {
            self.orderInfo.car_color = @"";
            self.orderInfo.car_brand = @"未知车型";
            self.orderInfo.car_plate_number = @"未知车牌号";
            self.orderInfo.driver_nickname = @"未知司机";
            self.orderInfo.driver_telephone = [NSNumber numberWithInt:0];
        }
        
        [self calculateFrame];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.orderInfo.car_color = @"";
        self.orderInfo.car_brand = @"未知车型";
        self.orderInfo.car_plate_number = @"未知车牌号";
        self.orderInfo.driver_nickname = @"未知司机";
        self.orderInfo.driver_telephone = [NSNumber numberWithInt:0];
        [self calculateFrame];
    }];
}

- (void)setData
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    _timeLabel.text = [date displayWithFormat:@"yyyy-M-d H:mm"];
    _startLabel.text = self.orderInfo.star_loc_str;
    _endLabel.text = self.orderInfo.dest_loc_str;
    [_avator setImageWithURL:URL([Utils emptyIfNull:self.orderInfo.driver_photo])
            placeholderImage:IMG(@"account")];
    _carStyleLabel.text = [NSString stringWithFormat:@"%@ %@",self.orderInfo.car_color, self.orderInfo.car_brand];
    _carColorLabel.text = self.orderInfo.car_color;
    
    _driverNameLabel.text = [NSString stringWithFormat:@"%@(%@)",self.orderInfo.driver_nickname,self.orderInfo.driver_telephone];
    _carNumLabel.text = self.orderInfo.car_plate_number;
    
    _priceLabel.text = [NSString stringWithFormat:@"%.1f元",[self.orderInfo.order_allMoney floatValue]];
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
    NSUInteger priceLength = _priceLabel.text.length-1;
    [priceString addAttributes:@{NSFontAttributeName:HSFONT(20)}
                         range:NSMakeRange(0, priceLength)];
    _priceLabel.attributedText = priceString;
    
    if ([Utils checkNightService:date]) { //夜间服务
        
        float mileage = [self.orderInfo.order_mileage floatValue];
        _mileageLabel.text = [NSString stringWithFormat:@"里程(%.1f公里)",mileage];
        float mileagePrice = [self.orderInfo.order_mileage_money floatValue];
        _mileagePrice.text = [NSString stringWithFormat:@"%.1f元(夜间)",mileagePrice];
        int during = [self.orderInfo.order_allTime intValue];
        _duringLabel.text = [NSString stringWithFormat:@"时长费(%d分钟)",during];
        float duringPrice = [self.orderInfo.order_duration_money floatValue];
        _duringPrice.text = [NSString stringWithFormat:@"%.1f元(夜间)",duringPrice];
        float couponPrice = [self.orderInfo.coupon_discount floatValue];
        if (couponPrice<1) {
            _couponLabel.text = @"打折优惠";
            _couponPrice.text = [NSString stringWithFormat:@"%.2f折",couponPrice];
        } else {
            _couponLabel.text = @"满减优惠";
            _couponPrice.text = [NSString stringWithFormat:@"%.1f元",couponPrice];
        }
        _minPrice.text = [NSString stringWithFormat:@"%.1f元(夜间)",[MainViewController sharedMainViewController].currentCar.start_money];

    } else {
        
        float mileage = [self.orderInfo.order_mileage floatValue];
        _mileageLabel.text = [NSString stringWithFormat:@"里程(%.1f公里)",mileage];
        float mileagePrice = [self.orderInfo.order_mileage_money floatValue];
        _mileagePrice.text = [NSString stringWithFormat:@"%.1f元",mileagePrice];
        int during = [self.orderInfo.order_allTime intValue];
        _duringLabel.text = [NSString stringWithFormat:@"时长费(%d分钟)",during];
        float duringPrice = [self.orderInfo.order_duration_money floatValue];
        _duringPrice.text = [NSString stringWithFormat:@"%.1f元",duringPrice];
        float couponPrice = [self.orderInfo.coupon_discount floatValue];
        if (couponPrice<1) {
            _couponLabel.text = @"打折优惠";
            _couponPrice.text = [NSString stringWithFormat:@"%.2f折",couponPrice];
        } else {
            _couponLabel.text = @"满减优惠";
            _couponPrice.text = [NSString stringWithFormat:@"%.1f元",couponPrice];
        }
        _minPrice.text = [NSString stringWithFormat:@"%.1f元",[MainViewController sharedMainViewController].currentCar.start_money];
    }
    
    if ([self.orderInfo.order_status intValue]== OrderStatusComleted) {
        _payTypeLabel.text = self.orderInfo.order_payStatus_str;
        _payPrice.text = [NSString stringWithFormat:@"%.1f元",[self.orderInfo.order_allMoney floatValue]];
    }

    [_payBtn removeFromSuperview];
    if ([self.orderInfo.order_payStatus intValue]) {
        _payBtn = [self cashPayBtn];
    } else {
        _payBtn = [self weixinPayBtn];
    }
    [self.view addSubview:_payBtn];
    
    
    self.starRating.editable = ([self.orderInfo.order_status intValue] == 5 || _isPayed); //只有已付款并且没评过星的才可以评星, _isPayed是因为服务器刷新数据比微信回调速度慢造成支付成功但数据未更新成已支付。
    self.starRating.rating = [self.orderInfo.evaluate_level floatValue];
    
    if (!_fetchDataTimer && self.isModal) {
        [_fetchDataTimer setFireDate:[NSDate distantPast]];
        _fetchDataTimer = [NSTimer scheduledTimerWithTimeInterval:15.0
                                                           target:self
                                                         selector:@selector(flushOrderStatus:)
                                                         userInfo:nil
                                                          repeats:YES];
        
    }
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
    
    _routeView.frame = ccr(0,
                           NAV_BAR_HEIGHT_IOS7,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_endLabel.frame)+10);
    
    return _routeView;
}

- (UIView *)driverView
{
    if (!_driverView) {
        _driverView = [[UIView alloc] initWithFrame:ccr(0, CGRectGetMaxY(_routeView.frame)+40, SCREEN_WIDTH, 90)];
    }
    
    UILabel *driverTitleLabel = [UILabel labelWithFrame:ccr((SCREEN_WIDTH-70)/2, 0, 70, 20)
                                                  color:COLORRGB(0xd7d7d7)
                                                   font:HSFONT(12)
                                                   text:@"车辆信息"
                                              alignment:NSTextAlignmentCenter
                                          numberOfLines:1];
    [_driverView addSubview:driverTitleLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:ccr(driverTitleLabel.x-5-50, 10, 50, 0.5)];
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

    
    NSString *driver_acount = [NSString stringWithFormat:@"%@(%@)",self.orderInfo.driver_nickname,self.orderInfo.driver_telephone];
    _driverNameLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(_avator.frame)+10,
                                             _avator.y,
                                             SCREEN_WIDTH-CGRectGetMaxX(_avator.frame)-20-20,
                                             _avator.height/2)
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:driver_acount];
    [_driverView addSubview:_driverNameLabel];
    
    _carNumLabel = [UILabel labelWithFrame:ccr(_driverNameLabel.x,
                                              CGRectGetMaxY(_driverNameLabel.frame),
                                              _driverNameLabel.width,
                                              _avator.height/2)
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:self.orderInfo.car_plate_number];
    [_driverView addSubview:_carNumLabel];
    
//    _carColorLabel = [UILabel labelWithFrame:ccr(SCREEN_WIDTH-70,
//                                                 _carNumLabel.y,
//                                                 30,
//                                                 15)
//                                       color:COLORRGB(0x000000)
//                                        font:HSFONT(15)
//                                        text:@""
//                                   alignment:NSTextAlignmentCenter
//                               numberOfLines:1];
//    _carColorLabel.layer.borderColor = COLORRGB(0xd7d7d7).CGColor;
//    _carColorLabel.layer.borderWidth = 0.5f;
//    _carColorLabel.layer.cornerRadius = 5.0f;
//    [_driverView addSubview:_carColorLabel];
    
    _carStyleLabel = [UILabel labelWithFrame:ccr(SCREEN_WIDTH-80,
                                                 _carNumLabel.y,
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
    
    _driverView.frame = ccr(0,
                            CGRectGetMaxY(_routeView.frame),
                            SCREEN_WIDTH,
                            CGRectGetMaxY(_avator.frame));
    return _driverView;
}

- (UIView *)chargeView
{
    if (!_chargeView) {
        _chargeView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    UILabel *changeTitleLabel = [UILabel labelWithFrame:ccr((SCREEN_WIDTH-70)/2, 0, 70, 20)
                                          color:COLORRGB(0xd7d7d7)
                                           font:HSFONT(12)
                                           text:@"费用详情"
                                      alignment:NSTextAlignmentCenter
                                  numberOfLines:1];
    [_chargeView addSubview:changeTitleLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:ccr(changeTitleLabel.x-5-50, 10, 50, 0.5)];
    leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:ccr(CGRectGetMaxX(changeTitleLabel.frame)+5, leftLine.y, leftLine.width, leftLine.height)];
    rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:rightLine];
    
    _priceLabel = [UILabel labelWithFrame:ccr(0,
                                              CGRectGetMaxY(changeTitleLabel.frame)+10,
                                              SCREEN_WIDTH,
                                              20)
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(13)
                                     text:@""
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [_chargeView addSubview:_priceLabel];
    
    _mileageLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [_chargeView addSubview:_mileageLabel];
    
    _mileageLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mileageLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_mileageLine];
    
    _mileagePrice = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentRight
                              numberOfLines:1];
    [_chargeView addSubview:_mileagePrice];
    
    _duringLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(13)
                                      text:@""
                                 alignment:NSTextAlignmentLeft
                             numberOfLines:1];
    [_chargeView addSubview:_duringLabel];
    
    _duringLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _duringLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_duringLine];
    
    _duringPrice = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(13)
                                    text:@""
                               alignment:NSTextAlignmentRight
                           numberOfLines:1];
    [_chargeView addSubview:_duringPrice];
    
//    _nightLabel = [UILabel labelWithFrame:CGRectZero
//                                           color:COLORRGB(0x000000)
//                                            font:HSFONT(13)
//                                            text:@"夜间服务"
//                                       alignment:NSTextAlignmentRight
//                                   numberOfLines:1];
//    [_chargeView addSubview:_nightLabel];
//    
//    _nightLine = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _nightLine.backgroundColor = COLORRGB(0xd7d7d7);
//    [_chargeView addSubview:_nightLine];
//    
//    NSString *times = [NSString stringWithFormat:@"%.1f倍",self.orderInfo.night_service_times];
//    _nightPrice = [UILabel labelWithFrame:CGRectZero
//                                     color:COLORRGB(0x000000)
//                                      font:HSFONT(13)
//                                      text:times
//                                 alignment:NSTextAlignmentRight
//                             numberOfLines:1];
//    [_chargeView addSubview:_nightPrice];
    
    
    _couponLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(13)
                                      text:@"优惠"
                                 alignment:NSTextAlignmentLeft
                             numberOfLines:1];
    [_chargeView addSubview:_couponLabel];
    
    _couponLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _couponLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_couponLine];
    
    _couponPrice = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(13)
                                      text:@""
                                 alignment:NSTextAlignmentRight
                             numberOfLines:1];
    [_chargeView addSubview:_couponPrice];
    
    _minPriceLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(13)
                                      text:@"最低消费"
                                 alignment:NSTextAlignmentLeft
                             numberOfLines:1];
    [_chargeView addSubview:_minPriceLabel];
    
    _minPriceLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _minPriceLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_minPriceLine];
    
    _minPrice = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(13)
                                      text:@""
                                 alignment:NSTextAlignmentRight
                             numberOfLines:1];
    [_chargeView addSubview:_minPrice];
    
    
    _payTypeLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0xf39a00)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [_chargeView addSubview:_payTypeLabel];
    
    _payLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _payLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_payLine];
    
    _payPrice = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0xf39a00)
                                   font:HSFONT(13)
                                   text:@""
                              alignment:NSTextAlignmentRight
                          numberOfLines:1];
    [_chargeView addSubview:_payPrice];
    
    _chargeView.frame = ccr(0, CGRectGetMaxY(_routeView.frame)+10, SCREEN_WIDTH, 200);
    return _chargeView;
}

- (UIView *)ratingView
{
    if (!_ratingView) {
        _ratingView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    UILabel *ratingTitleLabel = [UILabel labelWithFrame:ccr((SCREEN_WIDTH-70)/2, 0, 70, 20)
                                                  color:COLORRGB(0xd7d7d7)
                                                   font:HSFONT(12)
                                                   text:@"对司机评星"
                                              alignment:NSTextAlignmentCenter
                                          numberOfLines:1];
    [_ratingView addSubview:ratingTitleLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:ccr(ratingTitleLabel.x-5-50, 10, 50, 0.5)];
    leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_ratingView addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:ccr(CGRectGetMaxX(ratingTitleLabel.frame)+5, leftLine.y, leftLine.width, leftLine.height)];
    rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_ratingView addSubview:rightLine];
    
    self.starRating = [[ZBCStarRating alloc] initWithFrame:ccr((SCREEN_WIDTH-200)/2,
                                                               CGRectGetMaxY(ratingTitleLabel.frame)+10,
                                                               200,
                                                               40)];
    self.starRating.delegate = self;
    self.starRating.rating = 5.0;
    [_ratingView addSubview:self.starRating];
    
    UILabel *content = [UILabel labelWithFrame:ccr(0,
                                                   CGRectGetMaxY(self.starRating.frame),
                                                   SCREEN_WIDTH,
                                                   40)
                                         color:COLORRGB(0xf39a00)
                                          font:HSFONT(13)
                                          text:@"有了您的评价，我们会做得更好\n如果对我们司机不满意，请致电4009016008"
                                     alignment:NSTextAlignmentCenter
                                 numberOfLines:2];
    [_ratingView addSubview:content];
    _ratingView.frame = ccr(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, CGRectGetMaxY(content.frame));
    
    return _ratingView;
}

- (UIButton *)cashPayBtn
{
    UIButton *cashPayBtn = [UIButton buttonWithImageName:@"commbtn"
                                hlImageName:@"commbtn"
                                      title:@"现金支付完成"
                                 titleColor:COLORRGB(0xffffff)
                                       font:HSFONT(15)
                                 onTapBlock:^(UIButton *btn) {
                                 }];
    if (IS_BETTER_THAN_IPHONE_5) {
        cashPayBtn.frame = ccr((SCREEN_WIDTH-260)/2, SCREEN_HEIGHT - 50, 260, 40);
    } else {
        cashPayBtn.frame = ccr((SCREEN_WIDTH-260)/2, 600 - 50, 260, 40);
    }
    
    return cashPayBtn;
}

- (UIButton *)weixinPayBtn
{
    UIButton *weixinPayBtn = [UIButton buttonWithImageName:@"orgbtn"
                                hlImageName:@"orgbtn_pressed"
                                      title:@"微信支付"
                                 titleColor:COLORRGB(0xffffff)
                                       font:HSFONT(15)
                                 onTapBlock:^(UIButton *btn) {
                                     [self wechatPay];
                                 }];
    if (IS_BETTER_THAN_IPHONE_5) {
        weixinPayBtn.frame = ccr((SCREEN_WIDTH-260)/2, SCREEN_HEIGHT - 50, 260, 40);
    } else {
        weixinPayBtn.frame = ccr((SCREEN_WIDTH-260)/2, 600 - 50, 260, 40);
    }
    weixinPayBtn.enabled = YES;
    return weixinPayBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithImageName:@"orgbtn"
                                        hlImageName:@"orgbtn_pressed"
                                              title:@"分享至微信朋友圈"
                                         titleColor:COLORRGB(0xffffff)
                                               font:HSFONT(15)
                                         onTapBlock:^(UIButton *btn) {
                                             [self shareCoupon];
                                         }];
        if (IS_BETTER_THAN_IPHONE_5) {
            _shareBtn.frame = ccr((SCREEN_WIDTH-260)/2, SCREEN_HEIGHT - 50, 260, 40);
        } else {
            _shareBtn.frame = ccr((SCREEN_WIDTH-260)/2, 600 - 50, 260, 40);
        }
    }
    return _shareBtn;
}

- (void)shareCoupon
{
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *imgStr = [CouponStore sharedCouponStore].shareInfo.weixin_pic;
    NSData *img = [NSData dataWithContentsOfURL:URL(imgStr)];
    [message setThumbData:img];
    message.title = [CouponStore sharedCouponStore].shareInfo.weixin_title;
    message.description = [CouponStore sharedCouponStore].shareInfo.weixin_title;
    
    
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = [CouponStore sharedCouponStore].shareInfo.weixin_link;
    message.mediaObject = webObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

- (void)wechatPay
{
    NSString *res = @"";
    [self jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}

- (void)jumpToBizPay
{
    [[DuDuAPIClient sharedClient] GET:ORDER_WX_PAY(self.orderInfo.order_id) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        if ([dic[@"err"] intValue] == 0){
            time_t now;
            time(&now);
            NSString *timeString = [NSString stringWithFormat:@"%ld", now];
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = dic[@"info"][@"mch_id"];
            req.prepayId            = dic[@"info"][@"prepay_id"];
            req.nonceStr            = dic[@"info"][@"nonce_str" ];
            req.timeStamp           = [timeString intValue];
            req.package             = dic[@"info"][@"package"]?dic[@"info"][@"package"]:@"Sign=WXPay";
            
            NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
            [signParams setObject: dic[@"info"][@"appid"]        forKey:@"appid"];
            [signParams setObject: req.nonceStr    forKey:@"noncestr"];
            [signParams setObject: req.package      forKey:@"package"];
            [signParams setObject: req.partnerId        forKey:@"partnerid"];
            [signParams setObject: timeString   forKey:@"timestamp"];
            [signParams setObject: req.prepayId     forKey:@"prepayid"];
            
            req.sign                = [self createMd5Sign:signParams];
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",dic[@"info"][@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        } else{
            [ZBCToast showMessage:dic[@"info"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
//    NSString *urlString   = ADD(BASE_URL,[Utils urlWithToken:ORDER_WX_PAY(self.orderInfo.order_id)]);
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            if ([dict[@"err"] intValue] == 0){
////                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                time_t now;
//                time(&now);
//                NSString *timeString = [NSString stringWithFormat:@"%ld", now];
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = dict[@"info"][@"mch_id"];
//                req.prepayId            = dict[@"info"][@"prepay_id"];
//                req.nonceStr            = dict[@"info"][@"nonce_str" ];
//                req.timeStamp           = [timeString intValue];
//                req.package             = dict[@"info"][@"package"]?dict[@"info"][@"package"]:@"Sign=WXPay";
//                
//                NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
//                [signParams setObject: dict[@"info"][@"appid"]        forKey:@"appid"];
//                [signParams setObject: req.nonceStr    forKey:@"noncestr"];
//                [signParams setObject: req.package      forKey:@"package"];
//                [signParams setObject: req.partnerId        forKey:@"partnerid"];
//                [signParams setObject: timeString   forKey:@"timestamp"];
//                [signParams setObject: req.prepayId     forKey:@"prepayid"];
//                
//                req.sign                = [self createMd5Sign:signParams];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",dict[@"info"][@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                return @"";
//            } else{
//                return dict[@"info"][@"return_msg"];
//            }
//        } else {
//            return @"服务器返回错误，未获取到json对象";
//        }
//    } else {
//        return @"服务器返回错误";
//    }
}

- (void)paySuccessed:(BOOL)isSuccessed
{
    self.isHistory = YES;
    self.isForCharge = NO;
    _isPayed = YES;
    [self flushOrderStatus:nil];
    [[MainViewController sharedMainViewController] clearData];
    [[MainViewController sharedMainViewController] locateMapView];
}

- (NSString *)createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", SPKEY];
    //得到MD5 sign签名
    NSString *md5Sign =[WXUtil md5:contentString];
    
    return md5Sign;
}

#pragma mark - click event

- (void)didClickDetailButtonAction
{
    CheckDetailVC *checkDetailVC = [[CheckDetailVC alloc] init];
    checkDetailVC.title = @"查看明细";
    checkDetailVC.orderInfo = self.orderInfo;
    [self.navigationController pushViewController:checkDetailVC animated:YES];
}

- (void)sentRating:(float)rating
{
    [self showRightBarItem:YES withButton:nil];
    [[DuDuAPIClient sharedClient] GET:ORDER_EVALUATE((int)rating, self.orderInfo.order_id)
                           parameters:nil
                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                  self.orderInfo.evaluate_level = [NSNumber numberWithInt:(int)rating];
                                    [[OrderStore sharedOrderStore] updateHistoryModel:self.orderInfo at:self.modelIndex];
                                
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.starRating.rating = [self.orderInfo.evaluate_level floatValue];
    }];
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

#pragma mark - CommentVC delegate

- (void)didClickSubmitButtonWithComment:(NSString *)comment
{
}

#pragma mark - StarRating delegate
- (void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    if ([self.orderInfo.evaluate_level intValue] == 0) {
        UIButton *btn = [UIButton buttonWithImageName:nil hlImageName:nil title:@"提交评星" titleColor:COLORRGB(0x000000) onTapBlock:^(UIButton *btn) {
            [self sentRating:rating];
        }];
        [self showRightBarItem:YES withButton:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
