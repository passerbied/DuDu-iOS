//
//  CountPicker.m
//  DuDu
//
//  Created by i-chou on 2/3/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "CountPicker.h"

@implementation CountPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        
        UIButton *cancelBtn = [UIButton buttonWithFrame:ccr(5, 0, 80, toolBar.height)
                                        backgroundColor:[UIColor clearColor]
                                      hlBackgroundColor:[UIColor clearColor]
                                                  title:@"取消"
                                                   font:HSFONT(16)
                                             titleColor:[UIColor blackColor]
                                             onTapBlock:^(UIButton *btn){
                                                 if ([self.delegate respondsToSelector:@selector(countPickerViewDidCancel)]) {
                                                     [self.delegate countPickerViewDidCancel];
                                                 }
                                             }];
        cancelBtn.showsTouchWhenHighlighted = YES;
        [toolBar addSubview:cancelBtn];
        
        UIButton *okBtn = [UIButton buttonWithFrame:ccr(toolBar.width-80-5, 0, 80, toolBar.height)
                                    backgroundColor:[UIColor clearColor]
                                  hlBackgroundColor:[UIColor clearColor]
                                              title:@"确定" font:HSFONT(16)
                                         titleColor:[UIColor blackColor]
                                         onTapBlock:^(UIButton *btn){
                                             if ([self.delegate respondsToSelector:@selector(countPicker:didSelectCount:)]) {
                                                 [self.delegate countPicker:self didSelectCount:(int)[self.pickerView selectedRowInComponent:0]+1];
                                             }
                                         }];
        okBtn.showsTouchWhenHighlighted = YES;
        [toolBar addSubview:okBtn];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:ccr(0, toolBar.height, SCREEN_WIDTH, frame.size.height-toolBar.height)];
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        [self addSubview:toolBar];
        [self addSubview:self.pickerView];
    }
    return self;
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH/3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        tView.backgroundColor = [UIColor clearColor];
        tView.font = HSFONT(16);
        tView.textAlignment = NSTextAlignmentCenter;
        tView.textColor = [UIColor blackColor];
    }
    if (row == 0) {
        tView.text = @"1人";
    } else if (row == 1) {
        tView.text = @"2人";
    } else if (row == 2){
        tView.text = @"3人";
    } else {
        tView.text = @"4人";
    }
    return tView;
}

@end
