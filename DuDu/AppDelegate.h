//
//  AppDelegate.h
//  DuDu
//
//  Created by i-chou on 11/2/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuDuURL.h"
#import "WXApi.h"

@protocol AppDelegateDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) id<AppDelegateDelegate> delegate;

@end

@protocol AppDelegateDelegate <NSObject>

- (void)paySuccessed:(BOOL)isSuccessed;

@end


