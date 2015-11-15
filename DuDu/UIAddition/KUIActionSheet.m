//
//  KUIActionSheet.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-2.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "KUIActionSheet.h"
#include <AssertMacros.h>
@implementation KUIActionSheet
@synthesize items;
@synthesize destructiveBlock;

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        destructiveBlock();
    } else {
        UIActionSheetItem* item = [items objectAtIndex:buttonIndex - actionSheet.destructiveButtonIndex - 1];
        item.itemBlock();
    }
}

@end
