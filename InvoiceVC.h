//
//  InvoiceVC.h
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCLodingFooter.h"
#import "BookModel.h"
#import "InvoiceCell.h"
#import "InvoiceDetailVC.h"

@interface InvoiceVC : BaseViewController
<UITableViewDataSource,
UITableViewDelegate,
ZBCLodingFooterDelegate,
InvoiceCellDelegate,
InvoiceDetailVCDelegate>



@end
