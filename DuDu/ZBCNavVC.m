//
//  ZBCNavVC.m
//  ZBCool
//
//  Created by Passerbied on 6/4/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCNavVC.h"

@interface ZBCNavVC ()

@end

@implementation ZBCNavVC
{
    BOOL _popCompleted;
}

@dynamic screenEdgePanGestureRecognizer;

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    
    return screenEdgePanGestureRecognizer;
}

- (id)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:nil];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate =self;
    self.interactivePopGestureRecognizer.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:HSFONT(16),NSFontAttributeName, COLORRGB(0xff8830),NSForegroundColorAttributeName,nil];
    self.navigationBar.titleTextAttributes = dict;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int index = (int)[navigationController.viewControllers indexOfObject:viewController];
    
    if (index != 0) {
        
        UIButton* btLeft = [UIButton buttonWithImageName:self.backBtnImageName?self.backBtnImageName:@"nav_btn_back_88_88"
                                             hlImageName:self.backBtnHlImageName?self.backBtnHlImageName:@"nav_btn_back_hl_88_88"
                                              onTapBlock:^(UIButton *btn) {
                                                  [self popViewControllerAnimated:YES];
                                              }];
        UIBarButtonItem *barBtLeft = [[UIBarButtonItem alloc] initWithCustomView:btLeft];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil
                                           action:nil];
        negativeSpacer.title = @"";
        negativeSpacer.width = -22;
        viewController.navigationItem.leftBarButtonItems =
        [NSArray arrayWithObjects:negativeSpacer, barBtLeft, nil];
    }
    
    self.popCompleted = NO;
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    self.popCompleted = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.popCompleted;
}

@end
