//
//  CountPicker.h
//  DuDu
//
//  Created by i-chou on 2/3/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountPickerDelegate;

@interface CountPicker : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) id <CountPickerDelegate> delegate;
@property (assign) NSInteger pickedCount;

@end

@protocol CountPickerDelegate <NSObject>

- (void)countPickerViewDidCancel;

- (void)countPicker:(CountPicker *)pickerView didSelectCount:(int)count;

@end