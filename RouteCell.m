//
//  RouteCell.m
//  DuDu
//
//  Created by 教路浩 on 15/11/30.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RouteCell.h"

@implementation RouteCell
{
    UILabel     *_timeLabel;
    UILabel     *_typeLabel;
    UILabel     *_statusLabel;
    UIImageView *_startSiteImage;
    UIImageView *_endSiteImage;
    UILabel     *_startSiteLabel;
    UILabel     *_endSiteLabel;
    UILabel     *_chargeStatusLabel;
    UILabel     *_chargeLabel;
//    UIImageView *_bottomLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    _timeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.contentView addSubview:_timeLabel];
    
    _typeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0xdedede)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.contentView addSubview:_typeLabel];
    
    _statusLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0xf39a00)
                                      font:HSFONT(12)
                                      text:@""
                                 alignment:NSTextAlignmentRight
                             numberOfLines:1];
    [self.contentView addSubview:_statusLabel];
    
    _startSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _startSiteImage.userInteractionEnabled = YES;
    _startSiteImage.image = IMG(@"tiny_circle_green");
    [self.contentView addSubview:_startSiteImage];
    
    _endSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _endSiteImage.userInteractionEnabled = YES;
    _endSiteImage.image = IMG(@"tiny_circle_red");
    [self.contentView addSubview:_endSiteImage];
    
    _startSiteLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:@""
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
    [self.contentView addSubview:_startSiteLabel];
    
    _endSiteLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.contentView addSubview:_endSiteLabel];
    
//    _chargeStatusLabel = [UILabel labelWithFrame:CGRectZero
//                                           color:COLORRGB(0xff8830)
//                                            font:HSFONT(12)
//                                            text:@""
//                                       alignment:NSTextAlignmentLeft
//                                   numberOfLines:1];
//    [self.contentView addSubview:_chargeStatusLabel];
//    
//    _chargeLabel = [UILabel labelWithFrame:CGRectZero
//                                           color:COLORRGB(0xff8830)
//                                            font:HSFONT(12)
//                                            text:@""
//                                       alignment:NSTextAlignmentLeft
//                                   numberOfLines:1];
//    [self.contentView addSubview:_chargeLabel];
    
    
//    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
//    _bottomLine.userInteractionEnabled = YES;
//    [self.contentView addSubview:_bottomLine];
}

- (void)setData
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    _timeLabel.text = [date displayWithFormat:@"yyyy-m-d HH:mm"];
    _statusLabel.text = self.orderInfo.order_status_str;
    _startSiteLabel.text = self.orderInfo.star_loc_str;
    _endSiteLabel.text = self.orderInfo.dest_loc_str;
//    _chargeStatusLabel.text = self.orderInfo.order_status_str;
//    _chargeLabel.text = self.orderInfo.order_allMoney;
}

- (CGRect)calculateFrame
{
    [self setData];
    CGSize timeSize = [_timeLabel.text sizeWithAttributes:@{NSFontAttributeName:_timeLabel.font}];
    [_timeLabel sizeToFit];
    _timeLabel.frame = ccr(10,
                           10,
                           timeSize.width,
                           timeSize.height);
    
    CGSize typeSize = [_typeLabel.text sizeWithAttributes:@{NSFontAttributeName:_typeLabel.font}];
    [_typeLabel sizeToFit];
    _typeLabel.frame = ccr(CGRectGetMaxX(_timeLabel.frame)+10,
                           _timeLabel.origin.y,
                           typeSize.width,
                           typeSize.height);
    
    CGSize statusSize = [_statusLabel.text sizeWithAttributes:@{NSFontAttributeName:_statusLabel.font}];
    [_statusLabel sizeToFit];
    _statusLabel.frame = ccr(SCREEN_WIDTH-10-statusSize.width,
                             _typeLabel.origin.y,
                             statusSize.width,
                             statusSize.height);
    
    _startSiteImage.frame = ccr(_timeLabel.origin.x,
                                CGRectGetMaxY(_timeLabel.frame)+12,
                                16,
                                16);
    
    CGSize siteSize = [_startSiteLabel.text sizeWithAttributes:@{NSFontAttributeName:_startSiteLabel.font}];
    _startSiteLabel.frame = ccr(CGRectGetMaxX(_startSiteImage.frame)+10,
                                _startSiteImage.origin.y+(_startSiteImage.height-siteSize.height)/2
                                ,
                                _statusLabel.origin.x-CGRectGetMaxX
                                (_startSiteImage.frame)-10-50,
                                siteSize.height);
    
    _endSiteImage.frame = ccr(_startSiteImage.origin.x,
                              CGRectGetMaxY(_startSiteImage.frame)+12,
                              _startSiteImage.width,
                              _startSiteImage.height);
    
    _endSiteLabel.frame = ccr(_startSiteLabel.origin.x,
                              _endSiteImage.origin.y+(_endSiteImage.height-siteSize.height)/2,
                              _startSiteLabel.width,
                              siteSize.height);
    
//    _bottomLine.frame = ccr(0,
//                            CGRectGetMaxY(_endSiteImage.frame)+9.5,
//                            SCREEN_WIDTH,
//                            0.5);
    CGRect cellFrame = ccr(0,
                           0,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_endSiteLabel.frame)+10);
    return cellFrame;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
