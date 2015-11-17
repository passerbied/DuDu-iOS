//
//  YBNavigationContoller.h
//  Yuebanr
//
//  Created by Aiyoo on 13-1-18.
//  Copyright (c) 2013年 metasolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBNavSearchBar.h"
#import "ZBCNavVC.h"

@protocol YBNavigationContollerDelegate;

@interface YBNavigationContoller : UINavigationController

@property (nonatomic, strong) YBNavSearchBar *searchBar;
@property (nonatomic, strong) id<YBNavigationContollerDelegate> delegate;

@end

@protocol YBNavigationContollerDelegate <NSObject>

- (void)searchBarDidTappedInViewController:(UIViewController *)vc;
- (void)cityBtnDidTappedInViewController:(UIViewController *)vc;

@end