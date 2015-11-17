//
//  YBNavigationContoller.m
//  Yuebanr
//
//  Created by Aiyoo on 13-1-18.
//  Copyright (c) 2013年 metasolo. All rights reserved.
//

#import "YBNavigationContoller.h"

#define NAV_INPUTUBAR_HEIGHT 30
#define NAV_INPUTUBAR_WIDTH SCREEN_WIDTH - 20

@interface YBNavigationContoller ()

@end

@implementation YBNavigationContoller
{
    UIButton *_cityBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = COLORRGB(0xffffff);
    
    _cityBtn = [UIButton buttonWithImageName:nil
                                 hlImageName:nil
                                       title:@"北京"
                                  titleColor:COLORRGB(0x63666b)
                                        font:HSFONT(15)
                                  onTapBlock:^(UIButton *btn) {
                                      
        
    }];
    [self.navigationBar addSubview:_cityBtn];
    
    self.searchBar = [[YBNavSearchBar alloc] initWithFrame:ccr(10, (NAV_BAR_HEIGHT-NAV_INPUTUBAR_HEIGHT)/2, NAV_INPUTUBAR_WIDTH, NAV_INPUTUBAR_HEIGHT)];
    self.searchBar.alpha = 0;
    self.searchBar.locationField.frame = ccr(5, 0, self.searchBar.width-5, 30);
    
    self.searchBar.locationField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"请输入地点"
                                    attributes:@{NSForegroundColorAttributeName:COLORRGBA(0xFFFFFF, 0.3)}];
    [self.navigationBar addSubview:self.searchBar];
}

- (void)showSearchBar:(BOOL)show
{
    self.searchBar.alpha = show;
}


@end
