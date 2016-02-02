//
//  HitchhikeView.m
//  DuDu
//
//  Created by i-chou on 2/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "HitchhikeView.h"

@implementation HitchhikeView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = COLORRGB(0xffffff);
        UIImageView *startLocIcon = [[UIImageView alloc] initWithFrame:ccr(10, 10, 16, 16)];
        startLocIcon.image = IMG(@"tiny_circle_green");
        [self addSubview:startLocIcon];
        
        _startLocationLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                                color:COLORRGB(0xdedede)
                                                 font:HSFONT(14)
                                                 text:@"从哪儿出发"
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
        [self addSubview:_startLocationLabel];
        
        UIButton *startLocalBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(hitchhikeView:didTapped:)]) {
                [self.delegate hitchhikeView:self didTapped:_startLocationLabel];
            }
        }];
        startLocalBtn.frame = _startLocationLabel.frame;
        [self addSubview:startLocalBtn];
        
        UIImageView *horizontalLine_1st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               _startLocationLabel.x,
                                               CGRectGetMaxY(_startLocationLabel.frame)+10,
                                               SCREEN_WIDTH-_startLocationLabel.x,
                                               0.5)];
        horizontalLine_1st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_1st];
        
        UIImageView *destLocIcon =
        [[UIImageView alloc] initWithFrame:ccr(10,
                                               CGRectGetMaxY(horizontalLine_1st.frame)+10,
                                               16,
                                               16
                                               )];
        destLocIcon.image = IMG(@"tiny_circle_red");
        [self addSubview:destLocIcon];
        
        _destLocationLabel = [UILabel labelWithFrame:ccr(36, destLocIcon.y, SCREEN_WIDTH-36, 16)
                                                color:COLORRGB(0xdedede)
                                                 font:HSFONT(14)
                                                 text:@"你要去哪儿"
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
        [self addSubview:_destLocationLabel];
        
        UIButton *destLocalBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(hitchhikeView:didTapped:)]) {
                [self.delegate hitchhikeView:self didTapped:_destLocationLabel];
            }
        }];
        destLocalBtn.frame = _destLocationLabel.frame;
        [self addSubview:destLocalBtn];
        
        UIImageView *horizontalLine_2st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               horizontalLine_1st.x,
                                               CGRectGetMaxY(_destLocationLabel.frame)+10,
                                               horizontalLine_1st.width,
                                               0.5)];
        horizontalLine_2st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_2st];
        
        
        UIImageView *timeIcon =
        [[UIImageView alloc] initWithFrame:ccr(10,
                                               CGRectGetMaxY(horizontalLine_2st.frame)+10,
                                               16,
                                               16
                                               )];
        timeIcon.image = IMG(@"tiny_clock");
        [self addSubview:timeIcon];
        
        _startTimeLabel = [UILabel labelWithFrame:ccr(36, timeIcon.y, SCREEN_WIDTH-36, 16)
                                               color:COLORRGB(0xdedede)
                                                font:HSFONT(14)
                                                text:@"什么时候出发"
                                           alignment:NSTextAlignmentLeft
                                       numberOfLines:1];
        [self addSubview:_startTimeLabel];
        
        UIButton *startTimeBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(hitchhikeView:didTapped:)]) {
                [self.delegate hitchhikeView:self didTapped:_startTimeLabel];
            }
        }];
        startTimeBtn.frame = _startTimeLabel.frame;
        [self addSubview:startTimeBtn];
        
        UIImageView *horizontalLine_3st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               horizontalLine_1st.x,
                                               CGRectGetMaxY(_startTimeLabel.frame)+10,
                                               horizontalLine_1st.width,
                                               0.5)];
        horizontalLine_3st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_3st];
        
        
        UIImageView *peopleIcon =
        [[UIImageView alloc] initWithFrame:ccr(14,
                                               CGRectGetMaxY(horizontalLine_3st.frame)+14,
                                               10,
                                               10
                                               )];
        peopleIcon.image = IMG(@"people");
        [self addSubview:peopleIcon];
        
        _peopleCountLabel = [UILabel labelWithFrame:ccr(36, peopleIcon.y-4, SCREEN_WIDTH-36, 16)
                                            color:COLORRGB(0xdedede)
                                             font:HSFONT(14)
                                             text:@"几人乘车"
                                        alignment:NSTextAlignmentLeft
                                    numberOfLines:1];
        [self addSubview:_peopleCountLabel];
        
        UIButton *peopleBtn = [UIButton buttonWithImageName:nil hlImageName:nil onTapBlock:^(UIButton *btn) {
            if ([self.delegate respondsToSelector:@selector(hitchhikeView:didTapped:)]) {
                [self.delegate hitchhikeView:self didTapped:_peopleCountLabel];
            }
        }];
        peopleBtn.frame = _peopleCountLabel.frame;
        [self addSubview:peopleBtn];
        
        UIImageView *horizontalLine_4st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               0,
                                               CGRectGetMaxY(_peopleCountLabel.frame)+10,
                                               SCREEN_WIDTH,
                                               0.5)];
        horizontalLine_4st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_4st];
        
        
        
        UIImageView *verticalLine_1st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               destLocIcon.y - CGRectGetMaxY(startLocIcon.frame) - 6)];
        verticalLine_1st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_1st];
        
        UIImageView *verticalLine_2nd =
        [[UIImageView alloc] initWithFrame:ccr(
                                               verticalLine_1st.x,
                                               CGRectGetMaxY(destLocIcon.frame)+3,
                                               1,
                                               verticalLine_1st.height)];
        verticalLine_2nd.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_2nd];
        
        UIImageView *verticalLine_3th =
        [[UIImageView alloc] initWithFrame:ccr(
                                               verticalLine_1st.x,
                                               CGRectGetMaxY(timeIcon.frame)+3,
                                               1,
                                               verticalLine_1st.height)];
        verticalLine_3th.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_3th];
        
        self.size = ccs(SCREEN_WIDTH, CGRectGetMaxY(horizontalLine_4st.frame));
        
    }
    return self;
}

@end
