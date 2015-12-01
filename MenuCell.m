//
//  MenuCell.m
//  DuDu
//
//  Created by i-chou on 11/17/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
{
    UILabel     *_titleLabel;
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
}

- (void)setData
{
    _titleLabel.text = self.title;
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
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateFrame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
