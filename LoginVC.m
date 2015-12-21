//
//  LoginVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/17.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
{
    UILabel     *_introLabel;
    UITextField *_phoneTextField;
    UIButton    *_verifyButton;
    UITextField *_verifyTextField;
    UIButton    *_startButton;
    UILabel     *_agreeLabel;
    UILabel     *_lawLabel;
    UIButton    *_lawButton;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
}

- (void)createSubViews
{
    _introLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0xd7d7d7)
                                     font:HSFONT(12)
                                     text:@"为方便司机接您时联系您,请验证手机"
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [self.view addSubview:_introLabel];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _phoneTextField.placeholder = @"手机号";
    _phoneTextField.textColor = COLORRGB(0x000000);
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];
    
    _verifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _verifyButton.frame = CGRectZero;
    _verifyButton.titleLabel.textColor = COLORRGB(0xffffff);
    [_verifyButton setTitle:@"验证" forState:UIControlStateNormal];
    [_verifyButton setBackgroundColor:COLORRGB(0xd7d7d7)];
    [_verifyButton setEnabled:NO];
    [self.view addSubview:_verifyButton];
    
    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _verifyTextField.placeholder = @"验证码";
    _verifyTextField.textColor = COLORRGB(0x000000);
    _verifyTextField.textAlignment = NSTextAlignmentLeft;
    _verifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_verifyTextField];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _startButton.frame = CGRectZero;
    _startButton.titleLabel.textColor = COLORRGB(0xffffff);
    [_startButton setTitle:@"开始" forState:UIControlStateNormal];
    [_startButton setBackgroundColor:COLORRGB(0xd7d7d7)];
    [_startButton setEnabled:NO];
    [self.view addSubview:_startButton];
    
    _agreeLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0xd7d7d7)
                                     font:HSFONT(12)
                                     text:@"点击-开始,即表示您同意"
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [self.view addSubview:_agreeLabel];
    
    _lawLabel = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0xedad49)
                                   font:HSFONT(12)
                                   text:@"《法律声明及隐私政策》"
                              alignment:NSTextAlignmentLeft
                          numberOfLines:1];
    [self.view addSubview:_lawLabel];
    
    _lawButton = [UIButton buttonWithImageName:@""
                                   hlImageName:@""
                                    onTapBlock:^(UIButton *btn) {
                                        
                                    }];
    _lawButton.frame = CGRectZero;
    [self.view addSubview:_lawButton];
    [self calculateFrame];
}

- (void)calculateFrame
{
    CGSize introSize = [self getTextFromLabel:_introLabel];
    _introLabel.frame = ccr((SCREEN_WIDTH-introSize.width)/2,
                            10+NAV_BAR_HEIGHT_IOS7,
                            introSize.width,
                            introSize.height);
    CGFloat verifyBtnWidth = (SCREEN_WIDTH-20*2-5)/5;
    _phoneTextField.frame = ccr(20,
                                CGRectGetMaxY(_introLabel.frame)+10,
                                verifyBtnWidth*4,
                                30);
    _verifyButton.frame = ccr(CGRectGetMaxX(_phoneTextField.frame)+5,
                              _phoneTextField.origin.y,
                              verifyBtnWidth,
                              30);
    _verifyTextField.frame = ccr(_phoneTextField.origin.x,
                                 CGRectGetMaxY(_phoneTextField.frame)+5,
                                 SCREEN_WIDTH-20*2,
                                 _phoneTextField.height);
    _startButton.frame = ccr(_verifyTextField.origin.x,
                             CGRectGetMaxY(_verifyTextField.frame)+5,
                             _verifyTextField.width,
                             _verifyTextField.height);
    CGSize agreeSize = [self getTextFromLabel:_agreeLabel];
    _agreeLabel.frame = ccr(_startButton.origin.x,
                            CGRectGetMaxY(_startButton.frame)+10,
                            agreeSize.width,
                            agreeSize.height);
    CGSize lawSize = [self getTextFromLabel:_lawLabel];
    _lawLabel.frame = ccr(CGRectGetMaxX(_agreeLabel.frame)+5,
                          _agreeLabel.origin.y,
                          lawSize.width,
                          lawSize.height);
    _lawButton.frame = _lawLabel.frame;
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
