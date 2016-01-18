//
//  ZBCToast.m
//  ZBCool
//
//  Created by i-chou on 7/17/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCToast.h"

@implementation ZBCToast

+ (void)showMessage:(NSString *)message
{
    NSMutableDictionary *options = [@{
                                      kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                                      kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypePush),
                                      kCRToastUnderStatusBarKey : @(YES),
                                      kCRToastTimeIntervalKey : @(0.8f),
                                      kCRToastTextKey : message,
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : COLORRGB(0xf39a00),
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                      kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                                      } mutableCopy];
    
    options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder
                                                   interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                   automaticallyDismiss:YES
                                                   block:^(CRToastInteractionType interactionType){
                                                       
                                                   }]];
    [CRToastManager dismissNotification:NO];
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                }];
}

@end
