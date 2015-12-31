//
//  TopToolBar.h
//  DuDu
//
//  Created by i-chou on 11/7/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopToolBarDelegate;

@interface TopToolBar : UIView

@property (nonatomic, strong) id <TopToolBarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame carStyles:(NSArray *)styles;

- (void)updateCarStylesWith:(NSArray *)styles;

@end


@protocol TopToolBarDelegate <NSObject>

- (void)topToolBar:(TopToolBar *)topToolBar didCarButonTapped:(int)index;

@end
