//
//  LoginVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/17.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "LoginVC.h"
#import "MenuTableViewController.h"

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
    BOOL        _isCountingDown;
    NSTimer     *_timer;
    NSInteger   _timerCount;
    UserModel   *_userInfo;
}

@end

@implementation LoginVC

- (void)loadView
{
    [super loadView];
    UIButton * back = [UIButton buttonWithImageName:@"nav_btn_back_88_88"
                                        hlImageName:@"nav_btn_back_hl_88_88"
                                  DisabledImageName:@""
                                         onTapBlock:^(UIButton *btn) {
                                             [self dismissViewControllerAnimated:YES completion:^{
                                                 [_timer setFireDate:[NSDate distantFuture]];
                                                 [_timer invalidate];
                                                 _timer = nil;
                                             }];
                                         }];
    UIBarButtonItem *barBtnShare = [[UIBarButtonItem alloc] initWithCustomView:back];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    negativeSpacer.title = @"";
    negativeSpacer.width = -18;
    
    self.navigationItem.leftBarButtonItems = [NSArray
                                              arrayWithObjects:negativeSpacer, barBtnShare,
                                              nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
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
    _phoneTextField.font = HSFONT(15);
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];
    
    _verifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _verifyButton.frame = CGRectZero;
    _verifyButton.titleLabel.textColor = COLORRGB(0xffffff);
    _verifyButton.titleLabel.font = HSFONT(15);
    [_verifyButton setTitle:@"验证" forState:UIControlStateNormal];
    [_verifyButton setBackgroundColor:COLORRGB(0xd7d7d7)];
    [_verifyButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyButton];
    
    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _verifyTextField.placeholder = @"验证码";
    _verifyTextField.textColor = COLORRGB(0x000000);
    _verifyTextField.font = HSFONT(15);
    _verifyTextField.textAlignment = NSTextAlignmentLeft;
    _verifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_verifyTextField];
    
    _startButton = [UIButton buttonWithImageName:@"orgbtn" hlImageName:@"orgbtn_pressed" title:@"开 始" titleColor:COLORRGB(0xffffff) font:HSFONT(15) onTapBlock:^(UIButton *btn) {
        [self sentOrder];
    }];
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
                                        NSLog(@"法律条款被点击");
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
                             30);
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

- (void)getVerifyCode
{
    if ([Utils isMobileNumber:_phoneTextField.text]) {
        [self verifyCountDown];
    } else {
        [ZBCToast showMessage:@"请输入正确的手机号码"];
    }
}

- (void)verifyCountDown
{
    _isCountingDown = YES;
    [_timer setFireDate:[NSDate distantPast]];
    _timerCount = 59;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(timerFireMethod:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    if (_timerCount>0) {
        [_verifyButton setTitle:STR_D(_timerCount--) forState:UIControlStateNormal];
        _verifyButton.enabled = NO;
    } else {
        [_verifyButton setTitle:@"验证" forState:UIControlStateNormal];
        _verifyButton.enabled = YES;
        _isCountingDown = NO;
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)sentOrder
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(loginSucceed:)]) {
            [self.delegate loginSucceed:_userInfo];
        }
    }];
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
