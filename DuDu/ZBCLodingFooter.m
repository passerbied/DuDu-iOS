//
//  ZBCLodingFooter.m
//  ZBCool
//
//  Created by i-chou on 7/9/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCLodingFooter.h"

@implementation ZBCLodingFooter
{
    UIButton *_retryBtn;
    UIActivityIndicatorView *_activity;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = HSFONT(13);
        self.textColor = COLORRGB(0x929292);
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.text = @"正在加载...";
        
        _activity=
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.origin = ccp(80, (self.height-_activity.height)/2);
        _activity.color = COLORRGB(0xedad49);
        [_activity startAnimating];
        [self addSubview:_activity];

        _retryBtn = [UIButton buttonWithFrame:self.bounds
                                  backgroundColor:[UIColor clearColor]
                                hlBackgroundColor:COLORRGBA(0xdedede,0.5)
                                            title:@""
                                             font:nil
                                       titleColor:nil
                                       onTapBlock:^(UIButton *btn) {
                                           [_activity startAnimating];
                                           _activity.alpha = 1;
                                           self.text = @"正在加载...";
                                           _retryBtn.alpha = 0;
                                           if ([self.delegate respondsToSelector:@selector(retryFetching:)]) {
                                               [self.delegate retryFetching:self.isLoadMore];
                                           }
                                       }];
        [self addSubview:_retryBtn];

    }
    return self;
}

- (void)loading
{
    _activity.alpha = 1;
    [_activity startAnimating];
    self.text = @"正在加载...";
    _retryBtn.alpha = 0;
}

- (void)loadSuccessed:(BOOL)empty
{
    [_activity stopAnimating];
    _activity.alpha = 0;
    self.text = @"";
    _retryBtn.alpha = 0;
}

- (void)loadFiled
{
    [_activity stopAnimating];
    _activity.alpha = 0;
    self.text = @"加载失败";
    _retryBtn.alpha = 1;
}

- (void)loadedAll
{
    [_activity stopAnimating];
    _activity.alpha = 0;
    self.text = @"";
    _retryBtn.alpha = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
