//
//  TopToolBar.m
//  DuDu
//
//  Created by i-chou on 11/7/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "TopToolBar.h"

@implementation TopToolBar
{
    UIButton *_btn_all;
    UIButton *_btn_commen;
    UIButton *_btn_expert;
}

- (id)initWithFrame:(CGRect)frame carStyles:(NSArray *)styles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLORRGBA(0xffffff, 0.8);
        for (int i = 0; i < styles.count; i++) {
            CarModel *carModel = styles[i];
            UIButton *btn = [UIButton buttonWithImageName:nil
                                              hlImageName:nil
                                                    title:carModel.car_style_name
                                               titleColor:COLORRGB(0x63666b)
                                                     font:HSFONT(14)
                                               onTapBlock:^(UIButton *btn) {
                                                   for (UIView *button in self.subviews) {
                                                       if ([button isKindOfClass:[UIButton class]]) {
                                                           [(UIButton *)button setTitleColor:COLORRGB(0x63666b) forState:UIControlStateNormal];
                                                           button.layer.borderColor = [UIColor clearColor].CGColor;
                                                       }
                                                   }
                                                   btn.layer.borderColor = COLORRGB(0xf39a00).CGColor;
                                                   [btn setTitleColor:COLORRGB(0xf39a00) forState:UIControlStateNormal];
                                                   if ([self.delegate respondsToSelector:@selector(topToolBar:didCarButonTapped:)]) {
                                                       [self.delegate topToolBar:self didCarButonTapped:i];
                                                   }
                                               }];
            float width = SCREEN_WIDTH/styles.count;
//            float btnWidth = 80;
            btn.tag = [carModel.car_style_id intValue];
            btn.frame = ccr(i*width+(width-80)/2, (self.height-30)/2, 80, 30);
            btn.layer.borderWidth = 0.5f;
            btn.layer.cornerRadius = 15;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            [self addSubview:btn];
            if (i == 0) {
                [btn setTitleColor:COLORRGB(0xf39a00) forState:UIControlStateNormal];
                btn.layer.borderColor = COLORRGB(0xf39a00).CGColor;
            } else {
                UIImageView *line = [[UIImageView alloc] initWithFrame:ccr(i*width, (self.height-20)/2, 0.5, 20)];
                line.backgroundColor = COLORRGB(0x63666b);
                [self addSubview:line];
            }
        }
    }
    return self;
}

- (void)updateCarStylesWith:(NSArray *)styles
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < styles.count; i++) {
        CarModel *carModel = styles[i];
        UIButton *btn = [UIButton buttonWithImageName:nil
                                          hlImageName:nil
                                                title:carModel.car_style_name
                                           titleColor:COLORRGB(0x63666b)
                                                 font:HSFONT(14)
                                           onTapBlock:^(UIButton *btn) {
                                               for (UIView *button in self.subviews) {
                                                   if ([button isKindOfClass:[UIButton class]]) {
                                                       [(UIButton *)button setTitleColor:COLORRGB(0x63666b) forState:UIControlStateNormal];
                                                       button.layer.borderColor = [UIColor clearColor].CGColor;
                                                   }
                                               }
                                               btn.layer.borderColor = COLORRGB(0xf39a00).CGColor;
                                               [btn setTitleColor:COLORRGB(0xf39a00) forState:UIControlStateNormal];
                                               if ([self.delegate respondsToSelector:@selector(topToolBar:didCarButonTapped:)]) {
                                                   [self.delegate topToolBar:self didCarButonTapped:i];
                                               }
                                           }];
        float width = SCREEN_WIDTH/styles.count;
        btn.tag = [carModel.car_style_id intValue];
//        btn.frame = ccr(i*width, 0, width, self.height);
        btn.frame = ccr(i*width+(width-80)/2, (self.height-30)/2, 80, 30);
        btn.layer.borderWidth = 0.5f;
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:COLORRGB(0xf39a00) forState:UIControlStateNormal];
            btn.layer.borderColor = COLORRGB(0xf39a00).CGColor;
        } else {
            UIImageView *line = [[UIImageView alloc] initWithFrame:ccr(i*width, (self.height-20)/2, 0.5, 20)];
            line.backgroundColor = COLORRGB(0x63666b);
            [self addSubview:line];
        }
    }
}

@end
