//
//  ZBCNavVC.h
//  ZBCool
//
//  Created by Passerbied on 6/4/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBCNavVC : UINavigationController <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL popCompleted;
@property (nonatomic, copy) NSString *backBtnImageName;
@property (nonatomic, copy) NSString *backBtnHlImageName;

@property (nonatomic, readonly) UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer;

@end
