//
//  MyWalletVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "MyWalletVC.h"
#import "WalletCell.h"
#import "InvoiceVC.h"

@interface MyWalletVC ()
{
    UITableView *_tableView;
}

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7+50,
                                                        SCREEN_WIDTH,
                                                        180)];
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"walletCell";
    WalletCell *walletCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!walletCell) {
        walletCell = [[WalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        walletCell.iconImage.image = IMG(@"tiny_bill");
        walletCell.title = @"发票";
    } else if (indexPath.row == 1) {
        walletCell.iconImage.image = IMG(@"tiny_coupon");
        walletCell.title = @"打车券";
        [walletCell addSubview:[self numberLabel]];
    } else {
        walletCell.iconImage.image = IMG(@"tiny_shared");
        walletCell.title = @"余额";
        [walletCell addSubview:[self priceLabel]];
    }
    return walletCell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        InvoiceVC *invoiceVC = [[InvoiceVC alloc] init];
        invoiceVC.title = @"按行程开票";
        [self.navigationController pushViewController:invoiceVC animated:YES];
    } else if (indexPath.row==1) {
        
    } else {
        
    }
}

- (UILabel *)numberLabel
{
    NSString *number = @"5张";
    UILabel *numberLabel = [UILabel labelWithFrame:CGRectZero
                                             color:COLORRGB(0xd7d7d7)
                                              font:HSFONT(12)
                                              text:number
                                         alignment:NSTextAlignmentRight
                                     numberOfLines:1];
    NSMutableAttributedString *numberString = [[NSMutableAttributedString alloc] initWithString:number];
    NSUInteger numberLength = number.length-1;
    [numberString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                          range:NSMakeRange(0, numberLength)];
    numberLabel.attributedText = numberString;
    CGSize numberSize = [numberLabel.text sizeWithAttributes:@{NSFontAttributeName:numberLabel.font}];
    [numberLabel sizeToFit];
    numberLabel.frame = ccr(SCREEN_WIDTH-5-30-5-numberSize.width,
                            (60-numberSize.height)/2,
                            numberSize.width,
                            numberSize.height);
    return numberLabel;
}

- (UILabel *)priceLabel
{
    NSString *price = @"0.00元";
    UILabel *priceLabel = [UILabel labelWithFrame:CGRectZero
                                            color:COLORRGB(0xd7d7d7)
                                             font:HSFONT(12)
                                             text:price
                                        alignment:NSTextAlignmentRight
                                    numberOfLines:1];
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
    NSUInteger priceLength = price.length-1;
    [priceString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                         range:NSMakeRange(0, priceLength)];
    priceLabel.attributedText = priceString;
    CGSize priceSize = [priceLabel.text sizeWithAttributes:@{NSFontAttributeName:priceLabel.font}];
    [priceLabel sizeToFit];
    priceLabel.frame = ccr(SCREEN_WIDTH-5-30-5-priceSize.width,
                           (60-priceSize.height)/2,
                           priceSize.width,
                           priceSize.height);
    return priceLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
