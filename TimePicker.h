//
//  TimePicker.h
//  DuDu
//
//  Created by i-chou on 11/15/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerDelegate;

@interface TimePicker : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) id <TimePickerDelegate> delegate;
@property (assign) NSInteger pickedTime;

@end

@protocol TimePickerDelegate <NSObject>

- (void)timePickerViewDidCancel;

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp isRightNow:(BOOL) isRightNow;

@end
