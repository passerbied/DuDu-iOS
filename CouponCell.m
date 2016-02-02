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
    self.bgImage = [[UIImageView alloc] initWithFrame:ccr(5, 5, SCREEN_WIDTH-5*2, 100-5*2)];
    self.bgImage.layer.borderColor = COLORRGB(0xf39a00).CGColor;
    self.bgImage.layer.borderWidth = 0.5f;
    self.bgImage.layer.masksToBounds = YES;
    self.bgImage.layer.cornerRadius = 5.0;
    [self.contentView addSubview:self.bgImage];
    
    _typeLabel = [UILabel labelWithFrame:ccr(10, 5, 200, 20)
                                   color:COLORRGB(0xf39a00)
                                    font:HSFONT(15)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.bgImage addSubview:_typeLabel];
    
    _dateLabel = [UILabel labelWithFrame:ccr(_typeLabel.origin.x,
                                             CGRectGetMaxY(_typeLabel.frame)+5,
                                             200,
                                             20)
                                   color:COLORRGB(0xf39a00)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [self.bgImage addSubview:_dateLabel];
    
    _detailLabel = [UILabel labelWithFrame:ccr(self.bgImage.width-56-10,
                                               10,
                                               56,
                                               56)
                                     color:COLORRGB(0xffffff)
                                      font:HSFONT(15)
                                      text:@""
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:1];
    _detailLabel.backgroundColor = COLORRGB(0xf39a00);
    _detailLabel.layer.borderColor = COLORRGB(0xffffff).CGColor;
    _detailLabel.layer.borderWidth = 0.5f;
    _detailLabel.layer.masksToBounds = YES;
    _detailLabel.layer.cornerRadius = 28;
    [self.bgImage addSubview:_detailLabel];
    
    _conditionLabel = [UILabel labelWithFrame:ccr(_dateLabel.origin.x,
                                                  self.bgImage.height - 30,
                                                  SCREEN_WIDTH,
                                                  20)
                                        color:COLORRGB(0x63666b)
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
//    CGSize conditionSize = [self getTextFromLabel:_conditionLabel];
//    _conditionLabel.frame = ccr(_dateLabel.origin.x,
//                                100-5*2-5-conditionSize.height,
//                                conditionSize.width,
//                                conditionSize.height);
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
