//
//  MainViewController.m
//  DuDu
//
//  Created by i-chou on 11/4/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MainViewController.h"

#define PADDING 10
#define bottomToolBar_Height  88

@interface MainViewController ()

@end

@implementation MainViewController
{
    TopToolBar *_TopToolBar;
    BottomToolBar *_bottomToolBar;
    int _current_type; //存储当前用车类型
    TimePicker *_timePicker;
    UIActivityIndicatorView *_activityView;
    AMapReGeocode *_currentReGeocode;
    NSMutableArray *_annotations;
    BOOL _isFirstAppear;
    UIButton *_locationBtn;

}

- (id)init
{
    self = [super init];
    if (self) {
        _annotations = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirstAppear = YES;
    
    [self setupLeftMenuButton];
    
    [AMapSearchServices sharedServices].apiKey = MAP_KEY;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.mapView = [[MAMapView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    
    _TopToolBar = [[TopToolBar alloc] initWithFrame:ccr(0, NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, 50) carNames:@[@"不限",@"普通车",@"豪华车"]]; //TODO:可能为接口返回数据
    _TopToolBar.delegate = self;
    [self.view addSubview:_TopToolBar];
    
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
    _locationBtn.frame = ccr(PADDING, CGRectGetMaxY(_TopToolBar.frame)+PADDING, 30, 30);
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

- (void)startLocation
{
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.mapView setZoomLevel:16.1 animated:YES];
}

#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

-(void)setupLeftMenuButton
{
    UIButton *leftBtn = [UIButton buttonWithImageName:@"account"
                                          hlImageName:@"account_pressed"
                                           onTapBlock:^(UIButton *btn) {
                                               MenuTableViewController *menuVC = [[MenuTableViewController alloc] init];
                                               menuVC.title = @"设置";
                                               [self.navigationController pushViewController:menuVC animated:YES];
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
    _current_type = index;
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
        
    } else {
        
    }
}

#pragma mark - TimePickerDelegate

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    _bottomToolBar.startTimeLabel.text = [date displayWithFormat:@"d号H点mm分"];
    [self showTimePicker:NO];
}

- (void)timePickerViewDidCancel
{
    [self showTimePicker:NO];
}

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
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 1000;
        regeo.requireExtension = YES;
        [self.search AMapReGoecodeSearch:regeo];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        _bottomToolBar.fromAddressLabel.text = response.regeocode.formattedAddress;
        _currentReGeocode = response.regeocode;
    }
}

#pragma mark - AddressPickerViewControllerDelegate

- (void)addressPicker:(AddressPickerViewController *)pickerVC fromAddress:(AMapTip *)fromTip toAddress:(AMapTip *)toTip
{
    if (fromTip) {
        _bottomToolBar.fromAddressLabel.text = fromTip.name;
        MAPointAnnotation *fromAnnotation = [[MAPointAnnotation alloc] init];
        fromAnnotation.coordinate =  CLLocationCoordinate2DMake(fromTip.location.latitude, fromTip.location.longitude);
        fromAnnotation.title = fromTip.name;
        
        [_annotations removeAllObjects];
        [_annotations addObject:fromAnnotation];
       
        [self clearMapView];
        
        [self.mapView addAnnotation:fromAnnotation];
        [self updateAnnotations:_annotations];
    }
    if (toTip){
        _bottomToolBar.toAddressLabel.text = toTip.name;
        _bottomToolBar.toAddressLabel.textColor = COLORRGB(0x63666b);
    }
}

- (void)updateAnnotations:(NSMutableArray *)Annotations
{
    [self.mapView showAnnotations:_annotations
                      edgePadding:UIEdgeInsetsMake(0, 0, 0, 0)
                         animated:YES];
}


@end
