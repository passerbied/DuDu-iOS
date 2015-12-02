//
//  MyWalletVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "MyWalletVC.h"
#import "MenuCell.h"

@interface MyWalletVC ()

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
}

- (void)createTableView
{
    self.tableView.backgroundColor = COLORRGB(0xffffff);
    self.tableView.frame = ccr(0, 20, SCREEN_WIDTH, 180);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"walletCell";
    MenuCell *walletCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!walletCell) {
        walletCell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        walletCell.iconImage.image = IMG(@"tiny_history");
        walletCell.title = @"发票";
    } else if (indexPath.row == 1) {
        walletCell.iconImage.image = IMG(@"tiny_coupon");
        walletCell.title = @"打车券";
    } else {
        walletCell.iconImage.image = IMG(@"tiny_shared");
        walletCell.title = @"余额";
    }
    return walletCell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
