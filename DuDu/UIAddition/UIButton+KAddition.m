//
//  UIButton+KAddition.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-8-30.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "UIButton+KAddition.h"
@implementation UIButton (KAddition)

+(UIButton*)buttonWithImageName:(NSString*)imgName hlImageName:(NSString*)hlImgName onTapBlock:(ButtonActionBlock)block
{
    UIImage* image = IMG(imgName);
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    KUIButton* btn = [[KUIButton alloc] initWithFrame:ccr(0, 0, image.size.width, image.size.height)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIImage* hlImage = IMG(hlImgName);
    hlImage = [hlImage stretchableImageWithLeftCapWidth:hlImage.size.width/2 topCapHeight:hlImage.size.height/2];
    [btn setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    [btn addTarget:btn action:@selector(onTouchUp) forControlEvents:UIControlEventTouchUpInside];
    btn.onTapBlock = block;
    return btn;
}

+(UIButton*)buttonWithImageName:(NSString*)imgName hlImageName:(NSString*)hlImgName DisabledImageName:(NSString*)disabledImageName onTapBlock:(ButtonActionBlock)block
{
    UIImage* image = IMG(imgName);
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    KUIButton* btn = [[KUIButton alloc] initWithFrame:ccr(0, 0, image.size.width, image.size.height)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIImage* hlImage = IMG(hlImgName);
    hlImage = [hlImage stretchableImageWithLeftCapWidth:hlImage.size.width/2 topCapHeight:hlImage.size.height/2];
    [btn setBackgroundImage:hlImage forState:UIControlStateHighlighted];
    UIImage* disabledImage = IMG(disabledImageName);
    disabledImage = [disabledImage stretchableImageWithLeftCapWidth:disabledImage.size.width/2 topCapHeight:disabledImage.size.height/2];
    [btn setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    [btn addTarget:btn action:@selector(onTouchUp) forControlEvents:UIControlEventTouchUpInside];
    btn.onTapBlock = block;
    return btn;
}

+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color onTapBlock:(ButtonActionBlock)block
{
    UIButton *btn = [UIButton buttonWithImageName:imgName hlImageName:hlImgName onTapBlock:block];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font onTapBlock:(ButtonActionBlock)block
{
    UIButton *btn = [UIButton buttonWithImageName:imgName hlImageName:hlImgName onTapBlock:block];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName DisabledImageName:(NSString*)disabledImageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font disabledTitleColor:(UIColor *)disabledColor onTapBlock:(ButtonActionBlock)block
{
    UIButton *btn = [UIButton buttonWithImageName:imgName hlImageName:hlImgName DisabledImageName:disabledImageName onTapBlock:block];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    btn.titleLabel.font = font;
    return btn;
}

+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font titleEdgeInsets:(UIEdgeInsets)edgeInsets contentHorizontalAlignment:(UIControlContentHorizontalAlignment )alignment  onTapBlock:(ButtonActionBlock)block
{
    UIButton *btn = [UIButton buttonWithImageName:imgName hlImageName:hlImgName title:title titleColor:color font:font onTapBlock:block];
    btn.contentHorizontalAlignment = alignment;
    btn.titleEdgeInsets = edgeInsets;
    return btn;
}

+(UIButton*)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color hlBackgroundColor:(UIColor *)hlColor title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor onTapBlock:(ButtonActionBlock)block
{
    KUIButton *btn = [[KUIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageWithColor:color bounds:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:hlColor bounds:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(onTouchUp) forControlEvents:UIControlEventTouchUpInside];
    btn.onTapBlock = block;
    return btn;
}

+(UIButton*)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color hlBackgroundColor:(UIColor *)hlColor title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor hlTitleColor:(UIColor *)hlTitleColor onTapBlock:(ButtonActionBlock)block
{
    KUIButton *btn = [[KUIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageWithColor:color bounds:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:hlColor bounds:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:hlColor bounds:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:hlTitleColor forState:UIControlStateHighlighted];
    [btn setTitleColor:hlTitleColor forState:UIControlStateSelected];
    [btn addTarget:btn action:@selector(onTouchUp) forControlEvents:UIControlEventTouchUpInside];
    btn.onTapBlock = block;
    return btn;
}

@end
