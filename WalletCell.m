//
//  WalletCell.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "WalletCell.h"

@implementation WalletCell
{
    UILabel     *_titleLabel;
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
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.iconImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.iconImage];
    
    _titleLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(15)
                                     text:@""];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _arrowImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _arrowImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_arrowImage];
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.userInteractionEnabled = YES;
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.contentView addSubview:_bottomLine];
}

- (void)setData
{
    _titleLabel.text = self.title;
    _arrowImage.image = IMG(@"arrow_right");
}

- (void)calculateFrame
{
    [self setData];
    self.iconImage.frame = ccr(20, (60-20)/2, 20, 20);
    CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_titleLabel.font}];
    [_titleLabel sizeToFit];
    _titleLabel.frame = ccr(CGRectGetMaxX(_iconImage.frame)+5,
                            (60-titleSize.height)/2,
                            titleSize.width,
                            titleSize.height);
    _arrowImage.frame = ccr(SCREEN_WIDTH-30-5, (60-30)/2, 30, 30);
    _bottomLine.frame = ccr(0, 60-0.5, SCREEN_WIDTH, 0.5);
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
