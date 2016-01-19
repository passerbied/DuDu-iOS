//
//  AppDelegate.m
//  DuDu
//
//  Created by i-chou on 11/2/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "AppDelegate.h"
//#import "UIKit+AFNetworking.h"
#import "MainViewController.h"
#import "APService.h"
#import "ZBCProgressHUD.h"
#import <QMapKit/QMapKit.h>
#import <QMapSearchKit/QMapSearchKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MainViewController.h"
#import "LoginVC.h"
#import "GeoAndSuggestionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[MainViewController class]];
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[LoginVC class]];
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[GeoAndSuggestionViewController class]];
    
//    [MAMapServices sharedServices].apiKey = AMAP_KEY;
    [QMapServices sharedServices].apiKey = QMAP_KEY;
    [QMSSearchServices sharedServices].apiKey = QMAP_KEY;

    [WXApi registerApp:Weixin_App_ID];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self setUpViewController];

    //可以添加自定义categories
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                   UIUserNotificationTypeSound |
                                                   UIUserNotificationTypeAlert)
                                       categories:nil];
    
    // Required
    [APService setupWithOption:launchOptions];
    
    //TODO: test user
//    [UICKeyChainStore removeAllItems];
//    [UICKeyChainStore setString:@"vwrfnzgzofhzjps1k3v5aur2o"
//                         forKey:KEY_STORE_ACCESS_TOKEN
//                        service:KEY_STORE_SERVICE];
//    [UICKeyChainStore setString:@"40"
//                         forKey:KEY_STORE_USERID
//                        service:KEY_STORE_SERVICE];

    return YES;
}

- (void)setUpViewController
{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    logo.image = IMG(@"icon_logo70");
    [[MainViewController sharedMainViewController].navigationItem setTitleView:logo];
    [[MainViewController sharedMainViewController].navigationController.view.layer setCornerRadius:10.0f];
    
    ZBCNavVC *mainNavCtl = [[ZBCNavVC alloc] initWithRootViewController:[MainViewController sharedMainViewController]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainNavCtl;
    [self.window makeKeyAndVisible];
}

- (void)checkVersionAndGetCarStyles
{
    [[DuDuAPIClient sharedClient] GET:CHECK_VERSION parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *carStyles = [DuDuAPIClient parseJSONFrom:responseObject][@"car_style"];
        CarStore *carStore = [[CarStore alloc] init];

        //获取车型信息
        NSArray *cars = [MTLJSONAdapter modelsOfClass:[CarModel class]
                                        fromJSONArray:carStyles
                                                error:nil];
        
        //获取分享信息
        [CouponStore sharedCouponStore].shareInfo = [DuDuAPIClient parseJSONFrom:responseObject][@"wx_config"];
        
        carStore.cars = [cars mutableCopy];

        if (carStore.cars.count) {
            [MainViewController sharedMainViewController].carStyles = carStore.cars;
            [MainViewController sharedMainViewController].currentCar = carStore.cars[0];
            [[MainViewController sharedMainViewController].topToolBar updateCarStylesWith:carStore.cars];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//推送内容处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self application:application handleReceiveRemoteNotification:userInfo];
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self application:application handleReceiveRemoteNotification:userInfo];
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - wx delegate

- (void)onReq:(BaseReq *)req
{
    NSLog(@"type=%d\n openID=%@",req.type,req.openID);
}

- (void)onResp:(BaseResp *)resp
{
    NSLog(@"errorCode=%d \n error=%@ \n type=%d",resp.errCode,resp.errStr,resp.type);
    if (!resp.errCode) {
        //        if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = @"";
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                if ([self.delegate respondsToSelector:@selector(paySuccessed:)]) {
                    [self.delegate paySuccessed:YES];
                }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        [ZBCToast showMessage:strMsg];
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        
        [[DuDuAPIClient sharedClient] GET:SHARE parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [ZBCToast showMessage:@"分享成功"];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    }

}

- (void)application:(UIApplication *)application handleReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber = 0;
    NSString *alert;
    NSString *type;
    if ([UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        alert = userInfo[@"aps"][@"alert"];
        type = userInfo[@"type"];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)applicationhandleRemoteNotification:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self checkVersionAndGetCarStyles];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
