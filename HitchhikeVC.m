//
//  HitchhikeVC.m
//  DuDu
//
//  Created by i-chou on 2/2/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "HitchhikeVC.h"
#import "OrderVC.h"
#import <objc/runtime.h>
#import "CouponStore.h"

@interface HitchhikeVC ()

@end

@implementation HitchhikeVC
{
    HitchhikeView   *_hitchhikeView;
    TimePicker      *_timePicker;
    CountPicker     *_countPicker;
    UILabel         *_priceLabel;
    
    NSTimeInterval  _startTimeStr;
    int             _peopleCount;
    
    QMSRoutePlan    *_currentRoutPlan;
    float           _currentMoney;
    BOOL            _isCalculated;
    BOOL            _isUpdated;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.fromLocation = [[QUserLocation alloc] init];
        self.toLocation = [[QUserLocation alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createSubviews];
    self.search = [[QMSSearcher alloc] initWithDelegate:self];
//    self.mapView.showsUserLocation = YES;
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
    if (self.fromLocationStr.length) {
        _hitchhikeView.startLocationLabel.textColor = COLORRGB(0x63666b);
    }
    _hitchhikeView.startLocationLabel.text = self.fromLocationStr;
    self.fromLocation.title = _hitchhikeView.startLocationLabel.text;
//    _fromLocation = self.fromLocation;
    [self.view addSubview:_hitchhikeView];

    _priceLabel = [UILabel labelWithFrame:ccr(0,
                                              CGRectGetMaxY(_hitchhikeView.frame)+10,
                                              SCREEN_WIDTH,
                                              20)
                                    color:COLORRGB(0xf39a00)
                                     font:HSFONT(15)
                                     text:@""
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [self.view addSubview:_priceLabel];
    
    
    UIButton *submitBtn = [UIButton buttonWithImageName:@"orgbtn" hlImageName:@"orgbtn_pressed" title:@"确认发布" titleColor:COLORRGB(0xffffff) font:HSFONT(15) onTapBlock:^(UIButton *btn) {
        if ([self checkValidity]) {
            [self sentOrder];
        }
        
    }];
    submitBtn.frame = ccr(10, CGRectGetMaxY(_priceLabel.frame)+10, SCREEN_WIDTH-20, 40);
    [self.view addSubview:submitBtn];
    
    _timePicker = [[TimePicker alloc] initWithFrame:ccr(0, SCREEN_HEIGHT, SCREEN_WIDTH, 264)];
    _timePicker.delegate = self;
    _timePicker.isAppointment = YES;
    [self.view addSubview:_timePicker];
    
    _countPicker = [[CountPicker alloc] initWithFrame:ccr(0, SCREEN_HEIGHT, SCREEN_WIDTH, 264)];
    _countPicker.delegate = self;
    [self.view addSubview:_countPicker];
}

- (BOOL)checkValidity
{
    if (!(self.fromLocation.title && self.toLocation.title && _peopleCount && _startTimeStr)){
        [ZBCToast showMessage:@"订单信息填写不完整"];
        return NO;
    }
    if (!_isCalculated) {
        [ZBCToast showMessage:@"正在计算价格，请稍等"];
        return NO;
    }
    return YES;
}

- (void)sentOrder
{
    OrderModel *order = [[OrderModel alloc] init];
    order.user_id = [NSNumber numberWithInt:[[UICKeyChainStore stringForKey:KEY_STORE_USERID service:KEY_STORE_SERVICE] intValue]];
    
    order.start_lat = [NSString stringWithFormat:@"%.6f",self.fromLocation.coordinate.latitude];
    order.start_lng = [NSString stringWithFormat:@"%.6f",self.fromLocation.coordinate.longitude];
    order.dest_lat = [NSString stringWithFormat:@"%.6f",self.toLocation.coordinate.latitude];
    order.dest_lng = [NSString stringWithFormat:@"%.6f",self.toLocation.coordinate.longitude];
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
                              _peopleCount,
                              _currentMoney);
    
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

#pragma mark - 估算费用
- (void)guessChargeWithRoutPlan:(QMSRoutePlan *)plan carStyle:(CarModel *)car
{
    float distance = plan.distance/1000; //距离
    if ([CouponStore sharedCouponStore].shareInfo.distance_length.length) {
        distance = distance * [[CouponStore sharedCouponStore].shareInfo.distance_length floatValue];//距离*距离系数(客户要求)
    }
    float duration = plan.duration; //时长
    float per_kilometer_money = car.per_kilometer_money; //起步里程每公里价格
    float per_max_kilometer = car.per_max_kilometer; //起步公里数
    float per_max_kilometer_money = car.per_max_kilometer_money; //超长每公里价格
    float wait_time_money = car.wait_time_money; //等时费
    float start_money = car.start_money; //起步价
    
    float charge = 0;
    
    //实际价格计算
    if (distance <= per_max_kilometer) {
        charge = distance*per_kilometer_money
        + duration*wait_time_money;
    } else {
        charge = per_max_kilometer*per_kilometer_money
        + (distance - per_max_kilometer)*per_max_kilometer_money
        + duration*wait_time_money;
    }
    
    //夜间服务费
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_startTimeStr];
    
    if ([Utils checkNightService:date]) {
        charge = charge * [_currentCar.night_service_times floatValue];
    }
    
    //保证费用不少于起步价(首单不受此约束)
    if (charge < start_money && ![[CouponStore sharedCouponStore].shareInfo.user_isFreeTaxi intValue]) {
        charge = start_money;
    }
    
    //保证费用为非负数
    if (charge < 0) {
        charge = 0;
    }
    _currentMoney = charge;
    if (_isCalculated && _peopleCount && _startTimeStr) {
        _priceLabel.text = [NSString stringWithFormat:@"一口价：%.1f元",charge];
    } else {
        _priceLabel.text = @"";
    }
}

#pragma mark - HitchhikeViewDelegate

- (void)hitchhikeView:(HitchhikeView *)hitchhikeView didTapped:(UILabel *)label
{
    if (label == hitchhikeView.startLocationLabel) {
        [self showFromAddressPicker];
        [self showCountPicker:NO];
        [self showTimePicker:NO];
    } else if (label == hitchhikeView.destLocationLabel) {
        [self showToAddressPicker];
        [self showCountPicker:NO];
        [self showTimePicker:NO];
    } else if (label == hitchhikeView.startTimeLabel) {
        [self showTimePicker:YES];
        [self showCountPicker:NO];
    } else if (label == hitchhikeView.peopleCountLabel) {
        [self showCountPicker:YES];
        [self showTimePicker:NO];
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
    [self guessChargeWithRoutPlan:_currentRoutPlan carStyle:_currentCar];
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
    [self guessChargeWithRoutPlan:_currentRoutPlan carStyle:_currentCar];
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
        [self.fromLocation setCoordinate:fromLoc.location];
        [self.fromLocation setTitle:fromLoc.title];
        
        _hitchhikeView.startLocationLabel.text = fromLoc.title;
        _hitchhikeView.startLocationLabel.textColor = COLORRGB(0x63666b);
    }
    if (toLoc){
        [self.toLocation setCoordinate:toLoc.location];
        [self.toLocation setTitle:toLoc.title];
        NSLog(@"toLoc:%f,%f,",toLoc.location.latitude,toLoc.location.longitude);
        
        _hitchhikeView.destLocationLabel.text = toLoc.title;
        _hitchhikeView.destLocationLabel.textColor = COLORRGB(0x63666b);
    }
    if (self.fromLocation.title && self.toLocation.title) {
        QMSDrivingRouteSearchOption *driving = [[QMSDrivingRouteSearchOption alloc] init];
        [driving setFromCoordinate:self.fromLocation.coordinate];
        [driving setToCoordinate:self.toLocation.coordinate];
        //驾车路线规划支持多种规划策略（设置成综合最优策略）
        [driving setPolicyWithType:QMSDrivingRoutePolicyTypeRealTraffic];
        [self.search searchWithDrivingRouteSearchOption:driving];
        
        _isCalculated = NO;
    }
}

- (void)searchWithDrivingRouteSearchOption:(QMSDrivingRouteSearchOption *)drivingRouteSearchOption didRecevieResult:(QMSDrivingRouteSearchResult *)drivingRouteSearchResult
{
    _isCalculated = YES;
    _currentRoutPlan = [[drivingRouteSearchResult routes] firstObject];
    NSLog(@"距离：%@ | 时间：%@ | 路段数%d", [self humanReadableForDistance:_currentRoutPlan.distance], [self humanReadableForTimeDuration:_currentRoutPlan.duration],(int)_currentRoutPlan.steps.count);
    
    NSUInteger count = _currentRoutPlan.polyline.count;
    CLLocationCoordinate2D coordinateArray[count];
    for (int i = 0; i < count; ++i)
    {
        [[_currentRoutPlan.polyline objectAtIndex:i] getValue:&coordinateArray[i]];
    }
    
    [self guessChargeWithRoutPlan:_currentRoutPlan carStyle:_currentCar];
}

//#pragma mark - 地图开始定位 delegate
//
//- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
//{
//    NSLog(@"开始定位");
//    _hitchhikeView.startLocationLabel.text = @"定位中...";
//}
//
//#pragma mark - 地图停止定位 delegate
//
//- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
//{
//    NSLog(@"停止定位");
//}
//
//#pragma mark - 地图更新定位 delegate
//
//- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
//{
//    if (updatingLocation && !_isUpdated) {
//        _fromLocation = userLocation;
//        QMSReverseGeoCodeSearchOption *regeocoder = [[QMSReverseGeoCodeSearchOption alloc] init];
//        [regeocoder setLocation:[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude]];
//        //返回坐标点附近poi列表
//        [regeocoder setGet_poi:NO];
//        [self.search searchWithReverseGeoCodeSearchOption:regeocoder];
//        _isUpdated = YES;
//    }
//}
//
//#pragma mark - ------------- MapView Search 相关代码 -------------
//
//#pragma mark - 根据定位解析出位置信息
//
//- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error
//{
//    _hitchhikeView.startLocationLabel.text = @"从哪儿出发";
//    _hitchhikeView.startLocationLabel.textColor = COLORRGB(0xdedede);
//}
//
//- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult
//{
//    if (reverseGeoCodeSearchResult.formatted_addresses) {
//        _hitchhikeView.startLocationLabel.text = reverseGeoCodeSearchResult.formatted_addresses.recommend;
//        _hitchhikeView.startLocationLabel.textColor = COLORRGB(0x63666b);
//    } else {
//        _hitchhikeView.startLocationLabel.text = @"从哪儿出发";
//        _hitchhikeView.startLocationLabel.textColor = COLORRGB(0xdedede);
//    }
//    _currentCity = reverseGeoCodeSearchResult.ad_info.province;
//}


#pragma mark - Utils

/*!
 *  @brief  格式化距离
 *
 *  @param distance 距离,单位是米
 *  @return 格式化字符串
 *  @detial
 *  (1) 567  ---> 567米
 *  (2) 1567 ---> 1.5公里
 *  (3) 2000 ---> 2公里
 */
- (NSString*) humanReadableForDistance:(double)distance
{
    NSString *humanReadable = nil;
    
    NSInteger theLength = (NSInteger)distance;
    
    // 米.
    if (theLength < 1000)
    {
        humanReadable = [NSString stringWithFormat:@"%ld米", (long)theLength];
    }
    // 公里.
    else
    {
#define WCLUtilityZeroEnd @".0"
        
        humanReadable = [NSString stringWithFormat:@"%.1f", theLength / 1000.0];
        
        BOOL zeroEnd = [humanReadable hasSuffix:WCLUtilityZeroEnd];
        
        // .0结尾, 去掉尾数.
        if (zeroEnd)
        {
            humanReadable = [humanReadable substringWithRange:NSMakeRange(0, humanReadable.length - WCLUtilityZeroEnd.length)];
        }
        
        humanReadable = [humanReadable stringByAppendingString:@"公里"];
    }
    
    return humanReadable;
}

/*!
 *  @brief  格式化时间
 *
 *  @param timeDuration 时间,单位是分钟
 *  @return 格式化字符串
 *  @detial
 *  (1) 10  ---> 10分钟
 *  (2) 120 ---> 2小时
 *  (3) 124 ---> 2小时4分钟
 */
- (NSString *)humanReadableForTimeDuration:(double) timeDuration
{
    NSString *humanReadable = nil;
    
    NSInteger theDuration = (NSInteger)timeDuration;
    
    // 分.
    if (theDuration < 60)
    {
        humanReadable = [NSString stringWithFormat:@"%ld分钟", (long)theDuration];
    }
    // 小时.
    else
    {
        humanReadable = [NSString stringWithFormat:@"%ld小时", (long)theDuration / 60];
        
        double remainder = fmod(theDuration, 60.0);
        
        if (remainder != 0)
        {
            NSString *remainderHumanReadable = [self humanReadableForTimeDuration:remainder];
            
            humanReadable = [humanReadable stringByAppendingString:remainderHumanReadable];
        }
    }
    
    return humanReadable;
}

@end

static char *QMSPolylineDashKey = "kQMSPolylineDashKey";

@implementation QPolyline (RouteExtention)

- (void)setDash:(BOOL)dash
{
    objc_setAssociatedObject(self, QMSPolylineDashKey, [NSNumber numberWithBool:dash], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)dash
{
    NSNumber *dashNum = objc_getAssociatedObject(self, QMSPolylineDashKey);
    return [dashNum boolValue];
}

@end
