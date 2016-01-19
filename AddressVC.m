//
//  AddressVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "AddressVC.h"

@interface AddressVC ()
{
    UITableView *_tableView;
    UILabel     *_homeLabel;
    UILabel     *_companyLabel;
}

@end

@implementation AddressVC

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
                                                        60*2)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.scrollEnabled = NO;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row==0) {
        [cell addSubview:[self homeLabel]];
    } else if (indexPath.row==1) {
        [cell addSubview:[self companyLabel]];
    }
    [cell addSubview:[self bottomLine]];
    return cell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeoAndSuggestionViewController *addressPickerVC = [[GeoAndSuggestionViewController alloc] init];
    addressPickerVC.delegate = self;
    [self.navigationController pushViewController:addressPickerVC animated:YES];
    if (indexPath.row==0) {
        addressPickerVC.title = @"家地址";
        addressPickerVC.isFrom = YES;
    } else if (indexPath.row==1) {
        addressPickerVC.title = @"公司地址";
        addressPickerVC.isFrom = NO;
    }
}

- (UILabel *)homeLabel
{
    _homeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@"输入家地址"
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    _homeLabel.frame = ccr(10, 0, SCREEN_WIDTH-10*2, 60);
    return _homeLabel;
}

- (UILabel *)companyLabel
{
    _companyLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@"输入公司地址"
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    _companyLabel.frame = ccr(10, 0, SCREEN_WIDTH-10*2, 60);
    return _companyLabel;
}

- (UIImageView *)bottomLine
{
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:ccr(0, 60-0.5, SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    return bottomLine;
}

#pragma mark - GeoAndSuggestionViewControllerDelegate

- (void)addressPicker:(GeoAndSuggestionViewController *)pickerVC fromAddress:(QMSSuggestionPoiData *)fromPoi toAddress:(QMSSuggestionPoiData *)toPoi
{
    if (fromPoi) {
        _homeLabel.text = fromPoi.title;
    } else {
        _companyLabel.text = toPoi.title;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
