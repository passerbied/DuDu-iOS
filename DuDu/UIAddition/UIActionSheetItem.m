//
//  UIActionSheetItem.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "UIActionSheetItem.h"

@implementation UIActionSheetItem
@synthesize itemBlock;
@synthesize title;

+(UIActionSheetItem*)itemWithTitle:(NSString*)title block:(ActionSheetBlock)block
{
    UIActionSheetItem* item = [[UIActionSheetItem alloc] init];
    item.title = title;
    item.itemBlock = block;
    return item;
}
@end
