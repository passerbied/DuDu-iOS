//
//  ZBCLodingFooter.h
//  ZBCool
//
//  Created by i-chou on 7/9/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZBCLodingFooterDelegate;

@interface ZBCLodingFooter : UILabel

@property (nonatomic) BOOL isLoadMore;

@property (nonatomic, strong) NSObject <ZBCLodingFooterDelegate> *delegate;

- (void)loading;
- (void)loadSuccessed:(BOOL)empty;
- (void)loadFiled;
- (void)loadedAll;

@end

@protocol ZBCLodingFooterDelegate <NSObject>
@optional
- (void)retryFetching:(BOOL)isLoadMore;

@end
