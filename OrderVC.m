//
//  OrderVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/8.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "OrderVC.h"
#import "SIAlertView.h"

@interface OrderVC ()
{
    UIView      *_headerView;
    UIImageView *_timeImage;
    UILabel     *_timeLabel;
    UIImageView *_startImage;
    UILabel     *_startLabel;
    UIImageView *_endImage;
    UILabel     *_endLabel;
    UILabel     *_numberLabel;
    UILabel     *_minuteLabel;
    UILabel     *_noticeLabel;
    UIImageView *_bottomLine;
    UIButton    *_changeCarBtn;
    UIImageView *_timerImageView;
    UILabel     *_timerLabel;
    int         _timerCount;
    NSTimer     *_timer;
    SIAlertView *_alertView;
}

@end

@implementation OrderVC

//+ (instancetype)sharedOrderVC
//{
//    static dispatch_once_t pred = 0;
//    __strong static id _sharedOrderVC = nil;
//    dispatch_once(&pred, ^{
//        _sharedOrderVC = [[self alloc] init];
//    });
//    return _sharedOrderVC;
//}

//- (id)init
//{
//    self = [super init];
//    if (self) {
////        [self createSubViews];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubViews];
//    if (self.isModal) {
//        UIButton *btn = [UIButton buttonWithImageName:@"gn_pop_icon_shut" hlImageName:@"gn_pop_icon_shut_hl" onTapBlock:^(UIButton *btn) {
//            [self dismissViewControllerAnimated:YES completion:^{
//            }];
//        }];
//        [self showLeftBarItem:YES withButton:btn];
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self calculateFrame];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _alertView = nil;
}

- (void)createSubViews
{
    UIButton *cancelBtn = [UIButton buttonWithImageName:@""
                                            hlImageName:@""
                                                  title:@"取消"
                                             titleColor:COLORRGB(0xffffff)
                                                   font:HSFONT(15)
                                             onTapBlock:^(UIButton *btn) {
                                                 _alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"\n您确定要取消订单吗？\n"];
                                                 _alertView.messageFont = HSFONT(14);
                                                 _alertView.buttonColor = COLORRGB(0xf39a00);
                                                 _alertView.buttonFont = HSFONT(15);
                                                 _alertView.cancelButtonColor = COLORRGB(0xf39a00);
                                                 _alertView.didShowHandler = ^(SIAlertView *alertView) {
                                                 };
                                                 _alertView.didDismissHandler = ^(SIAlertView *alertView) {
                                                     alertView = nil;
                                                 };
                                                 _alertView.transitionStyle = SIAlertViewTransitionStyleBounce;

                                                 __weak id weakSelf = self;
                                                 [_alertView addButtonWithTitle:@"取消订单"
                                                                          type:SIAlertViewButtonTypeDefault
                                                                       handler:^(SIAlertView *alert) {
                                                                           [weakSelf cancelOrder];
                                                                       }];
                                                 [_alertView addButtonWithTitle:@"继续等待"
                                                                          type:SIAlertViewButtonTypeCancel
                                                                       handler:^(SIAlertView *alert) {
                                                                           [alert dismissAnimated:YES];
                                                                       }];
                                                 [_alertView show];
                                                 
                                             }];
    cancelBtn.frame = ccr(0, 0, 40, 40);
    //取消操作限乘车之前
    if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver ||
        [self.orderInfo.order_status intValue] == OrderStatusDriverIsComing) {
        [self showRightTitle:YES withButton:cancelBtn];
    }
    
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = COLORRGB(0xffffff);
    [self.view addSubview:_headerView];
    
    _timeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _timeImage.image = IMG(@"tiny_clock");
    [_headerView addSubview:_timeImage];
    
    _timeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [_headerView addSubview:_timeLabel];
    
    _startImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _startImage.image = IMG(@"tiny_circle_green");
    [_headerView addSubview:_startImage];
    
    _startLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [_headerView addSubview:_startLabel];
    
    _endImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _endImage.image = IMG(@"tiny_circle_red");
    [_headerView addSubview:_endImage];
    
    _endLabel = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0x000000)
                                   font:HSFONT(12)
                                   text:@""
                              alignment:NSTextAlignmentLeft
                          numberOfLines:1];
    [_headerView addSubview:_endLabel];
    
    if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver) {
        _timerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _timerImageView.image = IMG(@"circle_orange");
        [_headerView addSubview:_timerImageView];
        
        _timerLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(15)
                                         text:@"--"
                                    alignment:NSTextAlignmentCenter
                                numberOfLines:1];
        [_timerImageView addSubview:_timerLabel];
    }
    
    _noticeLabel = [UILabel labelWithFrame:CGRectZero
                                     color:COLORRGB(0x63666b)
                                      font:HSFONT(15)
                                      text:@"欢迎使用嘟嘟出行"
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:0];
    [self.view addSubview:_noticeLabel];
    
    _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_bottomLine];
}

