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
    }
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                detailCell.message = @"开票金额";
                break;
            case 1:
                detailCell.message = @"开票抬头";
                break;
            case 2:
                detailCell.message = @"开票内容";
                break;
            default:
                break;
        }
    } else if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
                detailCell.message = @"收件人";
                break;
            case 1:
                detailCell.message = @"收件电话";
                break;
            case 2:
                detailCell.message = @"所在地区";
                break;
            case 3:
                detailCell.message = @"详细地址";
                break;
            case 4:
                detailCell.message = @"电子邮件";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
