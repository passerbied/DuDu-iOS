//
//  InvoiceCell.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "InvoiceCell.h"

@implementation InvoiceCell
{
    UILabel     *_routeInforLabel;
    UIImageView *_startSiteImage;
    UIImageView *_endSiteImage;
    UILabel     *_startSiteLabel;
    UILabel     *_endSiteLabel;
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
    _routeInforLabel = [UILabel labelWithFrame:CGRectZero
                                         color:COLORRGB(0x000000)
                                          font:HSFONT(12)
                                          text:@""
                                     alignment:NSTextAlignmentLeft
                                 numberOfLines:1];
    [self.contentView addSubview:_routeInforLabel];
    
    self.selectImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectImage.userInteractionEnabled = YES;
    self.selectImage.backgroundColor = COLORRGB(0xd7d7d7);
    [self.contentView addSubview:self.selectImage];
    
    _startSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _startSiteImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_startSiteImage];
    
    _startSiteLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:@""
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
    [self.contentView addSubview:_startSiteLabel];
    
    _endSiteImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _endSiteImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_endSiteImage];
    
    _endSiteLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.contentView addSubview:_endSiteLabel];
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.contentView addSubview:_bottomLine];
}

- (void)setData
{
    _routeInforLabel.text = [NSString stringWithFormat:@"%@ %@-%@ 车费%.2f元",self.date,self.startTime,self.endTime,self.price];
    _startSiteImage.image = IMG(@"tiny_circle_green");
    _endSiteImage.image = IMG(@"tiny_circle_red");
    _startSiteLabel.text = self.startSite;
    _endSiteLabel.text = self.endSite;
}

- (CGRect)calculateFrame
{
    [self setData];
    NSString *price = [NSString stringWithFormat:@"%.2f",self.price];
    NSString *infor = _routeInforLabel.text;
    NSMutableAttributedString *inforString = [[NSMutableAttributedString alloc] initWithString:infor];
    NSUInteger priceLength = price.length;
    NSUInteger priceLocation = infor.length-1-priceLength;
    [inforString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                         range:NSMakeRange(priceLocation, priceLength)];
    _routeInforLabel.attributedText = inforString;
    CGSize inforSize = [self getTextFromLabel:_routeInforLabel];
    self.selectImage.frame = ccr(20, (self.height-20)/2, 16, 16);
    _routeInforLabel.frame = ccr(CGRectGetMaxX(self.selectImage.frame)+10,
                                 10,
                                 SCREEN_WIDTH-CGRectGetMaxX(self.selectImage.frame)-10-10,
                                 inforSize.height);
    _startSiteImage.frame = ccr(_routeInforLabel.origin.x,
                                CGRectGetMaxY(_routeInforLabel.frame)+5,
                                16,
                                16);
    CGSize startSiteSize = [self getTextFromLabel:_startSiteLabel];
    _startSiteLabel.frame = ccr(CGRectGetMaxX(_startSiteImage.frame)+5,
                                _startSiteImage.origin.y,
                                SCREEN_WIDTH-CGRectGetMaxX(_startSiteImage.frame)-5-20,
                                startSiteSize.height);
    _endSiteImage.frame = ccr(_startSiteImage.origin.x,
                              CGRectGetMaxY(_startSiteImage.frame)+5,
                              _startSiteImage.width,
                              _startSiteImage.height);
    CGSize endSiteSize = [self getTextFromLabel:_endSiteLabel];
    _endSiteLabel.frame = ccr(_startSiteLabel.origin.x,
                              CGRectGetMaxY(_startSiteLabel.frame)+5,
                              _startSiteLabel.width,
                              endSiteSize.height);
    _bottomLine.frame = ccr(0, CGRectGetMaxY(_endSiteLabel.frame)+10-0.5, SCREEN_WIDTH, 0.5);
    
    CGRect cellFrame = ccr(0,
                           0,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_bottomLine.frame));
    return cellFrame;
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
