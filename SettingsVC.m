//
//  SettingsVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingCell.h"
#import "AddressVC.h"
#import "APService.h"
#import "ValuationRuleListVC.h"
#import "LawVC.h"
#import "WebVC.h"

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
    [self setExtraCellLineHidden:_tableView];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7,
                                                        SCREEN_WIDTH,
                                                        SCREEN_HEIGHT-NAV_BAR_HEIGHT_IOS7)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *identifier = @"conditionCell";
        UITableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!settingCell) {
            settingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            settingCell.selectionStyle = UITableViewCellSelectionStyleNone;
            settingCell.textLabel.font = HSFONT(15);
            settingCell.textLabel.textColor = COLORRGB(0x000000);
        }
        switch (indexPath.row) {
            case 0:
                settingCell.textLabel.text = @"法律条款";
                break;
            case 1:
                settingCell.textLabel.text = @"计价规则";
                break;
            case 2:
                settingCell.textLabel.text = @"关于嘟嘟";
                break;
            case 3:
                settingCell.textLabel.text = @"退出登录";
                break;
            default:
                break;
        }
        return settingCell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        LawVC *lawVC = [[LawVC alloc] init];
        lawVC.title = @"法律条款";
        [self.navigationController pushViewController:lawVC animated:YES];
    } else if (indexPath.row==1) {
        ValuationRuleListVC *ruleListVC = [[ValuationRuleListVC alloc] init];
        ruleListVC.title = @"计价规则";
        [self.navigationController pushViewController:ruleListVC animated:YES];
    } else if (indexPath.row==2) {
        WebVC *agreementVC = [[WebVC alloc] init];
        agreementVC.resourcePath = @"about";
        agreementVC.title = @"关于嘟嘟";
        [self.navigationController pushViewController:agreementVC animated:YES];
    } else {
        [[UIActionSheet actionSheetWithTitle:@"是否退出登录" cancelTitle:@"取消" destructiveTitle:@"确定" destructiveBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [UICKeyChainStore removeAllItemsForService:KEY_STORE_SERVICE];
            [APService setTags:[NSSet setWithObjects:@"dudu_ios", nil]
                         alias:@"-1"
              callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                        object:self];
            [ZBCToast showMessage:@"退出登录成功"];
        } otherItems:nil] showInView:self.navigationController.view];
    }
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
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
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:ccr(10,
                                                                     60-0.5,
                                                                     SCREEN_WIDTH-10*2,
                                                                     0.5)];
    bottomLine.backgroundColor = COLORRGB(0xd7d7d7);
    return bottomLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
