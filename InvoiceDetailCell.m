//
//  InvoiceDetailCell.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "InvoiceDetailCell.h"

@implementation InvoiceDetailCell
{
    UILabel     *_messageLabel;
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
    _messageLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.contentView addSubview:_messageLabel];
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.contentView addSubview:_bottomLine];
}

- (void)setData
{
    _messageLabel.text = self.message;
    CGSize messageSize = [_messageLabel.text sizeWithAttributes:@{NSFontAttributeName:_messageLabel.font}];
    [_messageLabel sizeToFit];
    _messageLabel.frame = ccr(10,
                              (50-messageSize.height)/2,
                              messageSize.width,
                              messageSize.height);
    _bottomLine.frame = ccr(0, 50-0.5, SCREEN_WIDTH, 0.5);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
