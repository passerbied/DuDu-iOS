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
    UIButton    *_checkBoxBtn;
    UILabel     *_routeInforLabel;
    UIImageView *_startSiteImage;
    UIImageView *_endSiteImage;
    UILabel     *_startSiteLabel;
    UILabel     *_endSiteLabel;
    UILabel     *_priceLabel;
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
    _checkBoxBtn = [UIButton buttonWithImageName:@"checkbox_no"
                                     hlImageName:@"checkbox_no"
                                      onTapBlock:^(UIButton *btn) {
                                         if ([self.delegate respondsToSelector:@selector(invoiceCell:didChecked:)]) {
                                             self.isSelected = !self.isSelected;
                                             [self.delegate invoiceCell:self
                                                             didChecked:self.isSelected];
                                         }
    }];
    [self.contentView addSubview:_checkBoxBtn];
    
    _routeInforLabel = [UILabel labelWithFrame:ccr(16+16+10,
                                                   10,
                                                   SCREEN_WIDTH-32-10-10,
                                                   20)
                                         color:COLORRGB(0x000000)
                                          font:HSFONT(12)
                                          text:@""
                                     alignment:NSTextAlignmentLeft
                                 numberOfLines:1];
    [self.contentView addSubview:_routeInforLabel];
    
    _startSiteImage = [[UIImageView alloc] initWithFrame:ccr(_routeInforLabel.origin.x,
                                                             CGRectGetMaxY(_routeInforLabel.frame)+5,
                                                             16,
                                                             16)];
    _startSiteImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_startSiteImage];
    
    _startSiteLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(_startSiteImage.frame)+5,
                                                  _startSiteImage.origin.y,
                                                  SCREEN_WIDTH-CGRectGetMaxX(_startSiteImage.frame)-5-20,
                                                  16
                                                  )
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:@""
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
    [self.contentView addSubview:_startSiteLabel];
    
    _endSiteImage = [[UIImageView alloc] initWithFrame:ccr(_startSiteImage.origin.x,
                                                           CGRectGetMaxY(_startSiteImage.frame)+5,
                                                           _startSiteImage.width,
                                                           _startSiteImage.height)];
    _endSiteImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_endSiteImage];
    
    _endSiteLabel = [UILabel labelWithFrame:ccr(_startSiteLabel.origin.x,
                                                CGRectGetMaxY(_startSiteLabel.frame)+5,
                                                _startSiteLabel.width,
                                                _startSiteLabel.height
                                                )
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    
    [self.contentView addSubview:_endSiteLabel];
    
    CGRect cellFrame = ccr(0,
                           0,
                           SCREEN_WIDTH,
                           CGRectGetMaxY(_endSiteLabel.frame)+10
                           );
    _checkBoxBtn.frame = ccr(16, _startSiteImage.y, 16, 16);
    
    _priceLabel = [UILabel labelWithFrame:ccr(
                                              SCREEN_WIDTH-80-10,
                                              _startSiteImage.y,
                                              80,
                                              16
                                              )
                                    color:COLORRGB(0xf39a00)
                                     font:HSFONT(15)
                                     text:@""
                                alignment:NSTextAlignmentRight
                            numberOfLines:1];
    [self.contentView addSubview:_priceLabel];
    
    self.frame = cellFrame;
}

- (void)setData
{
    _routeInforLabel.text = self.startTime;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",self.price];
    
//    NSString *infor = _routeInforLabel.text;
//    NSMutableAttributedString *inforString = [[NSMutableAttributedString alloc] initWithString:infor];
//    NSUInteger priceLength = self.price.length;
//    NSUInteger priceLocation = infor.length-1-priceLength;
//    [inforString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
//                         range:NSMakeRange(priceLocation, priceLength)];
//    _routeInforLabel.attributedText = inforString;
    
    _startSiteImage.image = IMG(@"tiny_circle_green");
    _endSiteImage.image = IMG(@"tiny_circle_red");
    _startSiteLabel.text = self.startSite;
    _endSiteLabel.text = self.endSite;
    if (self.isSelected) {
        [_checkBoxBtn setImage:IMG(@"checkbox_yes") forState:UIControlStateNormal];
        [_checkBoxBtn setImage:IMG(@"checkbox_yes") forState:UIControlStateSelected];
    } else {
        [_checkBoxBtn setImage:IMG(@"checkbox_no") forState:UIControlStateNormal];
        [_checkBoxBtn setImage:IMG(@"checkbox_no") forState:UIControlStateSelected];
    }
}

- (CGRect)calculateFrame
{
    [self setData];
    return self.frame;
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
