//
//  SettingsVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingCell.h"

@interface SettingsVC ()
{
    UITableView *_tableView;
}

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7+30,
                                                        SCREEN_WIDTH,
                                                        SCREEN_HEIGHT-NAV_BAR_HEIGHT_IOS7-30*2)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell addSubview:[self addressLabel]];
        [cell addSubview:[self arrowImage]];
        [cell addSubview:[self bottomLine]];
        return cell;
    } else {
        static NSString *identifier = @"conditionCell";
        SettingCell *settingCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!settingCell) {
            settingCell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        switch (indexPath.row) {
            case 1:
                settingCell.condition = @"帮助与反馈";
                break;
            case 2:
                settingCell.condition = @"法律条款";
                break;
            case 3:
                settingCell.condition = @"关于海豹";
                break;
            case 4:
                settingCell.condition = @"退出登录";
                break;
            default:
                break;
        }
        return settingCell;
    }
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UILabel *)addressLabel
{
    UILabel *addressLabel = [UILabel labelWithFrame:CGRectZero
                                              color:COLORRGB(0x000000)
                                               font:HSFONT(15)
                                               text:@"常用地址"
                                          alignment:NSTextAlignmentLeft
                                      numberOfLines:1];
    CGSize addressSize = [addressLabel.text sizeWithAttributes:@{NSFontAttributeName:addressLabel.font}];
    [addressLabel sizeToFit];
    addressLabel.frame = ccr(10, 0, addressSize.width, 60);
    return addressLabel;
}

- (UIImageView *)arrowImage
{
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-30-10,
                                                                     (60-30)/2,
                                                                     30,
                                                                     30)];
    arrowImage.userInteractionEnabled = YES;
    arrowImage.image = IMG(@"arrow_right");
    return arrowImage;
}

- (UIImageView *)bottomLine
{
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:ccr(0,
                                                                     60-0.5,
                                                                     SCREEN_WIDTH,
                                                                     0.5)];
    bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    return bottomLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
