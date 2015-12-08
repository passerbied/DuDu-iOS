//
//  OrderVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/8.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "OrderVC.h"

@interface OrderVC ()
{
    UIView      *_headerView;
    UIImageView *_timeImage;
    UILabel     *_timeLabel;
    UIImageView *_startImage;
    UILabel     *_startLabel;
    UIImageView *_endImage;
    UILabel     *_endLabel;
    UIImageView *_timeBg;
    UILabel     *_numberLabel;
    UILabel     *_minuteLabel;
    UILabel     *_noticeLabel;
    UIImageView *_bottomLine;
}

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
}

- (void)createSubViews
{
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = COLORRGB(0xffffff);
    [self.view addSubview:_headerView];
    
    _timeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_headerView addSubview:_timeImage];
    
    _timeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [_headerView addSubview:_timeLabel];
    
    _startImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_headerView addSubview:_startImage];
    
    _startLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [_headerView addSubview:_startLabel];
    
    _endImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_headerView addSubview:_endImage];
    
    _endLabel = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0x000000)
                                   font:HSFONT(12)
                                   text:@""
                              alignment:NSTextAlignmentLeft
                          numberOfLines:1];
    [_headerView addSubview:_endLabel];
    
    _timeBg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_headerView addSubview:_timeBg];
    
    _numberLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(15)
                                      text:@""
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:1];
    [_timeBg addSubview:_numberLabel];
    
    _minuteLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0xd7d7d7)
                                      font:HSFONT(12)
                                      text:@"分钟"
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:1];
    [_timeBg addSubview:_minuteLabel];
    
    _noticeLabel = [UILabel labelWithFrame:CGRectZero
                                     color:[UIColor blueColor]
                                      font:HSFONT(15)
                                      text:@""
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:0];
    [self.view addSubview:_noticeLabel];
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_bottomLine];
    [self calculateFrame];
}

- (void)setData
{
    _timeImage.image = nil;
    _timeImage.backgroundColor = COLORRGB(0xd7d7d7);
    _timeLabel.text = @"今天 18:50";
    _startImage.image = IMG(@"tiny_circle_green");
    _startLabel.text = @"大连软件园23号楼";
    _endImage.image = IMG(@"tiny_circle_red");
    _endLabel.text = @"北京南站";
    _timeBg.image = nil;
    _timeBg.backgroundColor = COLORRGB(0xedad49);
    _numberLabel.text = @"8";
    _noticeLabel.text = @"正在通知海豹,海豹接单后会及时通知您";
}

- (void)calculateFrame
{
    [self setData];
    _timeImage.frame = ccr(10, 10, 16, 16);
    CGSize timeSize = [self getTextFromLabel:_timeLabel];
    _timeLabel.frame = ccr(CGRectGetMaxX(_timeImage.frame)+10,
                           _timeImage.origin.y,
                           timeSize.width,
                           timeSize.height);
    _startImage.frame = ccr(_timeImage.origin.x,
                            CGRectGetMaxY(_timeImage.frame)+10,
                            _timeImage.width,
                            _timeImage.height);
    CGSize startSize = [self getTextFromLabel:_startLabel];
    _startLabel.frame = ccr(_timeLabel.origin.x,
                            CGRectGetMaxY(_timeLabel.frame)+10,
                            startSize.width,
                            startSize.height);
    _endImage.frame = ccr(_startImage.origin.x,
                          CGRectGetMaxY(_startImage.frame)+10,
                          _startImage.width,
                          _startImage.height);
    CGSize endSize = [self getTextFromLabel:_endLabel];
    _endLabel.frame = ccr(_startLabel.origin.x,
                          CGRectGetMaxY(_startLabel.frame)+10,
                          endSize.width,
                          endSize.height);
    _headerView.frame = ccr(0,
                            NAV_BAR_HEIGHT_IOS7,
                            SCREEN_WIDTH,
                            CGRectGetMaxY(_endLabel.frame)+10);
    CGFloat bgSize = _headerView.height-15*2;
    _timeBg.frame = ccr(SCREEN_WIDTH-10-bgSize,
                        15,
                        bgSize,
                        bgSize);
    CGSize numberSize = [self getTextFromLabel:_numberLabel];
    CGSize minuteSize = [self getTextFromLabel:_minuteLabel];
    _numberLabel.frame = ccr((bgSize-numberSize.width)/2,
                             (bgSize-numberSize.height-minuteSize.height-5)/2,
                             numberSize.width,
                             numberSize.height);
    _minuteLabel.frame = ccr((bgSize-minuteSize.width)/2,
                             CGRectGetMaxY(_numberLabel.frame)+5,
                             minuteSize.width,
                             minuteSize.height);
    _bottomLine.frame = ccr(0,
                            CGRectGetMaxY(_headerView.frame)-0.5,
                            SCREEN_WIDTH,
                            0.5);
    CGSize noticeSize = [self getTextFromLabel:_noticeLabel];
    _noticeLabel.frame = ccr((SCREEN_WIDTH-noticeSize.width)/2,
                             CGRectGetMaxY(_headerView.frame)+30,
                             noticeSize.width,
                             noticeSize.height);
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
