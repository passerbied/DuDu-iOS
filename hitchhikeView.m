//
//  hitchhikeView.m
//  DuDu
//
//  Created by i-chou on 2/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "hitchhikeView.h"

@implementation hitchhikeView
{
    UILabel *_startLocationLabel;
    UILabel *destLocationLabel;
    UILabel *_startTimeLabel;
    UILabel *_peopleCountLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
                                               CGRectGetMaxY(_startLocationLabel.frame),
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
        
        destLocationLabel = [UILabel labelWithFrame:ccr(36, 10, SCREEN_WIDTH-36, 16)
                                                color:COLORRGB(0x000000)
                                                 font:HSFONT(15)
                                                 text:@""
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
        [self addSubview:destLocationLabel];
        
        UIImageView *horizontalLine_2st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               horizontalLine_1st.x,
                                               CGRectGetMaxY(_startLocationLabel.frame),
                                               SCREEN_WIDTH-_startLocationLabel.x,
                                               0.5)];
        horizontalLine_2st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:horizontalLine_2st];
        
        
        
        
        UIImageView *verticalLine_1st =
        [[UIImageView alloc] initWithFrame:ccr(
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               20)];
        verticalLine_1st.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_1st];
        
        UIImageView *verticalLine_2nd =
        [[UIImageView alloc] initWithFrame:ccr(
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               20)];
        verticalLine_2nd.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_2nd];
        
        UIImageView *verticalLine_3th =
        [[UIImageView alloc] initWithFrame:ccr(
                                               startLocIcon.centerX,
                                               CGRectGetMaxY(startLocIcon.frame)+3,
                                               1,
                                               20)];
        verticalLine_3th.backgroundColor = COLORRGB(0xdedede);
        [self addSubview:verticalLine_3th];
        
    }
    return self;
}

@end
