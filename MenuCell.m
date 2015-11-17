//
//  MenuCell.m
//  DuDu
//
//  Created by i-chou on 11/17/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

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
    self.icon = [[UIImageView alloc]initWithFrame:ccr(20, (self.height-20)/2, 20, 20)];
    [self.contentView addSubview:self.icon];
    
    self.title = [UILabel labelWithFrame:ccr(CGRectGetMaxX(self.icon.frame)+5,
                                             0,
                                             self.width-5*2-self.icon.width,
                                             self.contentView.height)
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(15)
                                    text:@""];
    [self.contentView addSubview:self.title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
