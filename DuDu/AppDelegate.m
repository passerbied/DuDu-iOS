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
//#import <QMapKit/QMapKit.h>
//#import <QMapSearchKit/QMapSearchKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [MAMapServices sharedServices].apiKey = AMAP_KEY;
//    [QMapServices sharedServices].apiKey = QMAP_KEY;
//    [QMSSearchServices sharedServices].apiKey = QMAP_KEY;

    [WXApi registerApp:Weixin_App_ID];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self setUpViewController];
    /*
    [[DuDuAPIClient sharedClient] GET:LOGIN_REGEDIT(18698600911) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",[DuDuAPIClient parseJSONFrom:responseObject]);
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        [UICKeyChainStore setString:dic[@"token"] forKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
     */
    
    //可以添加自定义categories
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                   UIUserNotificationTypeSound |
                                                   UIUserNotificationTypeAlert)
                                       categories:nil];
    
    // Required
    [APService setupWithOption:launchOptions];
    
    //TODO: test user
    [UICKeyChainStore removeAllItems];
    [UICKeyChainStore setString:@"vwrfnzgzofhzjps1k3v5aur2o"
                         forKey:KEY_STORE_ACCESS_TOKEN
                        service:KEY_STORE_SERVICE];
    [UICKeyChainStore setString:@"40"
                         forKey:KEY_STORE_USERID
                        service:KEY_STORE_SERVICE];

    return YES;
}

- (void)setUpViewController
{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    logo.image = IMG(@"icon_huge");
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
        NSArray *cars = [MTLJSONAdapter modelsOfClass:[CarModel class]
                                        fromJSONArray:carStyles
                                                error:nil];
        carStore.cars = [cars mutableCopy];
//        NSArray *carStyleModels = [MTLJSONAdapter modelsOfClass:[CarModel class]
//                                      fromJSONArray:carStyles
//                                              error:nil];
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
