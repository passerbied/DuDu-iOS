//
//  CheckDetailVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "CheckDetailVC.h"

@interface CheckDetailVC ()
{
    UIImageView *_leftLine;
    UILabel     *_detailLabel;
    UIImageView *_rightLine;
    UILabel     *_priceLabel;
    
//    UILabel     *_startLabel;
    UILabel     *_mileageLabel;
    UILabel     *_timeLabel;
    UILabel     *_couponLabel;
//    UILabel     *_startPrice;
    UILabel     *_mileagePrice;
    UILabel     *_timePrice;
    UILabel     *_couponPrice;
//    UIImageView *_startLine;
    UIImageView *_mileageLine;
    UIImageView *_timeLine;
    UIImageView *_couponLine;
    
    UILabel     *_payTypeLabel;
    UILabel     *_payPrice;
    UIImageView *_payLine;
}

@end

@implementation CheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
}

- (void)createSubViews
{
    _leftLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_leftLine];
    
    _detailLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0xd7d7d7)
                                      font:HSFONT(12)
                                      text:@"车费详情"
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:1];
    [self.view addSubview:_detailLabel];
    
    _rightLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_rightLine];
    
    _priceLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(20)
                                     text:@""
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [self.view addSubview:_priceLabel];
    
//    _startLabel = [UILabel labelWithFrame:CGRectZero
//                                    color:COLORRGB(0x000000)
//                                     font:HSFONT(13)
//                                     text:@"起步价"
//                                alignment:NSTextAlignmentLeft
//                            numberOfLines:1];
//    [self.view addSubview:_startLabel];
//    
//    _startLine = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _startLine.backgroundColor = COLORRGB(0xd7d7d7);
//    [self.view addSubview:_startLine];
//    
//    _startPrice = [UILabel labelWithFrame:CGRectZero
//                                    color:COLORRGB(0x000000)
//                                     font:HSFONT(13)
//                                     text:@""
//                                alignment:NSTextAlignmentRight
//                            numberOfLines:1];
//    [self.view addSubview:_startPrice];
    
    _mileageLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.view addSubview:_mileageLabel];
    
    _mileageLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mileageLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_mileageLine];
    
    _mileagePrice = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentRight
                              numberOfLines:1];
    [self.view addSubview:_mileagePrice];
    
    _timeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(13)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.view addSubview:_timeLabel];
    
    _timeLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _timeLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_timeLine];
    
    _timePrice = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(13)
                                    text:@""
                               alignment:NSTextAlignmentRight
                           numberOfLines:1];
    [self.view addSubview:_timePrice];
    
    
    _couponLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(13)
                                    text:@"优惠"
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.view addSubview:_couponLabel];
    
    _couponLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _couponLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_couponLine];
    
    _couponPrice = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(13)
                                    text:@""
                               alignment:NSTextAlignmentRight
                           numberOfLines:1];
    [self.view addSubview:_couponPrice];
    
    
    _payTypeLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0xedad49)
                                       font:HSFONT(13)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.view addSubview:_payTypeLabel];
    
    _payLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _payLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_payLine];
    
    _payPrice = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0xedad49)
                                   font:HSFONT(13)
                                   text:@""
                              alignment:NSTextAlignmentRight
                          numberOfLines:1];
    [self.view addSubview:_payPrice];
    [self calculateFrame];
}

- (void)setData
{
    float price = [self.orderInfo.order_allMoney floatValue];
    _priceLabel.text = [NSString stringWithFormat:@"%.1f元",price];
//    float startPrice = [self.orderInfo.order_initiate_rate floatValue];
//    _startPrice.text = [NSString stringWithFormat:@"%.1f元",startPrice];
    float mileage = [self.orderInfo.order_mileage floatValue];
    _mileageLabel.text = [NSString stringWithFormat:@"里程(%.2f公里)",mileage];
    float mileagePrice = [self.orderInfo.order_mileage_money floatValue];
    _mileagePrice.text = [NSString stringWithFormat:@"%.1f元",mileagePrice];
    int time = [self.orderInfo.order_allTime intValue];
    _timeLabel.text = [NSString stringWithFormat:@"时长费(%d分钟)",time];
    float timePrice = [self.orderInfo.order_duration_money floatValue];
    _timePrice.text = [NSString stringWithFormat:@"%.1f元",timePrice];
    float couponPrice = 0;//[self.orderInfo.coupon_discount floatValue];
    if (couponPrice<1) {
        _couponLabel.text = @"打折优惠";
        _couponPrice.text = [NSString stringWithFormat:@"%.2f折",couponPrice];
    } else {
        _couponLabel.text = @"满减优惠";
        _couponPrice.text = [NSString stringWithFormat:@"%.1f元",couponPrice];
    }
    _payTypeLabel.text = self.orderInfo.order_payStatus_str;
    float payPrice = -price;
    _payPrice.text = [NSString stringWithFormat:@"%.1f元",payPrice];
}

