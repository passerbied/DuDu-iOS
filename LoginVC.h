//
//  LoginVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/17.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginVCDelegate;

@interface LoginVC : UIViewController
<UITextFieldDelegate>

@property (nonatomic, strong) id<LoginVCDelegate> delegate;

@end

@protocol LoginVCDelegate <NSObject>

- (void)loginSucceed:(UserModel *)userInfo;

@end
