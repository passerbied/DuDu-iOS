//
//  WebVC.h
//  DuDu
//
//  Created by i-chou on 1/15/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : BaseViewController<UIWebViewDelegate>

@property (nonatomic, copy) NSString *resourcePath;

@end
