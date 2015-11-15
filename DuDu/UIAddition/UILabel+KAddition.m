//
//  UILabel+KAddition.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-2.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "UILabel+KAddition.h"

@implementation UILabel (KAddition)

+(UILabel*)labelWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font text:(NSString*)text
{
    return [UILabel labelWithFrame:frame color:color font:font text:text alignment:NSTextAlignmentLeft numberOfLines:1];
}

+(UILabel*)labelWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font text:(NSString*)text alignment:(NSTextAlignment)alignment numberOfLines:(int)lines
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = font;
    label.text = text;
    label.textAlignment = alignment;
    label.numberOfLines = lines;
    return label;
}
@end
