//
//  UIActionSheetItem.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#if NS_BLOCKS_AVAILABLE
typedef void (^ActionSheetBlock)(void);
#endif

@interface UIActionSheetItem : NSObject

@property (nonatomic,copy) ActionSheetBlock itemBlock;
@property (nonatomic,copy) NSString* title;
+(UIActionSheetItem*)itemWithTitle:(NSString*)title block:(ActionSheetBlock)block;
@end
