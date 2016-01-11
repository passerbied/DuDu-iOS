//
//  RouteDetailVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RouteDetailVC.h"
#import "CheckDetailVC.h"

@interface RouteDetailVC ()
{
    UIView      *_routeView;
    UILabel     *_timeLabel;
    UILabel     *_startLabel;
    UILabel     *_endLabel;
    
    UIView      *_driverView;
    UIImageView *_avator;
    UILabel     *_driverNameLabel;
    UILabel     *_carNumLabel;
    UILabel     *_carStyleLabel;
    UILabel     *_carColorLabel;
    
    UIView      *_chargeView;
    UILabel     *_priceLabel;
    UILabel     *_mileageLabel;
    UILabel     *_duringLabel;
    UILabel     *_couponLabel;
    UILabel     *_mileagePrice;
    UILabel     *_duringPrice;
    UILabel     *_couponPrice;
    UIImageView *_mileageLine;
    UIImageView *_duringLine;
    UIImageView *_couponLine;
    UILabel     *_payTypeLabel;
    UILabel     *_payPrice;
    UIImageView *_payLine;
    
    UIView      *_ratingView;
    
    UIButton    *_payBtn;
    
    BOOL        _isRatingChanged;
}

@end

@implementation RouteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
    [self flushOrderStatus];
}

- (void)createSubViews
{
    [self.view addSubview:[self routeView]];
    [self.view addSubview:[self driverView]];
    [self.view addSubview:[self chargeView]];
    [self.view addSubview:[self ratingView]];
    [self.view addSubview:[self payBtn]];
    
    _driverView.alpha = 0;
    _payBtn.alpha = 0;
    _ratingView.alpha = 0;
    
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
                          _mileageLine.height);
    
    CGSize couponSize = [self getTextFromLabel:_couponLabel];
    _couponLabel.frame = ccr(_duringLabel.origin.x,
                             CGRectGetMaxY(_duringLabel.frame)+5,
                             couponSize.width,
                             couponSize.height);
    CGSize couponTitleSize = [self getTextFromLabel:_couponPrice];
    _couponPrice.frame = ccr(SCREEN_WIDTH-20-couponTitleSize.width,
                             CGRectGetMaxY(_duringPrice.frame)+5,
                             couponTitleSize.width,
                             couponTitleSize.height);
    _couponLine.frame = ccr(CGRectGetMaxX(_couponLabel.frame)+5,
                            CGRectGetMaxY(_couponLabel.frame)-couponTitleSize.height/2,
                            _couponPrice.origin.x-5*2-CGRectGetMaxX(_couponLabel.
                                                                    frame),
                            _duringLine.height);
    
    CGSize payTypeSize = [self getTextFromLabel:_payTypeLabel];
    _payTypeLabel.frame = ccr(_couponLabel.origin.x,
                              CGRectGetMaxY(_couponLabel.frame)+10,
                              payTypeSize.width,
                              payTypeSize.height);
    CGSize payPriceSize = [self getTextFromLabel:_payPrice];
    _payPrice.frame = ccr(SCREEN_WIDTH-20-payPriceSize.width,
                          CGRectGetMaxY(_couponPrice.frame)+10,
                          payPriceSize.width,
                          payPriceSize.height);
    _payLine.frame = ccr(CGRectGetMaxX(_payTypeLabel.frame)+5,
                         CGRectGetMaxY(_payTypeLabel.frame)-payTypeSize.
                         height/2,
                         _payPrice.origin.x-5*2-CGRectGetMaxX(_payTypeLabel
                                                              .frame),
                         _couponLine.height);
    _chargeView.height = CGRectGetMaxY(_payLine.frame);
    
    _driverView.alpha = 1;
    _chargeView.y = CGRectGetMaxY(_driverView.frame)+10;
    _ratingView.y = CGRectGetMaxY(_chargeView.frame)+30;
    
    if(self.isForCharge) {
        _payBtn.alpha = 1;
    } else {
        _ratingView.alpha = 1;
    }
    
}

