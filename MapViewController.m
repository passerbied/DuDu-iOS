//
//  MapViewController.m
//  DuDu
//
//  Created by i-chou on 11/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locService = [[BMKLocationService alloc] init];
    [self startLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
}

- (void)startLocation
{
    NSLog(@"进入普通定位态");
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO; //先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeNone; //设置定位的状态
    self.mapView.showsUserLocation = YES; //显示定位图层
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self.mapView updateLocationData:userLocation];
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

@end
