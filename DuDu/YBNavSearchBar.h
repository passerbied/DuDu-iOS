//
//  YBNavSearchBar.h
//  Yuebanr
//
//  Created by Passerbied on 1/6/14.
//  Copyright (c) 2014 metasolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTextField.h"

@protocol YBNavSearchBarDelegate;

@interface YBNavSearchBar : UIView <UITextFieldDelegate>

+ (YBNavSearchBar *)sharedYBNavSearchBar;

@property (nonatomic, strong) UITextField *locationField;
@property (nonatomic, assign) id<YBNavSearchBarDelegate> delegate;

@end

@protocol YBNavSearchBarDelegate <NSObject>

- (void)doClear;

@end
