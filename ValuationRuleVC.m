//
//  ValuationRuleVC.m
//  DuDu
//
//  Created by 教路浩 on 16/1/15.
//  Copyright © 2016年 i-chou. All rights reserved.
//

#import "ValuationRuleVC.h"

@interface ValuationRuleVC ()
{
    UIImageView *_carImage;
    UIImageView *_leftLine;
    UILabel     *_carTypeLabel;
    UIImageView *_rightLine;
    UILabel     *_startPriceLabel;
    UILabel     *_valuationRuleLabel;
    UILabel     *_perMinutePriceLabel;
    UILabel     *_lowestPriceLabel;
    UILabel     *_nightPriceLabel;
    UIImageView *_plusIcon;
}

@end

@implementation ValuationRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
}

- (void)createSubViews
{
    _carImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _carImage.image = IMG(@"icon_huge");
    [self.view addSubview:_carImage];
    
    _leftLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_leftLine];
    
    _carTypeLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentCenter
                              numberOfLines:1];
    [self.view addSubview:_carTypeLabel];
    
    _rightLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_rightLine];
    
    _startPriceLabel = [UILabel labelWithFrame:CGRectZero
                                         color:COLORRGB(0x000000)
                                          font:HSFONT(12)
                                          text:@""
                                     alignment:NSTextAlignmentCenter
                                 numberOfLines:1];
    [self.view addSubview:_startPriceLabel];
    
    _valuationRuleLabel = [UILabel labelWithFrame:CGRectZero
                                            color:COLORRGB(0x000000)
                                             font:HSFONT(12)
                                             text:@""
                                        alignment:NSTextAlignmentCenter
                                    numberOfLines:1];
    [self.view addSubview:_valuationRuleLabel];
    
    _perMinutePriceLabel = [UILabel labelWithFrame:CGRectZero
                                             color:COLORRGB(0x000000)
                                              font:HSFONT(12)
                                              text:@""
                                         alignment:NSTextAlignmentCenter
                                     numberOfLines:1];
    [self.view addSubview:_perMinutePriceLabel];
    
    _lowestPriceLabel = [UILabel labelWithFrame:CGRectZero
                                          color:COLORRGB(0x000000)
                                           font:HSFONT(12)
                                           text:@""
                                      alignment:NSTextAlignmentCenter
                                  numberOfLines:1];
    [self.view addSubview:_lowestPriceLabel];
    
    _nightPriceLabel = [UILabel labelWithFrame:CGRectZero
                                         color:COLORRGB(0x939393)
                                          font:HSFONT(12)
                                          text:@""
                                     alignment:NSTextAlignmentCenter
                                 numberOfLines:1];
    [self.view addSubview:_nightPriceLabel];
    
    [self calculateFrame];
}

- (void)setData
{
    _carTypeLabel.text = [NSString stringWithFormat:@"车型：%@",self.carStyle.car_style_name];
    _startPriceLabel.text = @"0元起步费";
    _valuationRuleLabel.text = [NSString stringWithFormat:@"%.1f元/公里(%d公里以上时，%.1f元/公里)",self.carStyle.per_kilometer_money,(int)self.carStyle.per_max_kilometer,self.carStyle.per_max_kilometer_money];
    _perMinutePriceLabel.text = [NSString stringWithFormat:@"%.1f元/分钟",self.carStyle.wait_time_money];
    _lowestPriceLabel.text = [NSString stringWithFormat:@"%.1f元最低消费",self.carStyle.start_money];
    _nightPriceLabel.text = [NSString stringWithFormat:@"夜间10点之后%@倍价格",self.carStyle.night_service_times];
}

- (void)calculateFrame
{
    [self setData];
    _carImage.frame = ccr((SCREEN_WIDTH-100)/2,
                          NAV_BAR_HEIGHT_IOS7+20,
                          100,
                          100);
    CGSize typeSize = [self getTextFromLabel:_carTypeLabel];
    _leftLine.frame = ccr(50,
                          CGRectGetMaxY(_carImage.frame)+20+(typeSize.height-0.5)/2,
                          (SCREEN_WIDTH-50*2-typeSize.width-5)/2,
                          0.5);
    _carTypeLabel.frame = ccr(CGRectGetMaxX(_leftLine.frame)+5,
                              CGRectGetMaxY(_carImage.frame)+20,
                              typeSize.width,
                              typeSize.height);
    _rightLine.frame = ccr(CGRectGetMaxX(_carTypeLabel.frame)+5,
                           _leftLine.origin.y,
                           _leftLine.width,
                           _leftLine.height);
    CGSize startSize = [self getTextFromLabel:_startPriceLabel];
    _startPriceLabel.frame = ccr((SCREEN_WIDTH-startSize.width)/2,
                                 CGRectGetMaxY(_carTypeLabel.frame)+20,
                                 startSize.width,
                                 startSize.height);
    
    UIImageView *plusIcon1 = [[UIImageView alloc] initWithFrame:ccr((SCREEN_WIDTH-10)/2, CGRectGetMaxY(_startPriceLabel.frame)+15, 10, 10)];
    plusIcon1.image = IMG(@"plus64");
    [self.view addSubview:plusIcon1];
    
    CGSize ruleSize = [self getTextFromLabel:_valuationRuleLabel];
    _valuationRuleLabel.frame = ccr((SCREEN_WIDTH-ruleSize.width)/2,
                                    CGRectGetMaxY(_startPriceLabel.frame)+40,
                                    ruleSize.width,
                                    ruleSize.height);
    
    UIImageView *plusIcon2 = [[UIImageView alloc] initWithFrame:ccr((SCREEN_WIDTH-10)/2, CGRectGetMaxY(_valuationRuleLabel.frame)+15, 10, 10)];
    plusIcon2.image = IMG(@"plus64");
    [self.view addSubview:plusIcon2];
    
    CGSize perSize = [self getTextFromLabel:_perMinutePriceLabel];
    _perMinutePriceLabel.frame = ccr((SCREEN_WIDTH-perSize.width)/2,
                                     CGRectGetMaxY(_valuationRuleLabel.frame)+40,
                                     perSize.width,
                                     perSize.height);
    
    UIImageView *plusIcon3 = [[UIImageView alloc] initWithFrame:ccr((SCREEN_WIDTH-10)/2, CGRectGetMaxY(_perMinutePriceLabel.frame)+15, 10, 10)];
    plusIcon3.image = IMG(@"plus64");
    [self.view addSubview:plusIcon3];
    
    CGSize lowSize = [self getTextFromLabel:_lowestPriceLabel];
    _lowestPriceLabel.frame = ccr((SCREEN_WIDTH-lowSize.width)/2,
                                  CGRectGetMaxY(_perMinutePriceLabel.frame)+40,
                                  lowSize.width,
                                  lowSize.height);
    
    CGSize nightSize = [self getTextFromLabel:_nightPriceLabel];
    _nightPriceLabel.frame = ccr((SCREEN_WIDTH-nightSize.width)/2,
                                 CGRectGetMaxY(_lowestPriceLabel.frame)+40,
                                 nightSize.width,
                                 nightSize.height);

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