//TODO:remove test json
//
//- (void)cancelOrder
//{
//    NSDictionary *dic = [DuDuAPIClient parseJSONFrom:[Utils testDicFrom:@"ordercancel"]];
//    [ZBCToast showMessage:dic[@"info"]];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)cancelOrder
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:CANCEL_ORDER(self.orderInfo.order_id) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [ZBCToast showMessage:@"订单已取消"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)setData
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    _timeLabel.text = [date displayWithFormat:@"d号H点mm分"];
    _startLabel.text = self.orderInfo.star_loc_str;
    _endLabel.text = self.orderInfo.dest_loc_str;
    _noticeLabel.text = self.orderStatusInfo;
    
    if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver) {
        _timerCount = 2;
        [_timer setFireDate:[NSDate distantPast]];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerFireMethod:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    if (_timerCount>0) {
        _timerLabel.text = STR_I(_timerCount--);
    } else {
        _timerLabel.text = @"--";
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer invalidate];
        _timer = nil;
        
        _alertView = [[SIAlertView alloc] initWithTitle:@""
                                             andMessage:@"\n您等待了较长的时间，系统会赠送您优惠券\n\n是否继续等待嘟嘟为您服务？\n"];
        _alertView.messageFont = HSFONT(14);
        _alertView.buttonColor = COLORRGB(0xf39a00);
        _alertView.buttonFont = HSFONT(15);
        _alertView.cancelButtonColor = COLORRGB(0xf39a00);
        __weak id weakSelf = self;
        [_alertView addButtonWithTitle:@"取消订单"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alert) {
                                  [weakSelf cancelOrder];
                              }];
        [_alertView addButtonWithTitle:@"继续等待"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alert) {
                                  [alert dismissAnimated:YES];
                              }];
        _alertView.didShowHandler = ^(SIAlertView *alertView) {
        };
        _alertView.didDismissHandler = ^(SIAlertView *alertView) {
            alertView = nil;
        };
        _alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [_alertView show];
        
    }
}

- (void)calculateFrame
{
    [self setData];
    _timeImage.frame = ccr(10, 10, 16, 16);
    CGSize timeSize = [self getTextFromLabel:_timeLabel];
    _timeLabel.frame = ccr(CGRectGetMaxX(_timeImage.frame)+10,
                           _timeImage.origin.y,
                           timeSize.width,
                           16);
    _startImage.frame = ccr(_timeImage.origin.x,
                            CGRectGetMaxY(_timeImage.frame)+10,
                            _timeImage.width,
                            _timeImage.height);
    CGSize startSize = [self getTextFromLabel:_startLabel];
    _startLabel.frame = ccr(_timeLabel.origin.x,
                            CGRectGetMaxY(_timeLabel.frame)+10,
                            startSize.width,
                            16);
    _endImage.frame = ccr(_startImage.origin.x,
                          CGRectGetMaxY(_startImage.frame)+10,
                          _startImage.width,
                          _startImage.height);
    CGSize endSize = [self getTextFromLabel:_endLabel];
    _endLabel.frame = ccr(_startLabel.origin.x,
                          CGRectGetMaxY(_startLabel.frame)+10,
                          endSize.width,
                          16);
    
    if ([self.orderInfo.order_status intValue] == OrderStatusWatingForDriver) {
        UILabel *title = [UILabel labelWithFrame:ccr(SCREEN_WIDTH-100-10,
                                                     _timeLabel.y,
                                                     100,
                                                     _timeLabel.height)
                                           color:COLORRGB(0x63666b)
                                            font:HSFONT(12)
                                            text:@"嘟嘟为您提供服务"
                                       alignment:NSTextAlignmentRight
                                   numberOfLines:1];
        [_headerView addSubview:title];
        _timerImageView.frame = ccr(SCREEN_WIDTH-30-40, CGRectGetMaxY(title.frame)+10, 40, 40);
        _timerLabel.frame = ccr(0, 0, _timerImageView.width, _timerImageView.height);
    }
    
    _headerView.frame = ccr(0,
                            0,
                            SCREEN_WIDTH,
                            CGRectGetMaxY(_endLabel.frame)+10);
    _bottomLine.frame = ccr(0,
                            CGRectGetMaxY(_headerView.frame)-0.5,
                            SCREEN_WIDTH,
                            0.5);
    CGSize noticeSize = [self getTextFromLabel:_noticeLabel];
    _noticeLabel.frame = ccr((SCREEN_WIDTH-noticeSize.width)/2,
                             CGRectGetMaxY(_headerView.frame)+30,
                             noticeSize.width,
                             noticeSize.height);
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (self.resultStatus == OrderResultHaveOtherCar) {
        for (int i=0; i<self.carStore.cars.count; i++) {
            CarModel *car = self.carStore.cars[i];
            UIButton *carBtn = [UIButton buttonWithImageName:@"orgbtn"
                                                 hlImageName:@"orgbtn_pressed"
                                                       title:car.car_style_name
                                                  titleColor:COLORRGB(0xffffff)
                                                        font:HSFONT(15)
                                                  onTapBlock:^(UIButton *btn) {
                                                      [self changeOrderToCarStyle:car];
                                                  }];
            carBtn.frame = ccr(10, CGRectGetMaxY(_noticeLabel.frame) + 10 + 40*i, SCREEN_WIDTH-20, 40);
            [self.view addSubview:carBtn];
        }
    }
    
}

- (void)changeOrderToCarStyle:(CarModel *)car
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:
                    ORDER_CHANGE_ORDER_CAR_STYLE([self.orderInfo.order_id stringValue],
                                                 [car.car_style_id stringValue])
                           parameters:nil
                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                  [self.carStore.cars removeAllObjects];
                                  self.resultStatus = OrderResultChangedCar;
                                  [self calculateFrame];
                                  [ZBCToast showMessage:@"修改车型成功，请耐心等候"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
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
