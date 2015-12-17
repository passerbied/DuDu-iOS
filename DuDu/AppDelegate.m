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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MAMapServices sharedServices].apiKey = MAP_KEY;
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self setUpViewController];
    
    //可以添加自定义categories
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                   UIUserNotificationTypeSound |
                                                   UIUserNotificationTypeAlert)
                                       categories:nil];
    
    // Required
    [APService setupWithOption:launchOptions];
    
    [APService setTags:[NSSet setWithObjects:@"dudu_ios", nil]
                 alias:@"1000000"
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                object:self];

    return YES;
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)setUpViewController
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    logo.image = IMG(@"icon_huge");
    [mainVC.navigationItem setTitleView:logo];
    [mainVC.navigationController.view.layer setCornerRadius:10.0f];
    
    UINavigationController *mainNavCtl = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainNavCtl;
    [self.window makeKeyAndVisible];
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
