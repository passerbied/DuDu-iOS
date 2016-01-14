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
    UILabel     *_typeLabel;
    UILabel     *_priceLabel;
    UITextField *_titleTextField;
    UITextField *_addresseeTextField;
    UITextField *_phoneTextField;
    UITextField *_areaTextField;
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
                                                        50*6+20*2)];
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
        return 3;
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
                [detailCell addSubview:[self titleTextField]];
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
                detailCell.message = @"收件地址";
                [detailCell addSubview:[self areaTextField]];
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
    UIButton *submitButton = [UIButton buttonWithImageName:@"orgbtn"
                                               hlImageName:@"orgbtn_pressed"
                                                     title:@"提交"
                                                titleColor:COLORRGB(0xffffff)
                                                      font:HSFONT(15)
                                                onTapBlock:^(UIButton *btn) {
                                                    [self submitBook];
    }];
    
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

- (void)submitBook
{
    self.book.book_title = self.titleTextField.text;
    self.book.book_type = self.typeLabel.text;
    self.book.book_receive_people = self.addresseeTextField.text;
    self.book.book_reveive_tel = self.phoneTextField.text;
    self.book.book_receive_addr = self.areaTextField.text;
    
    [[DuDuAPIClient sharedClient] GET:DEAL_BOOK(self.book.order_ids,
                                                self.book.book_title,
                                                self.book.book_receive_people,
                                                self.book.book_reveive_tel,
                                                self.book.book_receive_addr)
                           parameters:nil
                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                  [ZBCToast showMessage:@"提交成功"];
                                  [self.navigationController popViewControllerAnimated:YES];
                                  if ([self.delegate respondsToSelector:@selector(dealBookSuccess)]) {
                                      [self.delegate dealBookSuccess];
                                  }
                              }
                              failure:^(NSURLSessionDataTask *task, NSError *error) {
                              }];
}

- (UILabel *)priceLabel
{
    NSString *price = self.book.book_price;
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:price
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
        NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
        NSUInteger priceLength = price.length-1;
        [priceString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                             range:NSMakeRange(0, priceLength)];
        _priceLabel.attributedText = priceString;
        NSString *title = @"开票金额";
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:_priceLabel.font}];
        _titleWidth = titleSize.width;
        CGSize priceSize = [_priceLabel.text sizeWithAttributes:@{NSFontAttributeName:_priceLabel.font}];
        [_priceLabel sizeToFit];
        _priceLabel.frame = ccr(10+titleSize.width+10,
                                (50-priceSize.height)/2,
                                priceSize.width,
                                priceSize.height);
    }
    
    return _priceLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithFrame:CGRectZero
                                       color:COLORRGB(0x000000)
                                        font:HSFONT(12)
                                        text:@"约车服务费"
                                   alignment:NSTextAlignmentLeft
                               numberOfLines:1];
        CGSize typeSize = [_typeLabel.text sizeWithAttributes:@{NSFontAttributeName:_typeLabel.font}];
        [_typeLabel sizeToFit];
        _typeLabel.frame = ccr(_titleWidth+10*2,
                               (50-typeSize.height)/2,
                               typeSize.width,
                               typeSize.height);
    }
    
    return _typeLabel;
}

- (UITextField *)titleTextField
{
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                 0,
                                                                 SCREEN_WIDTH-_titleWidth-10*3,
                                                                 50)];
        _titleTextField.font = HSFONT(12);
        _titleTextField.textColor = COLORRGB(0x000000);
        _titleTextField.textAlignment = NSTextAlignmentLeft;
        _titleTextField.delegate = self;
    }
    
    return _titleTextField;
}

- (UITextField *)addresseeTextField
{
    if (!_addresseeTextField) {
        _addresseeTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                     0,
                                                                     SCREEN_WIDTH-_titleWidth-10*3,
                                                                     50)];
        _addresseeTextField.font = HSFONT(12);
        _addresseeTextField.textColor = COLORRGB(0x000000);
        _addresseeTextField.textAlignment = NSTextAlignmentLeft;
        _addresseeTextField.delegate = self;
    }
    return _addresseeTextField;
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                 0,
                                                                 SCREEN_WIDTH-_titleWidth-10*3,
                                                                 50)];
        _phoneTextField.font = HSFONT(12);
        _phoneTextField.textColor = COLORRGB(0x000000);
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.delegate = self;
    }
    
    return _phoneTextField;
}

- (UITextField *)areaTextField
{
    if (!_areaTextField) {
        _areaTextField = [[UITextField alloc] initWithFrame:ccr(_titleWidth+10*2,
                                                                0,
                                                                SCREEN_WIDTH-_titleWidth-10
                                                                *3,
                                                                50)];
        _areaTextField.font = HSFONT(12);
        _areaTextField.textColor = COLORRGB(0x000000);
        _areaTextField.textAlignment = NSTextAlignmentLeft;
        _areaTextField.delegate = self;
    }
    
    return _areaTextField;
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
