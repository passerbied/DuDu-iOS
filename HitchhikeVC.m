//
//  HitchhikeVC.m
//  DuDu
//
//  Created by i-chou on 2/2/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "HitchhikeVC.h"
#import "OrderVC.h"

@interface HitchhikeVC ()

@end

@implementation HitchhikeVC
{
    HitchhikeView   *_hitchhikeView;
    TimePicker      *_timePicker;
    CountPicker     *_countPicker;
    
    NSTimeInterval  _startTimeStr;
    int             _peopleCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubviews];
    
}

- (void)createSubviews
{
    UIView *headerView = [[UIView alloc] initWithFrame:ccr(0, NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, 80)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLORRGB(0xf0f0f0);
    UILabel *content = [UILabel labelWithFrame:ccr(20, 0, SCREEN_WIDTH, headerView.height)
                                         color:COLORRGB(0x63666b)
                                          font:HSFONT(18)
                                          text:@"嘟嘟会热心的服务每一位乘客"
                                     alignment:NSTextAlignmentLeft
                                 numberOfLines:1];
    [headerView addSubview:content];
    _hitchhikeView = [[HitchhikeView alloc] init];
    _hitchhikeView.delegate = self;
    _hitchhikeView.origin = ccp(0, CGRectGetMaxY(headerView.frame));
    [self.view addSubview:_hitchhikeView];
    
    UIButton *submitBtn = [UIButton buttonWithImageName:@"orgbtn" hlImageName:@"orgbtn_pressed" title:@"确认发布" titleColor:COLORRGB(0xffffff) font:HSFONT(15) onTapBlock:^(UIButton *btn) {
        [self sentOrder];
    }];
    submitBtn.frame = ccr(10, CGRectGetMaxY(_hitchhikeView.frame)+40, SCREEN_WIDTH-20, 40);
    [self.view addSubview:submitBtn];
    
    _timePicker = [[TimePicker alloc] initWithFrame:ccr(0, SCREEN_HEIGHT, SCREEN_WIDTH, 264)];
    _timePicker.delegate = self;
    _timePicker.isAppointment = YES;
    [self.view addSubview:_timePicker];
    
    _countPicker = [[CountPicker alloc] initWithFrame:ccr(0, SCREEN_HEIGHT, SCREEN_WIDTH, 264)];
    _countPicker.delegate = self;
    [self.view addSubview:_countPicker];
}

- (void)sentOrder
{
    OrderModel *order = [[OrderModel alloc] init];
    order.user_id = [NSNumber numberWithInt:[[UICKeyChainStore stringForKey:KEY_STORE_USERID service:KEY_STORE_SERVICE] intValue]];
    
    order.start_lat = [NSString stringWithFormat:@"%.6f",_fromLocation.coordinate.latitude];
    order.start_lng = [NSString stringWithFormat:@"%.6f",_fromLocation.coordinate.longitude];
    order.dest_lat = [NSString stringWithFormat:@"%.6f",_toLocation.coordinate.latitude];
    order.dest_lng = [NSString stringWithFormat:@"%.6f",_toLocation.coordinate.longitude];
    order.star_loc_str = _hitchhikeView.startLocationLabel.text;
    order.dest_loc_str = _hitchhikeView.destLocationLabel.text;
    order.car_style = self.currentCar.car_style_id;
    order.startTimeStr = [NSString stringWithFormat:@"%d",(int)_startTimeStr];
    order.startTimeType = [NSNumber numberWithInt:1];
    
    NSString *url = ADD_ORDER(order.start_lat,
                              order.start_lng,
                              order.star_loc_str,
                              order.dest_lat,
                              order.dest_lng,
                              order.dest_loc_str,
                              order.car_style,
                              order.startTimeType,
                              order.startTimeStr,
                              @"",
                              _peopleCount);
    
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [ZBCToast showMessage:@"顺风车订单发送成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [ZBCToast showMessage:@"顺风车订单发送失败"];
    }];
}

