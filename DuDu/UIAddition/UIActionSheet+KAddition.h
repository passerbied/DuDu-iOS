//
//  UIActionSheet+KAddition.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIActionSheetItem.h"
#import "KUIActionSheet.h"
@interface UIActionSheet (KAddition)

+(UIActionSheet*)actionSheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle otherItems:(UIActionSheetItem*)firstItem, ... NS_REQUIRES_NIL_TERMINATION;

+(UIActionSheet*)actionSheetWithTitle:(NSString*)title cancelTitle:(NSString*)cancelTitle destructiveTitle:(NSString*)destructiveTitle destructiveBlock:(ActionSheetBlock)destructiveBlock otherItems:(UIActionSheetItem*)firstItem, ... NS_REQUIRES_NIL_TERMINATION;
@end
