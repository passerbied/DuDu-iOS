//
//  InvoiceCell.h
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceCell : UITableViewCell

@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, assign)float  price;
@property (nonatomic, copy)NSString *startSite;
@property (nonatomic, copy)NSString *endSite;
@property (nonatomic, strong)UIImageView *selectImage;

- (CGRect)calculateFrame;

@end
