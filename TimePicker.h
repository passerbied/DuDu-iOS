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

- (void)timePickerView:(TimePicker *)pickerView didSelectButton:(UIButton *)btn;

- (void)timePickerViewDidCancel;

//- (NSInteger)numberOfComponentsInTimePickerView:(TimePicker *)pickerView;
//
//- (NSInteger)timePickerView:(TimePicker *)pickerView numberOfRowsInComponent:(NSInteger)component;
//
//- (CGFloat)timePickerView:(TimePicker *)pickerView rowHeightForComponent:(NSInteger)component;
//
//- (CGFloat)timePickerView:(TimePicker *)pickerView widthForComponent:(NSInteger)component;
//
//- (UIView *)timePickerView:(TimePicker *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
//
//- (void)timePickerView:(TimePicker *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (void)timePickerView:(TimePicker *)pickerView didSelectTime:(NSInteger)timeStamp isRightNow:(BOOL) isRightNow;

@end
