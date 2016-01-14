//
//  InvoiceCell.h
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvoiceCellDelegate;

@interface InvoiceCell : UITableViewCell

@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *startSite;
@property (nonatomic, copy)NSString *endSite;
@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, strong) id<InvoiceCellDelegate>delegate;

- (CGRect)calculateFrame;

@end

@protocol InvoiceCellDelegate <NSObject>

- (void)invoiceCell:(InvoiceCell *)cell didChecked:(BOOL)checked;

@end
