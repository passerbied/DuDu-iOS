//
//  BaseViewController.m
//  DuDu
//
//  Created by i-chou on 12/22/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    ZBCNavVC *nav =(ZBCNavVC *)self.navigationController;
    nav.popCompleted = YES;
}

- (void)showRightBarItem:(BOOL)show withButton:(UIButton *)btn
{
    if (show) {
        
        UIBarButtonItem *barBtnShare = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.title = @"";
        negativeSpacer.width = -18;
        
        self.navigationItem.rightBarButtonItems = [NSArray
                                                   arrayWithObjects: negativeSpacer,barBtnShare, nil];
    } else {
        self.navigationItem.rightBarButtonItems = nil;
    }
    
}

- (void)showRightTitle:(BOOL)show withButton:(UIButton *)btn
{
    if (show) {
        
        UIBarButtonItem *barBtnShare = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.title = @"";
        negativeSpacer.width = -10;
        
        self.navigationItem.rightBarButtonItems = [NSArray
                                                   arrayWithObjects:negativeSpacer, barBtnShare, nil];
    } else {
        self.navigationItem.rightBarButtonItems = nil;
    }
}

- (void)showLeftBarItem:(BOOL)show withButton:(UIButton *)btn
{
    if (show) {
        
        UIBarButtonItem *barBtnShare = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.title = @"";
        negativeSpacer.width = -18;
        
        self.navigationItem.leftBarButtonItems = [NSArray
                                                  arrayWithObjects:negativeSpacer, barBtnShare, nil];
    }
    else
    {
        self.navigationItem.leftBarButtonItems = nil;
    }
}

- (void)loadLoginVC:(BOOL)showBackButton animation:(BOOL)animation
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.delegate = self;
    loginVC.title = @"验证手机";
    ZBCNavVC *navVC = [[ZBCNavVC alloc] initWithRootViewController:loginVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (BOOL)checkHaveLogin
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN
                                service:KEY_STORE_SERVICE]) {
        [self loadLoginVC:YES animation:YES];
        return NO;
    }
    return YES;
}

@end
