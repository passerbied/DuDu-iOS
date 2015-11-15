//
//  KUIButton.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "KUIButton.h"

@implementation KUIButton
@synthesize onTapBlock;

-(void)onTouchUp
{
    onTapBlock(self);
}

@end
