//
//  UIView+KAddition.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KAddition)

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

-(void)fadeIn;
-(void)fadeOut;
@end