- (void)flushOrderStatus
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:FLUSH_ORDER_STATUS([self.orderInfo.order_id intValue]) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        OrderModel *flushedInfo = [MTLJSONAdapter modelOfClass:[OrderModel class]
                                       fromJSONDictionary:dic[@"info"]
                                                    error:nil];
        if (flushedInfo) {
            self.orderInfo.car_position_id = flushedInfo.car_position_id;
            self.orderInfo.car_color = flushedInfo.car_color;
            self.orderInfo.car_plate_number = flushedInfo.car_plate_number;
            self.orderInfo.driver_nickname = flushedInfo.driver_nickname;
            self.orderInfo.driver_telephone = flushedInfo.driver_telephone;
            self.orderInfo.driver_photo = flushedInfo.driver_photo;
            self.orderInfo.order_status = flushedInfo.order_status;
            self.orderInfo.car_brand = flushedInfo.car_brand;
            self.orderInfo.order_initiate_rate = flushedInfo.order_initiate_rate;
            self.orderInfo.order_mileage = flushedInfo.order_mileage;
            self.orderInfo.order_mileage_money = flushedInfo.order_mileage_money;
            self.orderInfo.order_duration_money = flushedInfo.order_duration_money;
            self.orderInfo.order_allTime = flushedInfo.order_allTime;
            self.orderInfo.order_allMoney = flushedInfo.order_allMoney;
            self.orderInfo.location = flushedInfo.location;
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
    _carStyleLabel.text = [NSString stringWithFormat:@"%@ %@",self.orderInfo.car_color, self.orderInfo.car_brand];
    _carColorLabel.text = self.orderInfo.car_color;
    
    _driverNameLabel.text = [NSString stringWithFormat:@"%@(%@)",self.orderInfo.driver_nickname,self.orderInfo.driver_telephone];
    _carNumLabel.text = self.orderInfo.car_plate_number;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@元",self.orderInfo.order_allMoney];
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
    NSUInteger priceLength = _priceLabel.text.length-1;
    [priceString addAttributes:@{NSFontAttributeName:HSFONT(20)}
                         range:NSMakeRange(0, priceLength)];
    _priceLabel.attributedText = priceString;
    
    float mileage = [self.orderInfo.order_mileage floatValue];
    _mileageLabel.text = [NSString stringWithFormat:@"里程(%.2f公里)",mileage];
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
    _payTypeLabel.text = self.orderInfo.order_payStatus_str;
    _payPrice.text = [NSString stringWithFormat:@"%.1f元",-[self.orderInfo.order_allMoney floatValue]];
    
    self.starRating.editable = ([self.orderInfo.order_status intValue] == 5 && [self.orderInfo.evaluate_level floatValue]==0); //只有已付款并且没评过星的才可以评星
    self.starRating.rating = [self.orderInfo.evaluate_level floatValue];
    
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
    _carStyleLabel.layer.borderColor = COLORRGB(0xff8830).CGColor;
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
                                     font:HSFONT(20)
                                     text:@""
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [_chargeView addSubview:_priceLabel];
    
    //    _startLabel = [UILabel labelWithFrame:CGRectZero
    //                                    color:COLORRGB(0x000000)
    //                                     font:HSFONT(13)
    //                                     text:@"起步价"
    //                                alignment:NSTextAlignmentLeft
    //                            numberOfLines:1];
    //    [chargeView addSubview:_startLabel];
    //
    //    _startLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    //    _startLine.backgroundColor = COLORRGB(0xd7d7d7);
    //    [chargeView addSubview:_startLine];
    //
    //    _startPrice = [UILabel labelWithFrame:CGRectZero
    //                                    color:COLORRGB(0x000000)
    //                                     font:HSFONT(13)
    //                                     text:@""
    //                                alignment:NSTextAlignmentRight
    //                            numberOfLines:1];
    //    [chargeView addSubview:_startPrice];
    
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
    
    
    _payTypeLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0xff8830)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [_chargeView addSubview:_payTypeLabel];
    
    _payLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _payLine.backgroundColor = COLORRGB(0xd7d7d7);
    [_chargeView addSubview:_payLine];
    
    _payPrice = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0xff8830)
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
                                                               CGRectGetMaxY(ratingTitleLabel.frame)+20,
                                                               200,
                                                               40)];
    self.starRating.delegate = self;
    [_ratingView addSubview:self.starRating];
    _ratingView.frame = ccr(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, CGRectGetMaxY(self.starRating.frame));
    
    return _ratingView;
}

- (UIButton *)payBtn
{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithImageName:@"orgbtn"
                                    hlImageName:@"orgbtn_pressed"
                                          title:@"微信支付"
                                     titleColor:COLORRGB(0xffffff)
                                           font:HSFONT(15)
                                     onTapBlock:^(UIButton *btn) {
                                         
                                     }];
        _payBtn.frame = ccr((SCREEN_WIDTH-260)/2, SCREEN_HEIGHT - 50, 260, 40);
    }
    return _payBtn;
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
    if (self.starRating.rating == 0) {
        [self sentRating:rating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
