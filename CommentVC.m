//
//  CommentVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/7.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "CommentVC.h"

@interface CommentVC ()

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
}

- (void)createSubViews
{
    UITextView *textView = [[UITextView alloc] initWithFrame:ccr(10,
                                                                 NAV_BAR_HEIGHT_IOS7+10,
                                                                 SCREEN_WIDTH-10*2,
                                                                 200*SCREEN_SCALE)];
    textView.delegate = self;
    textView.backgroundColor = COLORRGB(0xffffff);
    textView.font = HSFONT(18);
    textView.textColor = COLORRGB(0x000000);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:textView];
    
    UIButton *submitButton = [UIButton buttonWithImageName:@""
                                               hlImageName:@""
                                                     title:@"提交评价"
                                                titleColor:COLORRGB(0xffffff)
                                                      font:HSFONT(15)
                                                onTapBlock:^(UIButton *btn) {
                                                    if ([self.delegate respondsToSelector:@selector(didClickSubmitButtonWithComment:)]) {
                                                        [self.delegate didClickSubmitButtonWithComment:textView.text];
                                                    }
                                                }];
    submitButton.frame = ccr(10,
                             CGRectGetMaxY(textView.frame)+20,
                             SCREEN_WIDTH-10*2,
                             50);
    submitButton.backgroundColor = COLORRGB(0xedad49);
    [self.view addSubview:submitButton];
    
    UILabel *label = [UILabel labelWithFrame:CGRectZero
                                       color:COLORRGB(0xedad49)
                                        font:HSFONT(15)
                                        text:@"您的评价,让我们做得更好"
                                   alignment:NSTextAlignmentCenter
                               numberOfLines:1];
    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    label.frame = ccr((SCREEN_WIDTH-labelSize.width)/2,
                      CGRectGetMaxY(submitButton.frame)+10,
                      labelSize.width,
                      labelSize.height);
    [self.view addSubview:label];
}

#pragma mark - textView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
