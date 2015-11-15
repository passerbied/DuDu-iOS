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
    BOOL _isShowingBackBtn;
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

    self.delegate = self;
    self.view.backgroundColor = COLORRGB(0xffffff);
    
    self.searchBar = [[YBNavSearchBar alloc] initWithFrame:ccr(10, (NAV_BAR_HEIGHT-NAV_INPUTUBAR_HEIGHT)/2, NAV_INPUTUBAR_WIDTH, NAV_INPUTUBAR_HEIGHT)];
    self.searchBar.alpha = 0;
    self.searchBar.locationField.frame = ccr(5, 0, self.searchBar.width-5, 30);
    
    self.searchBar.locationField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:LocalStr(@"pholder_input_destination")
                                    attributes:@{NSForegroundColorAttributeName:COLORRGBA(0xFFFFFF, 0.3)}];
    
    [self.navigationBar addSubview:self.searchBar];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super navigationController:navigationController willShowViewController:viewController animated:animated];
    
    if ([viewController isKindOfClass:[viewController class]]){
                                                                   
    } else {
        
            [UIView animateWithDuration:0.3 animations:^{
                self.searchBar.frame = ccr(10, (NAV_BAR_HEIGHT-NAV_INPUTUBAR_HEIGHT)/2, NAV_INPUTUBAR_WIDTH, NAV_INPUTUBAR_HEIGHT);
                [self.searchBar layoutIfNeeded];
                self.searchBar.locationField.frame = ccr(5, 0, self.searchBar.width-5, 30);
            }];
    }
}

@end
