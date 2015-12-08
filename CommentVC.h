//
//  CommentVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/7.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentVCDelegate;

@interface CommentVC : UIViewController
<UITextViewDelegate>

@property (nonatomic, strong) id<CommentVCDelegate> delegate;

@end

@protocol CommentVCDelegate <NSObject>

- (void)didClickSubmitButtonWithComment:(NSString *)comment;

@end