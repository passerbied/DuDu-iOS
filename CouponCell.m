//
//  CouponCell.m
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell
{
    UILabel *_typeLabel;
    UILabel *_dateLabel;
    UILabel *_detailLabel;
    UILabel *_conditionLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLORRGB(0xf0f0f0);
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.bgImage];
    
    _typeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0xf39a00)
                                    font:HSFONT(15)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.bgImage addSubview:_typeLabel];
    
    _dateLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0xf39a00)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.bgImage addSubview:_dateLabel];
    
    _detailLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0xf39a00)
                                      font:HSFONT(20)
                                      text:@""
                                 alignment:NSTextAlignmentRight
                             numberOfLines:1];
    [self.bgImage addSubview:_detailLabel];
    
    _conditionLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:@""
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
    [self.bgImage addSubview:_conditionLabel];
}

- (void)setData
{
    _typeLabel.text = [NSString stringWithFormat:@"%@",self.coupon_title];
    _dateLabel.text = self.date;
    _detailLabel.text = self.detail;
    _conditionLabel.text = self.condition;
}

- (void)calculateFrame
{
    [self setData];
    self.bgImage.frame = ccr(10, 5, SCREEN_WIDTH-10*2, 100-5*2);
    CGSize typeSize = [self getTextFromLabel:_typeLabel];
    _typeLabel.frame = ccr(10, 5, typeSize.width, typeSize.height);
    CGSize dateSize = [self getTextFromLabel:_dateLabel];
    _dateLabel.frame = ccr(_typeLabel.origin.x,
                           CGRectGetMaxY(_typeLabel.frame)+5,
                           dateSize.width,
                           dateSize.height);
    CGSize detailSize = [self getTextFromLabel:_detailLabel];
    _detailLabel.frame = ccr(SCREEN_WIDTH-10*2-10-detailSize.width,
                             _typeLabel.origin.y,
                             detailSize.width,
                             detailSize.height);
    CGSize conditionSize = [self getTextFromLabel:_conditionLabel];
    _conditionLabel.frame = ccr(_dateLabel.origin.x,
                                100-5*2-5-conditionSize.height,
                                conditionSize.width,
                                conditionSize.height);
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
