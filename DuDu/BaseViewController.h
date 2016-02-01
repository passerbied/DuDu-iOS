//
//  BaseViewController.h
//  DuDu
//
//  Created by i-chou on 12/22/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)showRightBarItem:(BOOL)show withButton:(UIButton *)btn;

- (void)showLeftBarItem:(BOOL)show withButton:(UIButton *)btn;

- (void)showRightTitle:(BOOL)show withButton:(UIButton *)btn;

- (void)loadLoginVC:(BOOL)showBackButton animation:(BOOL)animation;

- (BOOL)checkHaveLogin;

@end
