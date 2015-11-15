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

@interface YBNavigationContoller : ZBCNavVC <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) YBNavSearchBar *searchBar;

@end