- (void)showTimePicker:(BOOL)show
{
    if (show) {
        [UIView animateWithDuration:0.3 animations:^{
            _timePicker.y = SCREEN_HEIGHT - _timePicker.height;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _timePicker.y = SCREEN_HEIGHT;
        }];
    }
}

- (void)showCountPicker:(BOOL)show
{
    if (show) {
        [UIView animateWithDuration:0.3 animations:^{
            _countPicker.y = SCREEN_HEIGHT - _timePicker.height;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _countPicker.y = SCREEN_HEIGHT;
        }];
    }
}

- (void)showFromAddressPicker
{
    GeoAndSuggestionViewController *searchVC = [[GeoAndSuggestionViewController alloc] init];
    searchVC.delegate = self;
    searchVC.historyOrders = self.orderStore.history;
    searchVC.title = @"出发地";
    searchVC.isFrom = YES;
    searchVC.currentCity = self.currentCity;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)showToAddressPicker
{
    GeoAndSuggestionViewController *searchVC = [[GeoAndSuggestionViewController alloc] init];
    searchVC.delegate = self;
    searchVC.historyOrders = self.orderStore.history;
    searchVC.title = @"目的地";
    searchVC.isFrom = NO;
    searchVC.currentCity = self.currentCity;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - HitchhikeViewDelegate

- (void)hitchhikeView:(HitchhikeView *)hitchhikeView didTapped:(UILabel *)label
{
    if (label == hitchhikeView.startLocationLabel) {
        [self showFromAddressPicker];
    } else if (label == hitchhikeView.destLocationLabel) {
        [self showToAddressPicker];
    } else if (label == hitchhikeView.startTimeLabel) {
        [self showTimePicker:YES];
    } else if (label == hitchhikeView.peopleCountLabel) {
        [self showCountPicker:YES];
    }
}

#pragma mark - TimePickerDelegate

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp isRightNow:(BOOL)isRightNow
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    _hitchhikeView.startTimeLabel.text = [NSString stringWithFormat:@"%@ 出发",[date displayWithFormat:@"M月d日 HH:mm"]];
    _hitchhikeView.startTimeLabel.textColor = COLORRGB(0x63666b);
    _startTimeStr = timeStamp;
    [self showTimePicker:NO];
}

- (void)timePickerViewDidCancel
{
    [self showTimePicker:NO];
}

#pragma mark - CountPickerDelegate

- (void)countPicker:(CountPicker *)pickerView didSelectCount:(int)count
{
    _peopleCount = count;
    _hitchhikeView.peopleCountLabel.text = [NSString stringWithFormat:@"%d人",count];
    _hitchhikeView.peopleCountLabel.textColor = COLORRGB(0x63666b);
    [self showCountPicker:NO];
}

- (void)countPickerViewDidCancel
{
    [self showCountPicker:NO];
}

#pragma mark - GeoAndSuggestionViewControllerDelegate

- (void)addressPicker:(GeoAndSuggestionViewController *)vc fromAddress:(QMSSuggestionPoiData *)fromLoc toAddress:(QMSSuggestionPoiData *)toLoc
{
    if (fromLoc) {
        NSLog(@"fromLoc:%f,%f",fromLoc.location.latitude,fromLoc.location.longitude);
        [_fromLocation setCoordinate:fromLoc.location];
        [_fromLocation setTitle:fromLoc.title];
        
        _hitchhikeView.startLocationLabel.text = fromLoc.title;
        _hitchhikeView.startLocationLabel.textColor = COLORRGB(0x63666b);
    }
    if (toLoc){
        [_toLocation setCoordinate:toLoc.location];
        [_toLocation setTitle:toLoc.title];
        NSLog(@"toLoc:%f,%f,",toLoc.location.latitude,toLoc.location.longitude);
        
        _hitchhikeView.destLocationLabel.text = toLoc.title;
        _hitchhikeView.destLocationLabel.textColor = COLORRGB(0x63666b);
    }
}

@end
