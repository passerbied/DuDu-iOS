//
//  HitchhikeView.m
//  DuDu
//
//  Created by i-chou on 2/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "HitchhikeView.h"

@implementation HitchhikeView
{
    UILabel *_startLocationLabel;
    UILabel *_destLocationLabel;
    UILabel *_startTimeLabel;
    UILabel *_peopleCountLabel;
}

- (id)init
{
    self = [super init];
    if (self) {
        UIImageView *startLocIcon = [[UIImageView alloc] initWithFrame:ccr(10, 10, 16, 16)];
        startLocIcon.image = IMG(@"tiny_circle_green");
        [self addSubview:startLocIcon];
        
        _startLocationLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                                color:COLORRGB(0x000000)
                                                 font:HSFONT(15)
                                                 text:@""
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
        [self addSubview:_startLocationLabel];
        
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
        
        _destLocationLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                                color:COLORRGB(0x000000)
                                                 font:HSFONT(15)
                                                 text:@""
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
        [self addSubview:_destLocationLabel];
        
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
                                               CGRectGetMaxY(horizontalLine_1st.frame)+10,
                                               16,
                                               16
                                               )];
        timeIcon.image = IMG(@"tiny_clock");
        [self addSubview:timeIcon];
        
        _startTimeLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                               color:COLORRGB(0x000000)
                                                font:HSFONT(15)
                                                text:@""
                                           alignment:NSTextAlignmentLeft
                                       numberOfLines:1];
        [self addSubview:_startTimeLabel];
        
        UIImageView *horizontalLine_3st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               horizontalLine_1st.x,
                                               CGRectGetMaxY(_startTimeLabel.frame)+10,
                                               horizontalLine_1st.width,
                                               0.5)];
        horizontalLine_3st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_3st];
        
        
        UIImageView *peopleIcon =
        [[UIImageView alloc] initWithFrame:ccr(10,
                                               CGRectGetMaxY(horizontalLine_1st.frame)+10,
                                               16,
                                               16
                                               )];
        peopleIcon.image = IMG(@"people");
        [self addSubview:peopleIcon];
        
        _peopleCountLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                            color:COLORRGB(0x000000)
                                             font:HSFONT(15)
                                             text:@""
                                        alignment:NSTextAlignmentLeft
                                    numberOfLines:1];
        [self addSubview:_peopleCountLabel];
        
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
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               verticalLine_1st.height)];
        verticalLine_2nd.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_2nd];
        
        UIImageView *verticalLine_3th =
        [[UIImageView alloc] initWithFrame:ccr(
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               verticalLine_1st.height)];
        verticalLine_3th.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_3th];
        
        self.size = ccs(SCREEN_WIDTH, CGRectGetMaxY(horizontalLine_4st.frame));
        
    }
    return self;
}

@end
