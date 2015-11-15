//
//  UILabel+KAddition.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-2.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (KAddition)

+(UILabel*)labelWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font text:(NSString*)text;
+(UILabel*)labelWithFrame:(CGRect)frame color:(UIColor*)color font:(UIFont*)font text:(NSString*)text alignment:(NSTextAlignment)alignment numberOfLines:(int)lines;
@end
