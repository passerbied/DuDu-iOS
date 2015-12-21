//
//  ZBCProgressHUD.m
//  ZBCool
//
//  Created by i-chou on 6/11/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCProgressHUD.h"



@implementation ZBCProgressHUD
{
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLORRGBA(0xcccccc, 0.1);
        self.delegate = self;
        self.wasHidden = NO;
        self.detailsLabelFont = HSFONT(13);
        self.labelFont = HSFONT(15);
//        self.mode = MBProgressHUDModeCustomView;
    }
    return self;
}

+ (ZBCProgressHUD *)sharedZBCProgressHUD
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedZBCProgressHUD = nil;
    dispatch_once(&pred, ^{
        _sharedZBCProgressHUD = [[self alloc] initWithFrame:KEY_WINDOW.frame];
    });
    return _sharedZBCProgressHUD;
}

+ (instancetype)showNotificationHUDWithlabelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText animated:(BOOL)animated desView:(UIView *)view
{
    [self hideHUDForWindow:KEY_WINDOW animated:NO];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMG(@"")];
    [KEY_WINDOW addSubview:[self sharedZBCProgressHUD]];
    [[self sharedZBCProgressHUD] show:animated];
    [self sharedZBCProgressHUD].customView = imageView;
    [self sharedZBCProgressHUD].labelText = labelText;
    [self sharedZBCProgressHUD].mode = MBProgressHUDModeCustomView;
    [self sharedZBCProgressHUD].detailsLabelText = detailsLabelText;
    [self sharedZBCProgressHUD].dimBackground = NO;
    [self sharedZBCProgressHUD].opacity = 0.5;
    [[self sharedZBCProgressHUD] hide:YES afterDelay:1.5];
//    [self sharedZBCProgressHUD] .color = COLORRGBA(0x00bbf8,0.5);
    return [self sharedZBCProgressHUD];
}

+ (instancetype)showCompleteHUD:(BOOL)isSuccessed labelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText animated:(BOOL)animated desView:(UIView *)view
{
    [self hideHUDForWindow:KEY_WINDOW animated:NO];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:isSuccessed?IMG(@"find_keep_icon_success"):IMG(@"find_keep_icon_fail")];
    [KEY_WINDOW addSubview:[self sharedZBCProgressHUD]];
    [[self sharedZBCProgressHUD] show:animated];
    [self sharedZBCProgressHUD].mode = MBProgressHUDModeCustomView;
    [self sharedZBCProgressHUD].customView = imageView;
    [self sharedZBCProgressHUD].labelText = labelText;
    [self sharedZBCProgressHUD].detailsLabelText = detailsLabelText;
    [self sharedZBCProgressHUD].dimBackground = NO;
    [self sharedZBCProgressHUD].opacity = 0.5;
    [[self sharedZBCProgressHUD] hide:YES afterDelay:1.5];
//    [self sharedZBCProgressHUD] .color = COLORRGBA(0x00bbf8,0.5);


    return [self sharedZBCProgressHUD];
}

+ (instancetype)showHUDAddedToWindow:(UIView *)window hudText:(NSString *)hudText animated:(BOOL)animated
{
    [self hideHUDForWindow:KEY_WINDOW animated:NO];
    [KEY_WINDOW addSubview:[self sharedZBCProgressHUD]];
    [[self sharedZBCProgressHUD] show:animated];
    [self sharedZBCProgressHUD].labelText = hudText;
    [self sharedZBCProgressHUD].mode = MBProgressHUDAnimationFade;
    [self sharedZBCProgressHUD].detailsLabelText = @"";
    [self sharedZBCProgressHUD].dimBackground = NO;
    [self sharedZBCProgressHUD].opacity = 1;

    return [self sharedZBCProgressHUD];
}

+ (BOOL)hideHUDForWindow:(UIWindow *)window animated:(BOOL)animated {
    
    [self sharedZBCProgressHUD].removeFromSuperViewOnHide = YES;
    [[self sharedZBCProgressHUD] hide:animated];

    return YES;
}

+ (instancetype)HUDForWindow:(UIWindow *)window {
    NSEnumerator *subviewsEnum = [window.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (ZBCProgressHUD *)subview;
        }
    }
    return nil;
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (id)initWithWindow:(UIWindow *)window {
    return [self initWithFrame:window.bounds];
}

- (void)hudWasHidden:(ZBCProgressHUD *)hud
{
    self.wasHidden = YES;
}

+ (void)setDescription:(NSString *)text
{
    [self sharedZBCProgressHUD].detailsLabelText = text;
}

+ (instancetype)showNotificationHUDWithlabelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText animated:(BOOL)animated{
    return nil;
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
