//
//  RecommendVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RecommendVC.h"

@interface RecommendVC ()

@end

@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
}

- (void)createSubViews
{
    UILabel *label = [UILabel labelWithFrame:ccr(0, NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, 200)
                                       color:COLORRGB(0x000000)
                                        font:HSFONT(20)
                                        text:@"专车券:￥30"
                                   alignment:NSTextAlignmentCenter
                               numberOfLines:1];
    label.backgroundColor = COLORRGB(0xf0f0f0);
    [self.view addSubview:label];
    
    UIButton *shareButton = [UIButton buttonWithImageName:@""
                                              hlImageName:@""
                                                    title:@"分享至社交媒体"
                                               titleColor:COLORRGB(0xedad49)
                                                     font:HSFONT(15)
                                               onTapBlock:^(UIButton *btn) {
                                                   
                                               }];
    shareButton.frame = ccr((SCREEN_WIDTH-150)/2, SCREEN_HEIGHT-100-50, 150, 50);
    shareButton.backgroundColor = COLORRGB(0xf0f0f0);
    [self.view addSubview:shareButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
