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
    UIImageView *_arrowImage;
    UIImageView *_bottomLine;
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
                                     color:COLORRGB(0xdedede)
                                      font:HSFONT(12)
                                      text:@""
                                 alignment:NSTextAlignmentRight
                             numberOfLines:1];
    [self.contentView addSubview:_statusLabel];
    
    _arrowImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _arrowImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_arrowImage];
    
    _startSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _startSiteImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_startSiteImage];
    
    _endSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _endSiteImage.userInteractionEnabled = YES;
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
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    _bottomLine.userInteractionEnabled = YES;
    [self.contentView addSubview:_bottomLine];
}

- (void)setData
{
    _timeLabel.text = self.routeTime;
    _typeLabel.text = self.routeType;
    _statusLabel.text = self.routeStatus;
    _arrowImage.image = IMG(@"arrow_right");
    _startSiteImage.image = IMG(@"path_mark_start");
    _endSiteImage.image = IMG(@"path_mark_end");
    _startSiteLabel.text = self.startSite;
    _endSiteLabel.text = self.endSite;
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
    
    _arrowImage.frame = ccr(SCREEN_WIDTH-10-30,
                            CGRectGetMaxY(_statusLabel.frame)+10,
                            30,
                            30);
    
    _startSiteImage.frame = ccr(_timeLabel.origin.x,
                                CGRectGetMaxY(_timeLabel.frame)+12,
                                16,
                                23.5);
    
    CGSize siteSize = [_startSiteLabel.text sizeWithAttributes:@{NSFontAttributeName:_startSiteLabel.font}];
    _startSiteLabel.frame = ccr(CGRectGetMaxX(_startSiteImage.frame)+10,
                                CGRectGetMaxY(_timeLabel.frame)+10,
                                _statusLabel.origin.x-CGRectGetMaxX
                                (_startSiteImage.frame)-10-50,
                                siteSize.height);
    
    _endSiteImage.frame = ccr(_startSiteImage.origin.x,
                              CGRectGetMaxY(_startSiteImage.frame)+12,
                              _startSiteImage.width,
                              _startSiteImage.height);
    
    _endSiteLabel.frame = ccr(_startSiteLabel.origin.x,
                              CGRectGetMaxY(_startSiteLabel.frame)+10,
                              _startSiteLabel.width,
                              siteSize.height);
    
    _bottomLine.frame = ccr(0,
                            CGRectGetMaxY(_endSiteLabel.frame)+9.5,
                            SCREEN_WIDTH,
                            0.5);
    CGRect cellFrame = ccr(0,
                           0,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_bottomLine.frame));
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