- (void)calculateFrame
{
    [self setData];
    CGSize detailSize = [self getTextFromLabel:_detailLabel];
    CGFloat lineLength = (SCREEN_WIDTH-detailSize.width-5*2)/4;
    _leftLine.frame = ccr(lineLength,
                          NAV_BAR_HEIGHT_IOS7+40+detailSize.height/2,
                          lineLength,
                          0.5);
    _detailLabel.frame = ccr(CGRectGetMaxX(_leftLine.frame)+5,
                             NAV_BAR_HEIGHT_IOS7+40,
                             detailSize.width,
                             detailSize.height);
    _rightLine.frame = ccr(CGRectGetMaxX(_detailLabel.frame)+5,
                           _leftLine.origin.y,
                           _leftLine.width,
                           _leftLine.height);
    CGSize priceSize = [self getTextFromLabel:_priceLabel];
    _priceLabel.frame = ccr((SCREEN_WIDTH-priceSize.width)/2,
                            CGRectGetMaxY(_detailLabel.frame)+50,
                            priceSize.width,
                            priceSize.height);
//    CGSize startSize = [self getTextFromLabel:_startLabel];
//    _startLabel.frame = ccr(50,
//                            CGRectGetMaxY(_priceLabel.frame)+20,
//                            startSize.width,
//                            startSize.height);
//    CGSize startPriceSize = [self getTextFromLabel:_startPrice];
//    _startPrice.frame = ccr(SCREEN_WIDTH-50-startPriceSize.width,
//                            _startLabel.origin.y,
//                            startPriceSize.width,
//                            startPriceSize.height);
//    _startLine.frame = ccr(CGRectGetMaxX(_startLabel.frame)+5,
//                           CGRectGetMaxY(_startLabel.frame)-startSize.
//                           height/2,
//                           _startPrice.origin.x-5*2-CGRectGetMaxX
//                           (_startLabel.frame),
//                           0.5);
    CGSize mileageSize = [self getTextFromLabel:_mileageLabel];
    _mileageLabel.frame = ccr(50,
                              CGRectGetMaxY(_priceLabel.frame)+15,
                              mileageSize.width,
                              mileageSize.height);
    CGSize mileagePriceSize = [self getTextFromLabel:_mileagePrice];
    _mileagePrice.frame = ccr(SCREEN_WIDTH-50-mileagePriceSize.width,
                              _mileageLabel.y,
                              mileagePriceSize.width,
                              mileagePriceSize.height);
    _mileageLine.frame = ccr(CGRectGetMaxX(_mileageLabel.frame)+5,
                             CGRectGetMaxY(_mileageLabel.frame)-mileageSize
                             .height/2,
                             _mileagePrice.origin.x-5*2-CGRectGetMaxX
                             (_mileageLabel.frame),
                             0.5);
    CGSize timeSize = [self getTextFromLabel:_timeLabel];
    _timeLabel.frame = ccr(_mileageLabel.origin.x,
                           CGRectGetMaxY(_mileageLabel.frame)+5,
                           timeSize.width,
                           timeSize.height);
    CGSize timePriceSize = [self getTextFromLabel:_timePrice];
    _timePrice.frame = ccr(SCREEN_WIDTH-50-timePriceSize.width,
                           CGRectGetMaxY(_mileagePrice.frame)+5,
                           timePriceSize.width,
                           timePriceSize.height);
    _timeLine.frame = ccr(CGRectGetMaxX(_timeLabel.frame)+5,
                          CGRectGetMaxY(_timeLabel.frame)-timeSize.height/2
                          ,
                          _timePrice.origin.x-5*2-CGRectGetMaxX(_timeLabel.
                                                                frame),
                          _mileageLine.height);
    
    CGSize couponSize = [self getTextFromLabel:_couponLabel];
    _couponLabel.frame = ccr(_timeLabel.origin.x,
                             CGRectGetMaxY(_timeLabel.frame)+5,
                             couponSize.width,
                             couponSize.height);
    CGSize couponTitleSize = [self getTextFromLabel:_couponPrice];
    _couponPrice.frame = ccr(SCREEN_WIDTH-50-couponTitleSize.width,
                             CGRectGetMaxY(_timePrice.frame)+5,
                             couponTitleSize.width,
                             couponTitleSize.height);
    _couponLine.frame = ccr(CGRectGetMaxX(_couponLabel.frame)+5,
                            CGRectGetMaxY(_couponLabel.frame)-couponTitleSize.height/2,
                            _couponPrice.origin.x-5*2-CGRectGetMaxX(_couponLabel.
                                                                frame),
                            _timeLine.height);
    
    CGSize payTypeSize = [self getTextFromLabel:_payTypeLabel];
    _payTypeLabel.frame = ccr(_couponLabel.origin.x,
                              CGRectGetMaxY(_couponLabel.frame)+10,
                              payTypeSize.width,
                              payTypeSize.height);
    CGSize payPriceSize = [self getTextFromLabel:_payPrice];
    _payPrice.frame = ccr(SCREEN_WIDTH-50-payPriceSize.width,
                          CGRectGetMaxY(_couponPrice.frame)+10,
                          payPriceSize.width,
                          payPriceSize.height);
    _payLine.frame = ccr(CGRectGetMaxX(_payTypeLabel.frame)+5,
                         CGRectGetMaxY(_payTypeLabel.frame)-payTypeSize.
                         height/2,
                         _payPrice.origin.x-5*2-CGRectGetMaxX(_payTypeLabel
                                                              .frame),
                         _couponLine.height);
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
