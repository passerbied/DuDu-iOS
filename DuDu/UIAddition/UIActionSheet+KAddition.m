//
//  UIActionSheet+KAddition.m
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import "UIActionSheet+KAddition.h"

@implementation UIActionSheet (KAddition)

+(UIActionSheet*)actionSheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherItems:(UIActionSheetItem*)firstItem, ... NS_REQUIRES_NIL_TERMINATION
{
    KUIActionSheet* actionSheet = [[KUIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    actionSheet.delegate = actionSheet;
    if(firstItem) {
        actionSheet.items = [NSMutableArray arrayWithObject:firstItem];
        id eachObject;
        va_list argumentList;
        va_start(argumentList, firstItem);
        while ((eachObject = va_arg(argumentList, id))) {
            [actionSheet.items addObject:eachObject];
        }
        va_end(argumentList);
        [actionSheet.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIActionSheetItem* item = (UIActionSheetItem*)obj;
            [actionSheet addButtonWithTitle:item.title];
        }];
    }
    if (cancelTitle.length) {
        [actionSheet addButtonWithTitle:cancelTitle];
    } else {
        [actionSheet addButtonWithTitle:@"Cancel"];
    }
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
    return actionSheet;
}


+(UIActionSheet*)actionSheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle destructiveTitle:(NSString*)destructiveTitle destructiveBlock:(ActionSheetBlock)destructiveBlock otherItems:(UIActionSheetItem*)firstItem, ... NS_REQUIRES_NIL_TERMINATION
{
    KUIActionSheet* actionSheet = [[KUIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    actionSheet.delegate = actionSheet;
    if (destructiveTitle.length) {
        [actionSheet addButtonWithTitle:destructiveTitle];
        actionSheet.destructiveBlock = destructiveBlock;
        actionSheet.destructiveButtonIndex = 0;
    }
    if(firstItem) {
        actionSheet.items = [NSMutableArray arrayWithObject:firstItem];
        id eachObject;
        va_list argumentList;
        va_start(argumentList, firstItem);
        while ((eachObject = va_arg(argumentList, id))) {
            [actionSheet.items addObject:eachObject];
        }
        va_end(argumentList);
        [actionSheet.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIActionSheetItem* item = (UIActionSheetItem*)obj;
            [actionSheet addButtonWithTitle:item.title];
        }];
    }
    if (cancelTitle.length) {
        [actionSheet addButtonWithTitle:cancelTitle];
    } else {
        [actionSheet addButtonWithTitle:@"Cancel"];
    }
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
    return actionSheet;
}
@end
