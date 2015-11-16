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
    BOOL _is_showing;
    UIButton *_fromAddress_btn;
    UIButton *_toAddress_btn;
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
                                                            self.width-PADDING*2,
                                                            44)
                                                  color:COLORRGB(0x63666b)
                                                   font:HSFONT(15)
                                                   text:@"蓝戴时空汇"];
        [_locationView addSubview:self.fromAddressLabel];
        
        _fromAddress_btn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.fromAddressLabel];
            }
        }];
        self.fromAddressLabel.userInteractionEnabled = YES;
        _fromAddress_btn.backgroundColor = [UIColor orangeColor];
        _fromAddress_btn.frame = self.fromAddressLabel.bounds;
        [self.fromAddressLabel addSubview:_fromAddress_btn];
        
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
                                                            self.width-PADDING*2,
                                                            44)
                                                  color:COLORRGB(0x63666b)
                                                   font:HSFONT(15)
                                                   text:@"你要去哪儿"];
        [_locationView addSubview:self.toAddressLabel];
        self.toAddressLabel.userInteractionEnabled = YES;
        
        _toAddress_btn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(bottomToolBar:didTapped:)]) {
                [self.delegate bottomToolBar:self didTapped:self.toAddressLabel];
            }
        }];
        _toAddress_btn.backgroundColor = [UIColor redColor];
        _toAddress_btn.frame = self.startTimeLabel.bounds;
        [self.toAddressLabel addSubview:_toAddress_btn];
        
        _closeBtn = [UIButton buttonWithImageName:@"arrow_up"
                                      hlImageName:@"arrow_up_pressed"
                                       onTapBlock:^(UIButton *btn) {
                                           [self showTimeLabel:!_is_showing];
                                       }];
        _closeBtn.frame = ccr(self.width-32-PADDING, (self.height-32)/2, 32, 32);
        [self addSubview:_closeBtn];
        
    }
    return self;
}

- (void)showTimeLabel:(BOOL)show
{
    _is_showing = show;
    if (show) {
        [UIView animateWithDuration:0.3 animations:^{
            _closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.3 animations:^{
                _timeView.alpha = 1;
                self.frame = ccr(PADDING,
                                 SCREEN_HEIGHT-154-PADDING-NAV_BAR_HEIGHT_IOS7,
                                 SCREEN_WIDTH-PADDING*2,
                                 154);
                _locationView.frame = ccr(0,
                                          CGRectGetMaxY(_timeView.frame),
                                          self.width,
                                          88);
//                _fromAddress_btn.frame = self.fromAddressLabel.frame;
//                _toAddress_btn.frame = self.toAddressLabel.frame;
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
                                 SCREEN_HEIGHT-88-PADDING-NAV_BAR_HEIGHT_IOS7,
                                 SCREEN_WIDTH-PADDING*2,
                                 88);
                _locationView.frame = ccr(0,
                                          0,
                                          self.width,
                                          self.height);
//                _fromAddress_btn.frame = self.fromAddressLabel.frame;
//                _toAddress_btn.frame = self.toAddressLabel.frame;
                _closeBtn.y = (self.height-32)/2;
            }];
        }];
    }
}

- (void)updateLocation:(NSString *)location
{
    
}

@end
