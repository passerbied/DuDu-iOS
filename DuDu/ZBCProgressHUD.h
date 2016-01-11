//
//  ZBCProgressHUD.h
//  ZBCool
//
//  Created by i-chou on 6/11/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "MBProgressHUD.h"

@interface ZBCProgressHUD : MBProgressHUD <MBProgressHUDDelegate>


@property (nonatomic,assign) BOOL wasHidden;


+ (ZBCProgressHUD *)sharedZBCProgressHUD;

+ (void)setDescription:(NSString *)text;

+ (id)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (instancetype)showNotificationHUDWithlabelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText animated:(BOOL)animated desView:(UIView *)view;

+ (instancetype)showCompleteHUD:(BOOL)isSuccessed labelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText animated:(BOOL)animated desView:(UIView *)view;

+ (instancetype)showHUDAddedToWindow:(UIView *)window hudText:(NSString *)hudText animated:(BOOL)animated;

+ (BOOL)hideHUDForWindow:(UIWindow *)window animated:(BOOL)animated;


@end
