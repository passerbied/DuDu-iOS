//
//  AddressPickerViewController.h
//  DuDu
//
//  Created by i-chou on 11/9/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomToolBar.h"
#import <AMapSearchKit/AMapSearchKit.h>

@protocol AddressPickerViewControllerDelegate;

@interface AddressPickerViewController : UIViewController <AMapSearchDelegate>

@property(nonatomic, strong) AMapTip *tip;
@property (nonatomic, strong) id<AddressPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) BOOL isFrom;
@property (nonatomic, assign) BOOL isFromAddressVC;

- (id)initWithLocation:(NSString *)location;

@end

@protocol AddressPickerViewControllerDelegate <NSObject>

- (void)addressPicker:(AddressPickerViewController *)pickerVC fromAddress:(AMapTip *)fromTip toAddress:(AMapTip *)toTip;

@end
