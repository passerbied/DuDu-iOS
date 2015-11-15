//
//  KUIActionSheet.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-2.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIActionSheetItem.h"

@interface KUIActionSheet : UIActionSheet <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray* items;
@property (nonatomic, copy) ActionSheetBlock destructiveBlock; 
@end
