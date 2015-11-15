//
//  KUIAlertView.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#if NS_BLOCKS_AVAILABLE
typedef void (^AlertActionBlock)(void);
#endif

@interface KUIAlertView : UIAlertView

@property (nonatomic, copy) AlertActionBlock okBlock;
@end
