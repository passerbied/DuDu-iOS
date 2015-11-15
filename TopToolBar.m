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

- (id)initWithFrame:(CGRect)frame carNames:(NSArray *)names
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLORRGBA(0xffffff, 0.8);
        for (int i = 0; i < names.count; i++) {
        UIButton *btn = [UIButton buttonWithImageName:nil
                                              hlImageName:nil
                                                    title:names[i]
                                               titleColor:COLORRGB(0x63666b)
                                                     font:HSFONT(14)
                                               onTapBlock:^(UIButton *btn) {
                                                   for (UIButton *button in self.subviews) {
                                                       [button setTitleColor:COLORRGB(0x63666b) forState:UIControlStateNormal];
                                                   }
                                                   [btn setTitleColor:COLORRGB(0x000000) forState:UIControlStateNormal];
                                                   if ([self.delegate respondsToSelector:@selector(topToolBar:didCarButonTapped:)]) {
                    [self.delegate topToolBar:self didCarButonTapped:i];
                }
            }];
            float width = SCREEN_WIDTH/names.count;
            btn.tag = i;
            btn.frame = ccr(i*width, 0, width, self.height);
            [self addSubview:btn];
            if (i == 0) {
                [btn setTitleColor:COLORRGB(0x000000) forState:UIControlStateNormal];
            }
        }
    }
    return self;
}

@end
