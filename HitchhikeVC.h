//
//  hitchhikeVC.h
//  DuDu
//
//  Created by i-chou on 2/2/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

//#import "BaseViewController.h"
#import "HitchhikeView.h"
#import "GeoAndSuggestionViewController.h"
#import "TimePicker.h"
#import "CountPicker.h"
#import <QMapKit/QMapKit.h>

@interface HitchhikeVC : BaseViewController
<
HitchhikeViewDelegate,
GeoAndSuggestionViewControllerDelegate,
TimePickerDelegate,
CountPickerDelegate,
QMSSearchDelegate
>

@property (nonatomic, strong) OrderStore *orderStore;
@property (nonatomic, copy)   NSString *currentCity;
@property (nonatomic, strong) CarModel *currentCar;
@property (nonatomic, strong) QUserLocation *fromLocation;
@property (nonatomic, strong) QUserLocation *toLocation;
@property (nonatomic, strong) QMSSearcher   *search;

@end
