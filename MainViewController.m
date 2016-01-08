//
//  MainViewController.m
//  DuDu
//
//  Created by i-chou on 11/4/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MainViewController.h"
#import "CouponModel.h"
#import "OrderVC.h"
#import "LoginVC.h"
#import "CouponStore.h"
#import "OrderHistoryModel.h"
#import <objc/runtime.h>

#define PADDING 10
#define bottomToolBar_Height  88

@interface MainViewController ()

@end

@implementation MainViewController
{
    BottomToolBar   *_bottomToolBar;
    TimePicker      *_timePicker;
    UIActivityIndicatorView *_activityView;
    MenuTableViewController *_menuVC;
    OrderVC                 *_orderVC;
    
    NSString        *_currentCity;
    NSMutableArray  *_annotations;
    UIButton        *_locationBtn;
    QPointAnnotation   *_fromPointAnnotation;
    QPointAnnotation   *_toPointAnnotation;
    BOOL            _isFirstAppear;
    BOOL            _isRightNow;
    NSTimeInterval  _startTimeStr;
    BOOL            _isUpdated;
    QMSRoutePlan    *_currentRoutPlan;
    CouponModel     *_currentCoupon;
}

+ (instancetype)sharedMainViewController
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedMainViewController = nil;
    dispatch_once(&pred, ^{
        _sharedMainViewController = [[self alloc] init];
    });
    return _sharedMainViewController;
}

