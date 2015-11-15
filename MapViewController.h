//
//  MapViewController.h
//  DuDu
//
//  Created by i-chou on 11/6/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface MapViewController : UIViewController <BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;

@end
