//
//  UIAlertView+KAddition.h
//  KickOffIOS
//
//  Created by guoyu wang on 12-9-1.
//  Copyright (c) 2012年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUIAlertView.h"

@interface UIAlertView (KAddition)

+(void)alertWithTitle:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okTitle cancelBtnTitle:(NSString*)cancelTitle okBlock:(AlertActionBlock)block;
+(void)alertWithTitle:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okTitle;
+(void)singleAlertWithTitle:(NSString*)title message:(NSString*)message okBtnTitle:(NSString*)okTitle;
@end