- (id)init
{
    self = [super init];
    if (self) {
        _annotations = [NSMutableArray array];
        _menuVC = [[MenuTableViewController alloc] init];
        _menuVC.title = @"个人中心";
        
        _orderVC = [[OrderVC alloc] init];
        _orderVC.title = @"正在为你预约车辆";
        _fromLocation = [[QUserLocation alloc] init];
        _toLocation = [[QUserLocation alloc] init];
//        _fromPointAnnotation = [[QPointAnnotation alloc] init];
//        _toPointAnnotation = [[QPointAnnotation alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirstAppear = YES;
    
    [self setupLeftMenuButton];
    
    [QMapServices sharedServices].apiKey = QMAP_KEY;
    [QMSSearchServices sharedServices].apiKey = QMAP_KEY;
    
    self.search = [[QMSSearcher alloc] initWithDelegate:self];
    
    self.mapView = [[QMapView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    NSLog(@"%f",self.mapView.maxZoomLevel);
    
    self.mapView.userTrackingMode = QUserTrackingModeNone;
    
    self.topToolBar = [[TopToolBar alloc] initWithFrame:ccr(0,
                                                            NAV_BAR_HEIGHT_IOS7,
                                                            SCREEN_WIDTH,
                                                            50)
                                              carStyles:self.carStyles];
    self.topToolBar.delegate = self;
    [self.view addSubview:self.topToolBar];
    
    _bottomToolBar = [[BottomToolBar alloc] initWithFrame:ccr(PADDING,
                                                              SCREEN_HEIGHT-bottomToolBar_Height-PADDING,
                                                              SCREEN_WIDTH-PADDING*2,
                                                              bottomToolBar_Height)];
    _bottomToolBar.delegate = self;
    [self.view addSubview:_bottomToolBar];
    
    _timePicker = [[TimePicker alloc] initWithFrame:ccr(0, SCREEN_HEIGHT, SCREEN_WIDTH, 264)];
    _timePicker.delegate = self;
    [self.view addSubview:_timePicker];
    
    _locationBtn = [UIButton buttonWithImageName:@"userPosition"
                                     hlImageName:@"userPosition"
                                      onTapBlock:^(UIButton *btn) {
                                          [self startLocation];
                                      }];
    _locationBtn.frame = ccr(PADDING, CGRectGetMaxY(self.topToolBar.frame)+PADDING, 30, 30);
    _locationBtn.layer.masksToBounds = YES;
    _locationBtn.layer.borderWidth = 2;
    _locationBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _locationBtn.layer.cornerRadius = _locationBtn.width/2;
    [self.view addSubview:_locationBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_isFirstAppear) {
        _isFirstAppear = NO;
        [self startLocation];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
}

#pragma mark - 开始定位当前位置
- (void)startLocation
{
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:QUserTrackingModeFollow animated:YES];
    [self.mapView setZoomLevel:16.1 animated:YES];
}

-(void)setupLeftMenuButton
{
    UIButton *leftBtn = [UIButton buttonWithImageName:@"account" hlImageName:@"account_pressed"onTapBlock:^(UIButton *btn) {
        if ([self checkHaveLogin]) {
            [self.navigationController pushViewController:_menuVC animated:YES];
        } else {
            LoginVC *loginVC = [[LoginVC alloc] init];
            loginVC.delegate = self;
            loginVC.title = @"验证手机";
            ZBCNavVC *navVC = [[ZBCNavVC alloc] initWithRootViewController:loginVC];
            [self presentViewController:navVC animated:YES completion:nil];
        }
    }];
    leftBtn.frame = ccr(0, 0, 30, 30);
    UIBarButtonItem *BarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:BarItem animated:YES];
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

- (void)showFromAddressPicker
{
    GeoAndSuggestionViewController *searchVC = [[GeoAndSuggestionViewController alloc] init];
    searchVC.delegate = self;
    searchVC.title = @"出发地";
    searchVC.isFrom = YES;
    searchVC.currentCity = _currentCity;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)showToAddressPicker
{
    GeoAndSuggestionViewController *searchVC = [[GeoAndSuggestionViewController alloc] init];
    searchVC.delegate = self;
    searchVC.title = @"目的地";
    searchVC.isFrom = NO;
    searchVC.currentCity = _currentCity;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 发送订单
/*
- (void)sentOrder:(OrderModel *)orderInfo
{
    //TODO:让后台把接口返回同一字段类型统一
    OrderModel *order = [MTLJSONAdapter modelOfClass:[OrderModel class]
                                  fromJSONDictionary:[DuDuAPIClient parseJSONFrom:[Utils testDicFrom:@"orderInfo"][@"info"]]
                                               error:nil];
 
    [OrderVC sharedOrderVC].orderInfo = order;
    [self.navigationController pushViewController:[OrderVC sharedOrderVC] animated:YES];
}
*/

- (void)sentOrder:(OrderModel *)orderInfo
{
    NSString *url = ADD_ORDER(orderInfo.start_lat,
                              orderInfo.start_lng,
                              orderInfo.star_loc_str,
                              orderInfo.dest_lat,
                              orderInfo.dest_lng,
                              orderInfo.dest_loc_str,
                              orderInfo.car_style,
                              orderInfo.startTimeType,
                              orderInfo.startTimeStr);
    
    [[DuDuAPIClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        
        if(dic[@"err"] &&
           ([dic[@"err"] intValue] == 11 ||
           [dic[@"err"] intValue] == 17 ||
           [dic[@"err"] intValue] == 0)) {
            
            OrderModel *orderInfo = [MTLJSONAdapter modelOfClass:[OrderModel class]
                                              fromJSONDictionary:dic[@"info"]
                                                           error:nil];
            if ([dic[@"err"] intValue] == 17 || [dic[@"err"] intValue] == 0) {
                CarStore *carStore = [[CarStore alloc] init];
                carStore.cars = [MTLJSONAdapter modelOfClass:[CarModel class]
                                          fromJSONDictionary:dic[@"car_style"]
                                                       error:nil];
                [OrderVC sharedOrderVC].carStore = carStore;
            }
            
            [OrderVC sharedOrderVC].orderInfo = orderInfo;
            [OrderVC sharedOrderVC].result = [dic[@"err"] intValue];
            [OrderVC sharedOrderVC].title = @"订单信息";
            [OrderVC sharedOrderVC].orderStatusInfo = dic[@"order_info"];
            [self.navigationController pushViewController:[OrderVC sharedOrderVC] animated:YES];
        } else if([dic[@"err"] intValue] == 5) {
            [ZBCToast showMessage:@"优惠券不可用"];
            return;
        } else if([dic[@"err"] intValue] == 12){
            [ZBCToast showMessage:dic[@"order_info"]];
            return;
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}


#pragma mark - 获取优惠信息

//TODO:remove test
/*
- (void)getCouponInfo
{
    NSArray *arr = [DuDuAPIClient parseJSONFrom:[Utils testDicFrom:@"couponInfo"]][@"info"];
    CouponStore *coupons = [[CouponStore alloc] init];
    coupons.info = [MTLJSONAdapter modelsOfClass:[CouponModel class]
                                   fromJSONArray:arr
                                           error:nil];
    [MenuTableViewController sharedMenuTableViewController].coupons = coupons;
    
    CouponModel *coupon = coupons.info.count?coupons.info[0]:nil;
    [self guessChargeWithCoupon:coupon routPlan:_currentRoutPlan carStyle:_currentCar];
}
*/


- (void)getCouponInfo
{
    [[DuDuAPIClient sharedClient] GET:USER_COUPON_INFO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[CouponModel class]
                                       fromJSONArray:dic[@"info"]
                                               error:nil];
        [CouponStore sharedCouponStore].info = arr;
                                
        [MenuTableViewController sharedMenuTableViewController].coupons = [CouponStore sharedCouponStore];
        
        _currentCoupon = [CouponStore sharedCouponStore].info.count?[CouponStore sharedCouponStore].info[0]:nil;
        [self guessChargeWithCoupon:_currentCoupon routPlan:_currentRoutPlan carStyle:_currentCar];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _bottomToolBar.couponLabel.text = @"暂无优惠";
    }];
}


#pragma mark - 估算费用
- (void)guessChargeWithCoupon:(CouponModel *)coupon routPlan:(QMSRoutePlan *)plan carStyle:(CarModel *)car
{
    float distance = plan.distance/1000; //距离
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
    
    //保证费用不少于起步价
    if (charge < start_money) {
        charge = start_money;
    }
    
    //根据不同优惠类型计算折扣价
    if (coupon && [coupon.coupon_discount floatValue] < 1) {
        charge = charge * [coupon.coupon_discount floatValue];
    } else {
        charge = charge - [coupon.coupon_discount floatValue];
    }
    
    //保证费用为非负数
    if (charge < 0) {
        charge = 0;
    }
    
    [_bottomToolBar updateCharge:[NSString stringWithFormat:@"%.1f",charge] coupon:coupon];
}

#pragma mark - 发送打车订单
- (void)didSubmited
{
    OrderModel *orderInfo = [[OrderModel alloc] init];
    orderInfo.user_id = [NSNumber numberWithInt:[[UICKeyChainStore stringForKey:KEY_STORE_USERID service:KEY_STORE_SERVICE] intValue]];
    orderInfo.start_lat = [NSNumber numberWithFloat:_fromLocation.location.coordinate.latitude];
    orderInfo.start_lng = [NSNumber numberWithFloat:_fromLocation.location.coordinate.longitude];
    orderInfo.star_loc_str = _bottomToolBar.fromAddressLabel.text;
    orderInfo.dest_lat = [NSNumber numberWithFloat:_toLocation.location.coordinate.latitude];
    orderInfo.dest_lng = [NSNumber numberWithFloat:_toLocation.location.coordinate.longitude];
    orderInfo.dest_loc_str = _bottomToolBar.toAddressLabel.text;
    orderInfo.car_style = _currentCar.car_style_id;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [date timeIntervalSince1970]*1;
    orderInfo.startTimeStr = [NSString stringWithFormat:@"%f",now];
    orderInfo.startTimeType = [NSNumber numberWithInt:_isRightNow];
    
    [self sentOrder:orderInfo];
}

#pragma mark - GeoAndSuggestionViewControllerDelegate

- (void)addressPicker:(GeoAndSuggestionViewController *)vc fromAddress:(QMSSuggestionPoiData *)fromLoc toAddress:(QMSSuggestionPoiData *)toLoc
{
    if (fromLoc) {
        NSLog(@"toLoc:%f,%f",fromLoc.location.latitude,fromLoc.location.longitude);
        [_fromLocation setCoordinate:fromLoc.location];
        [_fromLocation setTitle:fromLoc.title];
        
        _bottomToolBar.fromAddressLabel.text = fromLoc.title;
        [self setupAnnotation:YES];
    }
    if (toLoc){
        NSLog(@"toLoc:%f,%f",toLoc.location.latitude,toLoc.location.longitude);
        [_toLocation setCoordinate:toLoc.location];
        [_toLocation setTitle:toLoc.title];
        
        _bottomToolBar.toAddressLabel.text = toLoc.title;
        _bottomToolBar.toAddressLabel.textColor = COLORRGB(0x63666b);
        [_bottomToolBar showChargeView:YES];
        
        [self setupAnnotation:NO];
        [self getCouponInfo];
    }
}


#pragma mark - LoginVCDelegate
- (void)loginSucceed:(UserModel *)userInfo
{
    [MenuTableViewController sharedMenuTableViewController].userInfo = userInfo;
    [self.navigationController pushViewController:[MenuTableViewController sharedMenuTableViewController] animated:YES];
}

#pragma mark - TopToolBarDelegate

- (void)topToolBar:(TopToolBar *)topToolBar didCarButonTapped:(int)index
{
    _currentCar = self.carStyles[index];
    [self guessChargeWithCoupon:_currentCoupon routPlan:_currentRoutPlan carStyle:_currentCar];
}

#pragma mark - BottomToolBarDelegate

- (void)bottomToolBar:(BottomToolBar *)toolBar didTapped:(UILabel *)label
{
    if (label == toolBar.startTimeLabel) {
        [self showTimePicker:YES];
    } else if (label == toolBar.fromAddressLabel) {
        self.mapView.showsUserLocation = NO;
        [self showFromAddressPicker];
    } else if (label == toolBar.toAddressLabel) {
        [self showToAddressPicker];
    } else if (label == toolBar.couponLabel){
        [self getCouponInfo];
    } else {
        //do nothing
    }
}

#pragma mark - TimePickerDelegate

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp isRightNow:(BOOL)isRightNow
{
    _isRightNow = isRightNow;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    _bottomToolBar.startTimeLabel.text = [date displayWithFormat:@"d号H点mm分"];
    _startTimeStr = timeStamp;
    [self showTimePicker:NO];
}

- (void)timePickerViewDidCancel
{
    [self showTimePicker:NO];
}


#pragma mark - ------------- MapView 相关代码 -------------

#pragma mark - 地图打点完成 delegate

- (void)mapView:(QMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    QAnnotationView *view = views[0];
    [self.mapView selectAnnotation:view.annotation animated:YES];
}

#pragma mark - 自定义打头阵样式

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
    static NSString *reuseId = @"REUSE_ID";
    QPinAnnotationView *annotationView = (QPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    
    if (nil == annotationView) {
        annotationView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
    }
    
    annotationView.canShowCallout   = YES;
    UILabel *title = [[UILabel alloc] initWithFrame:ccr(0,0,50, 20)];
    title.font = HSFONT(15);
    title.textColor = COLORRGB(0x63666b);
    title.textAlignment = NSTextAlignmentCenter;
    
    annotationView.rightCalloutAccessoryView = title;

    if (annotation == _fromPointAnnotation) {
        annotationView.pinColor = QPinAnnotationColorGreen;
        title.text = @"起点";
    } else if (annotation == _toPointAnnotation) {
        annotationView.pinColor = QPinAnnotationColorRed;
        title.text = @"终点";
    } else {
        return nil;
    }
    
    return annotationView;
}

#pragma mark - 地图开始定位 delegate

- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    NSLog(@"开始定位");
    _bottomToolBar.fromAddressLabel.text = @"定位中...";
}

#pragma mark - 地图停止定位 delegate

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    NSLog(@"停止定位");
}

#pragma mark - 地图更新定位 delegate

- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation && !_isUpdated) {
        _fromLocation = userLocation;
        QMSReverseGeoCodeSearchOption *regeocoder = [[QMSReverseGeoCodeSearchOption alloc] init];
        [regeocoder setLocation:[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude]];
//        [regeocoder setLocationWithCenterCoordinate:userLocation.location.coordinate];
        
        //返回坐标点附近poi列表
        [regeocoder setGet_poi:NO];
        //设置坐标所属坐标系，以返回正确地址，默认为腾讯所用坐标系
        [regeocoder setCoord_type:QMSReverseGeoCodeCoordinateTencentGoogleGaodeType];
        [self.search searchWithReverseGeoCodeSearchOption:regeocoder];
    }
}

#pragma mark - ------------- MapView Search 相关代码 -------------

#pragma mark - 根据定位解析出位置信息

- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult
{
    _bottomToolBar.fromAddressLabel.text = reverseGeoCodeSearchResult.formatted_addresses.recommend;
    _currentCity = reverseGeoCodeSearchResult.ad_info.province;
    [self setupAnnotation:YES];
    _isUpdated = YES;
}

#pragma mark -  地图打点
- (void)setupAnnotation:(BOOL)isFrom
{
    if (isFrom) {
        for (QPointAnnotation *point in self.mapView.annotations) {
            if (_fromPointAnnotation == point) {
                [self.mapView removeAnnotation:_fromPointAnnotation];
            }
        }
        if (!_fromPointAnnotation) {
            _fromPointAnnotation = [[QPointAnnotation alloc] init];
        }
        [self.mapView setCenterCoordinate:_fromLocation.coordinate];
        [_fromPointAnnotation setCoordinate:_fromLocation.coordinate];
        [self.mapView setZoomLevel:16.1 animated:YES];
        [self.mapView addAnnotation:_fromPointAnnotation];
    } else {
        for (QPointAnnotation *point in self.mapView.annotations) {
            if (_toPointAnnotation == point) {
                [self.mapView removeAnnotation:_toPointAnnotation];
            }
        }
        if (!_toPointAnnotation) {
            _toPointAnnotation = [[QPointAnnotation alloc] init];
        }
        [_toPointAnnotation setCoordinate:_toLocation.coordinate];
        [self.mapView setCenterCoordinate:_toLocation.coordinate zoomLevel:16.1 animated:YES];
        [self.mapView addAnnotation:_toPointAnnotation];
    }
    if (_fromPointAnnotation && _toPointAnnotation) {
        QMSDrivingRouteSearchOption *driving = [[QMSDrivingRouteSearchOption alloc] init];
        [driving setFromCoordinate:_fromPointAnnotation.coordinate];
        [driving setToCoordinate:_toPointAnnotation.coordinate];
        //驾车路线规划支持多种规划策略（设置成综合最优策略）
        [driving setPolicyWithType:QMSDrivingRoutePolicyTypeRealTraffic];
        [self.search searchWithDrivingRouteSearchOption:driving];
    }
}

- (void)searchWithDrivingRouteSearchOption:(QMSDrivingRouteSearchOption *)drivingRouteSearchOption didRecevieResult:(QMSDrivingRouteSearchResult *)drivingRouteSearchResult
{
    _currentRoutPlan = [[drivingRouteSearchResult routes] firstObject];
    NSLog(@"距离：%@ | 时间：%@ | 路段数%ld", [self humanReadableForDistance:_currentRoutPlan.distance], [self humanReadableForTimeDuration:_currentRoutPlan.duration],_currentRoutPlan.steps.count);
    
    [self.mapView removeOverlays:self.mapView.overlays];
    NSUInteger count = _currentRoutPlan.polyline.count;
    CLLocationCoordinate2D coordinateArray[count];
    for (int i = 0; i < count; ++i)
    {
        [[_currentRoutPlan.polyline objectAtIndex:i] getValue:&coordinateArray[i]];
    }
    
    QPolyline *walkPolyline = [QPolyline polylineWithCoordinates:coordinateArray count:count];
    [self.mapView addOverlay:walkPolyline];
    [self guessChargeWithCoupon:_currentCoupon routPlan:_currentRoutPlan carStyle:_currentCar];
}

#pragma mark - 地图描绘路线

- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    QPolyline *polyline = (QPolyline *)overlay;
    QPolylineView *polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
    
    polylineView.lineWidth = 5;
    
    if (polyline.dash)
    {
        polylineView.lineDashPattern = @[@3, @9];
        polylineView.strokeColor = [UIColor colorWithRed:0x55/255.f green:0x79/255.f blue:0xff/255.f alpha:1];
    }
    else
    {
        polylineView.lineDashPattern = nil;
        polylineView.strokeColor = [UIColor colorWithRed:0x00/255.f green:0x79/255.f blue:0xff/255.f alpha:1];
    }
    
    return polylineView;
}

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
