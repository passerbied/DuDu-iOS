//
//  BottomToolBar.m
//  DuDu
//
//  Created by i-chou on 11/7/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#define PADDING 10

#import "BottomToolBar.h"

@implementation BottomToolBar
{
    UIButton *_closeBtn;
    UIView *_timeView;
    UIView *_locationView;
    BOOL _is_time_showing;
    BOOL _is_chargeView_showing;
    UIButton *_fromAddressBtn;
    UIButton *_toAddressBtn;
    UIView *_budgetView;
    UIButton *_submitBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 5;
//        self.layer.masksToBounds = YES;
        
        _timeView = [[UIView alloc] initWithFrame:ccr(0, 16, self.width, 50)];
        _timeView.backgroundColor = [UIColor whiteColor];
        _timeView.alpha = 0;
        [self addSubview:_timeView];
        
        UILabel *time_title = [UILabel labelWithFrame:ccr(0, PADDING, self.width, 12)
                                                color:COLORRGB(0xdddddd)
                                                 font:HSFONT(12)
                                                 text:@"出发时间"
                                            alignment:NSTextAlignmentCenter
                                        numberOfLines:1];
        [_timeView addSubview:time_title];
        
        
        self.startTimeLabel = [UILabel labelWithFrame:ccr(0,
                                                          CGRectGetMaxY(time_title.frame),
                                                          self.width,
                                                          30)
                                                color:COLORRGB(0x63666b)
                                                 font:HSFONT(15)
                                                 text:@"现在"
                                            alignment:NSTextAlignmentCenter
                                        numberOfLines:1];
        [_timeView addSubview:self.startTimeLabel];
        
        UIButton *time_btn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.startTimeLabel];
            }
        }];
        time_btn.frame = self.startTimeLabel.frame;
        [_timeView addSubview:time_btn];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:ccr(
                                                                    PADDING,
                                                                    _timeView.height-0.5,
                                                                    self.width-PADDING*2,
                                                                    0.5)];
        line1.backgroundColor = COLORRGB(0xdddddd);
        [_timeView addSubview:line1];
        
        _locationView = [[UIView alloc] initWithFrame:ccr(0,
                                                          0,
                                                          self.width,
                                                          88)];
        _locationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_locationView];
        
        UIImageView *fromIcon = [[UIImageView alloc] initWithFrame:ccr(PADDING,
                                                                       (44-17)/2,
                                                                       17,
                                                                       17)];
        fromIcon.image = IMG(@"tiny_circle_red");
        [_locationView addSubview:fromIcon];
        
        self.fromAddressLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(fromIcon.frame)+PADDING,
                                                            0,
                                                            _locationView.width-PADDING*2-fromIcon.width,
                                                            44)
                                                  color:COLORRGB(0x63666b)
                                                   font:HSFONT(15)
                                                   text:@"蓝戴时空汇"];
        [_locationView addSubview:self.fromAddressLabel];
        
        _fromAddressBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.fromAddressLabel];
            }
        }];
        self.fromAddressLabel.userInteractionEnabled = YES;
        _fromAddressBtn.frame = ccr(self.fromAddressLabel.x,self.fromAddressLabel.y,self.fromAddressLabel.width,44);
        [_locationView addSubview:_fromAddressBtn];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:ccr(
                                                                    PADDING,
                                                                    CGRectGetMaxY(self.fromAddressLabel.frame)-0.5,
                                                                    self.width-PADDING*2,
                                                                    0.5)];
        line2.backgroundColor = COLORRGB(0xdddddd);
        [_locationView addSubview:line2];
        
        UIImageView *toIcon = [[UIImageView alloc] initWithFrame:ccr(PADDING,
                                                                     CGRectGetMaxY(line2.frame)+(44-17)/2,
                                                                     17,
                                                                     17)];
        toIcon.image = IMG(@"tiny_circle_green");
        [_locationView addSubview:toIcon];
        
        self.toAddressLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(toIcon.frame)+PADDING,
                                                            CGRectGetMaxY(line2.frame),
                                                            _locationView.width-PADDING*2-toIcon.width,
                                                            44)
                                                  color:COLORRGB(0xff8830)
                                                   font:HSFONT(15)
                                                   text:@"你要去哪儿"];
        [_locationView addSubview:self.toAddressLabel];
        self.toAddressLabel.userInteractionEnabled = YES;
        
        _toAddressBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.toAddressLabel];
            }
        }];
        _toAddressBtn.frame = ccr(self.toAddressLabel.x,self.toAddressLabel.y,self.toAddressLabel.width,44);
        [_locationView addSubview:_toAddressBtn];
        
        _closeBtn = [UIButton buttonWithImageName:@"arrow_up"
                                      hlImageName:@"arrow_up_pressed"
                                       onTapBlock:^(UIButton *btn) {
                                           [self showTimeLabel:!_is_time_showing];
                                       }];
        _closeBtn.frame = ccr(self.width-32-PADDING, (self.height-32)/2, 32, 32);
        [self addSubview:_closeBtn];
        
        _budgetView = [[UIView alloc] initWithFrame:ccr(0, CGRectGetMaxY(_locationView.frame), _locationView.width, 44)];
        _budgetView.backgroundColor = [UIColor whiteColor];
        _budgetView.alpha = 0;
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:ccr(
                                                                    PADDING,
                                                                    0,
                                                                    self.width-PADDING*2,
                                                                    0.5)];
        line3.backgroundColor = COLORRGB(0xdddddd);
        [_budgetView addSubview:line3];
        
        self.budgetLabel = [UILabel labelWithFrame:ccr(0, 3, _budgetView.width, 22)
                                             color:COLORRGB(0xff8830)
                                              font:HSFONT(20)
                                              text:@"约 0 元"
                                         alignment:NSTextAlignmentCenter
                                     numberOfLines:1];
        [_budgetView addSubview:self.budgetLabel];
        
        self.couponLabel = [UILabel labelWithFrame:ccr(0, CGRectGetMaxY(self.budgetLabel.frame), _budgetView.width, 20) color:COLORRGB(0xff8830) font:HSFONT(12) text:@"豪华年度代金券立减69元" alignment:NSTextAlignmentCenter numberOfLines:1];
        [_budgetView addSubview:self.couponLabel];
        
        UIButton *coupenBtn = [UIButton buttonWithImageName:@"" hlImageName:@"" onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.couponLabel];
            }
        }];
        self.couponLabel.userInteractionEnabled = YES;
        coupenBtn.frame = ccr(self.couponLabel.x,self.couponLabel.y,self.couponLabel.width,self.couponLabel.height);
        [_budgetView addSubview:coupenBtn];
        
        [self addSubview:_budgetView];
        
        _submitBtn = [UIButton buttonWithImageName:@"orgbtn" hlImageName:@"orgbtn_pressed" title:@"发送订单" titleColor:COLORRGB(0xffffff) font:HSFONT(15) onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(didSubmited)]) {
                [self.delegate didSubmited];
            }
        }];
        _submitBtn.frame = ccr(0, CGRectGetMaxY(_budgetView.frame) + PADDING, _budgetView.width, 40);
        _submitBtn.alpha = 0;
        [self addSubview:_submitBtn];
    }
    return self;
}

