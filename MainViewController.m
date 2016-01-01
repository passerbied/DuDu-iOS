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
    
    AMapReGeocode   *_currentReGeocode;
    NSMutableArray  *_annotations;
    UIButton        *_locationBtn;
    AMapGeoPoint    *_fromPoint;
    AMapGeoPoint    *_toPoint;
    BOOL            _isFirstAppear;
    BOOL            _isRightNow;
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
        _orderVC.title = @"正在为你预约嘟嘟快车";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirstAppear = YES;
    
    [self setupLeftMenuButton];
    
    [AMapSearchServices sharedServices].apiKey = AMAP_KEY;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.mapView = [[MAMapView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    
    self.topToolBar = [[TopToolBar alloc] initWithFrame:ccr(0, NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, 50) carStyles:self.carStyles];
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
    
    _locationBtn = [UIButton buttonWithImageName:@"userPosition" hlImageName:@"userPosition" onTapBlock:^(UIButton *btn) {
        self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
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
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.mapView setZoomLevel:16.1 animated:YES];
}

-(void)setupLeftMenuButton
{
    UIButton *leftBtn = [UIButton buttonWithImageName:@"account"
                                          hlImageName:@"account_pressed"
                                           onTapBlock:^(UIButton *btn) {
                                               
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
    AddressPickerViewController *addressPickerVC = [[AddressPickerViewController alloc] init];
    addressPickerVC.title = @"出发地";
    addressPickerVC.isFrom = YES;
    addressPickerVC.delegate = self;
    addressPickerVC.location = _currentReGeocode.formattedAddress;
    [self.navigationController pushViewController:addressPickerVC animated:YES];
}

- (void)showToAddressPicker
{
    AddressPickerViewController *addressPickerVC = [[AddressPickerViewController alloc] init];
    addressPickerVC.title = @"目的地";
    addressPickerVC.isFrom = NO;
    addressPickerVC.location = _currentReGeocode.formattedAddress;
    addressPickerVC.delegate = self;
    [self.navigationController pushViewController:addressPickerVC animated:YES];
}

#pragma mark - TopToolBarDelegate

- (void)topToolBar:(TopToolBar *)topToolBar didCarButonTapped:(int)index
{
    _current_car_style = self.carStyles[index];
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
        
    } else {
        
    }
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
        CarStore *carStore = [[CarStore alloc] init];
        OrderModel *orderInfo;
        if ([dic[@"err"] intValue] == 11) {
            orderInfo = [MTLJSONAdapter modelOfClass:[OrderModel class]
                                  fromJSONDictionary:dic[@"have"]
                                               error:nil];
        } else if([dic[@"err"] intValue] == 5){
            [ZBCToast showMessage:@"优惠券不可用"];
            return;
        } else if([dic[@"err"] intValue] == 12 ||
                  [dic[@"err"] intValue] == 17 ||
                  [dic[@"err"] intValue] == 0){
            orderInfo = [MTLJSONAdapter modelOfClass:[OrderModel class]
                                  fromJSONDictionary:dic[@"info"]
                                               error:nil];
            carStore.cars = [MTLJSONAdapter modelOfClass:[CarModel class]
                                      fromJSONDictionary:dic[@"car_style"]
                                                   error:nil];
        } else {
        }
        
        [OrderVC sharedOrderVC].orderInfo = orderInfo;
        [OrderVC sharedOrderVC].result = [dic[@"err"] intValue];
        [OrderVC sharedOrderVC].carStore = carStore;
        [self.navigationController pushViewController:[OrderVC sharedOrderVC] animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}


#pragma mark - 获取优惠信息

//TODO:remove test
- (void)getCouponInfo
{
    NSArray *arr = [DuDuAPIClient parseJSONFrom:[Utils testDicFrom:@"couponInfo"]][@"info"];
    CouponStore *coupons = [[CouponStore alloc] init];
    coupons.info = [MTLJSONAdapter modelsOfClass:[CouponModel class]
                                   fromJSONArray:arr
                                           error:nil];
    [MenuTableViewController sharedMenuTableViewController].coupons = coupons;
    
    CouponModel *coupon = coupons.info.count?coupons.info[0]:nil;
    [self guessChargeWithCoupon:coupon];
}

/*
- (void)getCouponInfo
{
    [[DuDuAPIClient sharedClient] GET:USER_COUPON_INFO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        CouponStore *coupons = [MTLJSONAdapter modelOfClass:[CouponStore class]
                                         fromJSONDictionary:dic
                                                      error:nil];
        [MenuTableViewController sharedMenuTableViewController].coupons = coupons;
        
        CouponModel *coupon = coupons.info.count?coupons.info[0]:nil;
        [self guessChargeWithCoupon:coupon];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _bottomToolBar.budgetLabel.text = @"无法估算费用";
        _bottomToolBar.couponLabel.text = @"暂无优惠";
    }];
}
*/

#pragma mark - 估算费用
- (void)guessChargeWithCoupon:(CouponModel *)coupon
{
    //TODO:估算逻辑
    //1.根据地图的驾驶路线得到，路程长度
    //2.根据车辆类型的每公里价格，和超出多少公里后每公里价格计算出里程价格
    //3.根据地图的驾驶路线，得到路线中有多少路段。假的每个路段等时1分钟，计算等时费
    //4.预估价格=里程费 + 起步价 + 等时费 - 优惠
    
    if (coupon) {
        [_bottomToolBar updateCharge:@"20" coupon:coupon];
    } else {
        _bottomToolBar.couponLabel.text = @"暂无优惠";
    }
}

#pragma mark - 发送打车订单
- (void)didSubmited
{
    OrderModel *orderInfo = [[OrderModel alloc] init];
    orderInfo.user_id = [NSNumber numberWithInt:[[UICKeyChainStore stringForKey:KEY_STORE_USERID service:KEY_STORE_SERVICE] intValue]];
    orderInfo.start_lat = STR_F(_fromPoint.latitude);
    orderInfo.start_lng = STR_F(_fromPoint.longitude);
    orderInfo.star_loc_str = _bottomToolBar.fromAddressLabel.text;
    orderInfo.dest_lat = STR_F(_toPoint.latitude);
    orderInfo.dest_lng = STR_F(_toPoint.longitude);
    orderInfo.dest_loc_str = _bottomToolBar.toAddressLabel.text;
    orderInfo.car_style = _current_car_style.car_style_id;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [date timeIntervalSince1970]*1;
    orderInfo.startTimeStr = [NSString stringWithFormat:@"%f",now];
    orderInfo.startTimeType = [NSNumber numberWithInt:_isRightNow];
    
    [self sentOrder:orderInfo];
}

#pragma mark - TimePickerDelegate

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp isRightNow:(BOOL)isRightNow
{
    _isRightNow = isRightNow;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    _bottomToolBar.startTimeLabel.text = [date displayWithFormat:@"d号H点mm分"];
    [self showTimePicker:NO];
}

- (void)timePickerViewDidCancel
{
    [self showTimePicker:NO];
}

#pragma mark - AddressPickerViewControllerDelegate

- (void)addressPicker:(AddressPickerViewController *)pickerVC fromAddress:(AMapTip *)fromTip toAddress:(AMapTip *)toTip
{
    if (fromTip) {
        _bottomToolBar.fromAddressLabel.text = fromTip.name;
        MAPointAnnotation *fromAnnotation = [[MAPointAnnotation alloc] init];
        fromAnnotation.coordinate =  CLLocationCoordinate2DMake(fromTip.location.latitude, fromTip.location.longitude);
        _fromPoint = [AMapGeoPoint locationWithLatitude:fromTip.location.latitude longitude:fromTip.location.longitude];
        fromAnnotation.title = fromTip.name;
        
        [_annotations removeAllObjects];
        [_annotations addObject:fromAnnotation];
       
        [self clearMapView];
        
        [self.mapView addAnnotation:fromAnnotation];
        [self updateAnnotations:_annotations];
    }
    if (toTip){
        _toPoint = [AMapGeoPoint locationWithLatitude:toTip.location.latitude longitude:toTip.location.longitude];
        _bottomToolBar.toAddressLabel.text = toTip.name;
        _bottomToolBar.toAddressLabel.textColor = COLORRGB(0x63666b);
        [_bottomToolBar showChargeView:YES];
        [self getCouponInfo];
    }
}

- (void)updateAnnotations:(NSMutableArray *)Annotations
{
    [self.mapView showAnnotations:_annotations
                      edgePadding:UIEdgeInsetsMake(0, 0, 0, 0)
                         animated:YES];
}


#pragma mark - LoginVCDelegate
- (void)loginSucceed:(UserModel *)userInfo
{
    [MenuTableViewController sharedMenuTableViewController].userInfo = userInfo;
    [self.navigationController pushViewController:[MenuTableViewController sharedMenuTableViewController] animated:YES];
}

#pragma mark - -------------地图相关代码-------------

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"path_mark_start"];
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MAAnnotationView *view in views) {
        // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
        if ([view.annotation isKindOfClass:[MAUserLocation class]])
        {
            view.image = [UIImage imageNamed:@"path_mark_start"];
            self.userLocationAnnotationView = view;
        }
    }
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    NSLog(@"old :%ld - new :%ld", (long)oldState, (long)newState);
    
}

- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    NSLog(@"Location start");
}

- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    NSLog(@"Location stop");
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        _fromPoint = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 50;
        regeo.requireExtension = YES;
        [self.search AMapReGoecodeSearch:regeo];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    _toPoint = [AMapGeoPoint locationWithLatitude:request.location.latitude longitude:request.location.longitude];
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        _bottomToolBar.fromAddressLabel.text = response.regeocode.formattedAddress;
        _currentReGeocode = response.regeocode;
    }
}

#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

@end
