//
//  InvoiceDetailVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "InvoiceDetailVC.h"
#import "InvoiceDetailCell.h"

@interface InvoiceDetailVC ()
{
    UITableView *_tableView;
    CGFloat     _titleWidth;
}

@end

@implementation InvoiceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
    [self createSubViews];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7,
                                                        SCREEN_WIDTH,
                                                        50*8+20*2)];
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    } else if (section==1) {
        return 5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"detailCell";
    InvoiceDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!detailCell) {
        detailCell = [[InvoiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                detailCell.message = @"开票金额";
                [detailCell addSubview:[self priceLabel]];
                break;
            case 1:
                detailCell.message = @"开票抬头";
                [detailCell addSubview:[self headTextField]];
                break;
            case 2:
                detailCell.message = @"开票内容";
                [detailCell addSubview:[self typeLabel]];
                break;
            default:
                break;
        }
    } else if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
                detailCell.message = @"收件人";
                [detailCell addSubview:[self addresseeTextField]];
                break;
            case 1:
                detailCell.message = @"收件电话";
                [detailCell addSubview:[self phoneTextField]];
                break;
            case 2:
                detailCell.message = @"所在地区";
                break;
            case 3:
                detailCell.message = @"详细地址";
                [detailCell addSubview:[self addressTextField]];
                break;
            case 4:
                detailCell.message = @"电子邮件";
                [detailCell addSubview:[self emailTextField]];
                break;
            default:
                break;
        }
    }
    return detailCell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)createSubViews
{
    UIButton *submitButton = [UIButton buttonWithImageName:@""
                                               hlImageName:@""
                                                     title:@"提交"
                                                titleColor:COLORRGB(0xffffff)
                                                      font:HSFONT(15)
                                                onTapBlock:^(UIButton *btn) {
                                                    
                                                }];
    submitButton.backgroundColor = COLORRGB(0xedad49);
    submitButton.frame = ccr(10,
                             CGRectGetMaxY(_tableView.frame)+20,
                             SCREEN_WIDTH-10*2,
                             50);
    [self.view addSubview:submitButton];
    
    UILabel *ruleLabel = [UILabel labelWithFrame:CGRectZero
                                           color:COLORRGB(0x000000)
                                            font:HSFONT(12)
                                            text:@"行程信息提交后不可更改,请仔细填写!"
                                       alignment:NSTextAlignmentCenter
                                   numberOfLines:1];
    CGSize ruleSize = [ruleLabel.text sizeWithAttributes:@{NSFontAttributeName:ruleLabel.font}];
    [ruleLabel sizeToFit];
    ruleLabel.frame = ccr((SCREEN_WIDTH-ruleSize.width)/2,
                          CGRectGetMaxY(submitButton.frame)+10,
                          ruleSize.width,
                          ruleSize.height);
    [self.view addSubview:ruleLabel];
}

- (UILabel *)priceLabel
{
    NSString *number = @"50.50";
    NSString *price = [NSString stringWithFormat:@"%@元",number];
    UILabel *priceLabel = [UILabel labelWithFrame:CGRectZero
                                            color:COLORRGB(0x000000)
                                             font:HSFONT(12)
                                             text:price
                                        alignment:NSTextAlignmentLeft
                                    numberOfLines:1];
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
    NSUInteger priceLength = price.length-1;
    [priceString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                         range:NSMakeRange(0, priceLength)];
    priceLabel.attributedText = priceString;
    NSString *title = @"开票金额";
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:priceLabel.font}];
    _titleWidth = titleSize.width;
    CGSize priceSize = [priceLabel.text sizeWithAttributes:@{NSFontAttributeName:priceLabel.font}];
    [priceLabel sizeToFit];
    priceLabel.frame = ccr(10+titleSize.width+10,
                           (50-priceSize.height)/2,
                           priceSize.width,
                           priceSize.height);
    return priceLabel;
}

- (UILabel *)typeLabel
{
    UILabel *typeLabel = [UILabel labelWithFrame:CGRectZero
                                           color:COLORRGB(0x000000)
                                            font:HSFONT(12)
                                            text:@"约车服务费"
                                       alignment:NSTextAlignmentLeft
                                   numberOfLines:1];
    CGSize typeSize = [typeLabel.text sizeWithAttributes:@{NSFontAttributeName:typeLabel.font}];
    [typeLabel sizeToFit];
    typeLabel.frame = ccr(_titleWidth+10*2,
                          (50-typeSize.height)/2,
                          typeSize.width,
                          typeSize.height);
    return typeLabel;
}

- (UITextField *)headTextField
{
    UITextField *headTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                        0,
                                                                        SCREEN_WIDTH-_titleWidth-10*3,
                                                                        50)];
    headTextField.font = HSFONT(12);
    headTextField.textColor = COLORRGB(0x000000);
    headTextField.textAlignment = NSTextAlignmentLeft;
    headTextField.delegate = self;
    return headTextField;
}

- (UITextField *)addresseeTextField
{
    UITextField *addresseeTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                             0,
                                                                             SCREEN_WIDTH-_titleWidth-10*3,
                                                                             50)];
    addresseeTextField.font = HSFONT(12);
    addresseeTextField.textColor = COLORRGB(0x000000);
    addresseeTextField.textAlignment = NSTextAlignmentLeft;
    addresseeTextField.delegate = self;
    return addresseeTextField;
}

- (UITextField *)phoneTextField
{
    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                         0,
                                                                         SCREEN_WIDTH-_titleWidth-10*3,
                                                                         50)];
    phoneTextField.font = HSFONT(12);
    phoneTextField.textColor = COLORRGB(0x000000);
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.delegate = self;
    return phoneTextField;
}

- (UITextField *)addressTextField
{
    UITextField *addressTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                           0,
                                                                           SCREEN_WIDTH-_titleWidth-10*3,
                                                                           50)];
    addressTextField.font = HSFONT(12);
    addressTextField.textColor = COLORRGB(0x000000);
    addressTextField.textAlignment = NSTextAlignmentLeft;
    addressTextField.placeholder = @"填写详细地址";
    addressTextField.delegate = self;
    return addressTextField;
}

- (UITextField *)emailTextField
{
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                         0,
                                                                         SCREEN_WIDTH-_titleWidth-10*3,
                                                                         50)];
    emailTextField.font = HSFONT(12);
    emailTextField.textColor = COLORRGB(0x000000);
    emailTextField.textAlignment = NSTextAlignmentLeft;
    emailTextField.placeholder = @"用于向您发送电子行程单";
    emailTextField.delegate = self;
    return emailTextField;
}

#pragma textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
