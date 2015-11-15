//
//  MainViewController.h
//  DuDu
//
//  Created by i-chou on 11/4/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopToolBar.h"
#import "BottomToolBar.h"
#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LocationPickerViewController.h"
#import "TimePicker.h"

@interface MainViewController : UIViewController <TopToolBarDelegate, BottomToolBarDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate, TimePickerDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKRouteSearch *routesearch;

@end
