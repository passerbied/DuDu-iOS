//
//  UIButton+KAddition.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-8-30.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUIButton.h"

@interface UIButton (KAddition)

+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithImageName:(NSString*)imgName hlImageName:(NSString*)hlImgName DisabledImageName:(NSString*)disabledImageName onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName DisabledImageName:(NSString*)disabledImageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font disabledTitleColor:(UIColor *)disabledColor onTapBlock:(ButtonActionBlock)block;
+(UIButton*)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color hlBackgroundColor:(UIColor *)hlColor title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font titleEdgeInsets:(UIEdgeInsets)edgeInsets contentHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithImageName:(NSString *)imgName hlImageName:(NSString *)hlImgName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
+(UIButton*)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color hlBackgroundColor:(UIColor *)hlColor title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor hlTitleColor:(UIColor *)hlTitleColor onTapBlock:(ButtonActionBlock)block NS_AVAILABLE(10_6, 4_0);
@end
