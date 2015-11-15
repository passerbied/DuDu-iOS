//
//  KUIAlertView.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "KUIAlertView.h"

@implementation KUIAlertView
@synthesize okBlock;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        okBlock();
    }
}

@end
