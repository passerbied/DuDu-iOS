//
//  InvoiceDetailVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@protocol InvoiceDetailVCDelegate;

@interface InvoiceDetailVC : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate>

@property (nonatomic, strong) BookModel *book;
@property (nonatomic, strong) id<InvoiceDetailVCDelegate> delegate;

@end

@protocol InvoiceDetailVCDelegate <NSObject>

- (void)dealBookSuccess;

@end