- (void)showChargeView:(BOOL)show
{
    _is_chargeView_showing = show;
    if (_is_time_showing) {
        if (show) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = ccr(PADDING,
                                 SCREEN_HEIGHT- 198 - PADDING - (PADDING + 40),
                                 SCREEN_WIDTH-PADDING*2,
                                 198+(PADDING + 40));
                _budgetView.y = CGRectGetMaxY(_locationView.frame);
                _submitBtn.y = CGRectGetMaxY(_budgetView.frame)+PADDING;
                _budgetView.alpha = 1;
                _submitBtn.alpha = 1;
            }];
        } else {
                [UIView animateWithDuration:0.3 animations:^{
                    _budgetView.alpha = 0;
                    _submitBtn.alpha = 0;
                    self.frame = ccr(PADDING,
                                     SCREEN_HEIGHT-154-PADDING,
                                     SCREEN_WIDTH-PADDING*2,
                                     154);
                }];
        }
    } else {
        if (show) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = ccr(PADDING,
                                 SCREEN_HEIGHT- (88+40) - PADDING - (PADDING + 40),
                                 SCREEN_WIDTH-PADDING*2,
                                 (88+40) + (PADDING + 40));
                _budgetView.alpha = 1;
                _submitBtn.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _budgetView.alpha = 0;
                _submitBtn.alpha = 0;
                self.frame = ccr(PADDING,
                                 SCREEN_HEIGHT-88-PADDING,
                                 SCREEN_WIDTH-PADDING*2,
                                 88);
            }];
        }
    }
    
}

- (void)showTimeLabel:(BOOL)show
{
    _is_time_showing = show;
    if (_is_chargeView_showing) {
        if (show) {
            [UIView animateWithDuration:0.3 animations:^{
                _closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.3 animations:^{
                    _timeView.alpha = 1;
                    self.frame = ccr(PADDING,
                                     SCREEN_HEIGHT- 198 - PADDING - (PADDING + 40),
                                     SCREEN_WIDTH-PADDING*2,
                                     198+(PADDING + 40));
                    _locationView.frame = ccr(0,
                                              CGRectGetMaxY(_timeView.frame),
                                              self.width,
                                              88);
                    _budgetView.y = CGRectGetMaxY(_locationView.frame);
                    _submitBtn.y = CGRectGetMaxY(_budgetView.frame)+PADDING;
                    _closeBtn.y = 0;
                }];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _closeBtn.transform = CGAffineTransformMakeRotation(M_PI*2);
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.3 animations:^{
                    _timeView.alpha = 0;
                    self.frame = ccr(PADDING,
                                     SCREEN_HEIGHT-(88+44)-PADDING-(PADDING+40),
                                     SCREEN_WIDTH-PADDING*2,
                                     88+44+(PADDING+40));
                    _locationView.frame = ccr(0,
                                              0,
                                              self.width,
                                              88);
                    _budgetView.y = CGRectGetMaxY(_locationView.frame);
                    _submitBtn.y = CGRectGetMaxY(_budgetView.frame)+PADDING;
                    _closeBtn.y = (self.height-32-(PADDING+40)-44)/2;
                }];
            }];
        }
    } else {
        if (show) {
            [UIView animateWithDuration:0.3 animations:^{
                _closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.3 animations:^{
                    _timeView.alpha = 1;
                    self.frame = ccr(PADDING,
                                     SCREEN_HEIGHT-154-PADDING,
                                     SCREEN_WIDTH-PADDING*2,
                                     154);
                    _locationView.frame = ccr(0,
                                              CGRectGetMaxY(_timeView.frame),
                                              self.width,
                                              88);
                    _closeBtn.y = 0;
                }];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _closeBtn.transform = CGAffineTransformMakeRotation(M_PI*2);
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.3 animations:^{
                    _timeView.alpha = 0;
                    self.frame = ccr(PADDING,
                                     SCREEN_HEIGHT-88-PADDING,
                                     SCREEN_WIDTH-PADDING*2,
                                     88);
                    _locationView.frame = ccr(0,
                                              0,
                                              self.width,
                                              self.height);
                    _closeBtn.y = (self.height-32)/2;
                }];
            }];
        }
    }
}

- (void)updateLocation:(NSString *)location
{
    
}

@end
