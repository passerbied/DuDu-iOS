//
//  GeoAndSuggestionViewController.h
//  QMapSearchDemo
//
//  Created by xfang on 14/11/17.
//  Copyright (c) 2014年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapSearchKit/QMapSearchKit.h>

@protocol GeoAndSuggestionViewControllerDelegate;

@interface GeoAndSuggestionViewController : BaseViewController

@property (nonatomic, strong) QMSSuggestionPoiData *poi;
@property (nonatomic, strong) id<GeoAndSuggestionViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, strong) NSMutableArray *historyOrders;
@property (nonatomic, assign) BOOL isFrom;

@end

@protocol GeoAndSuggestionViewControllerDelegate <NSObject>

- (void)addressPicker:(GeoAndSuggestionViewController *)vc fromAddress:(QMSSuggestionPoiData *)fromPoi toAddress:(QMSSuggestionPoiData *)toPoi;
//- (void)addressPicker:(GeoAndSuggestionViewController *)vc didSelectedAddress:(QMSSuggestionPoiData *)poi;

@end