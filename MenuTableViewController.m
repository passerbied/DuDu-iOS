//
//  MenuTableViewController.m
//  DuDu
//
//  Created by i-chou on 11/17/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuCell.h"
#import "MyRouteVC.h"

#define PADDING 10

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController
{
    UIImageView *_avator;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 90)];
    _avator = [[UIImageView alloc] initWithFrame:ccr(20, 20, 50, 50)];
    _avator.backgroundColor = COLORRGB(0xcccccc);
    _avator.layer.cornerRadius = _avator.width/2;
    _avator.layer.masksToBounds = YES;
    _avator.image = IMG(@"account");
    
    [headerView addSubview:_avator];
    
    _nameLabel = [UILabel labelWithFrame:ccr(CGRectGetMaxX(_avator.frame)+10,
                                             20,
                                             SCREEN_WIDTH-CGRectGetMaxX(_avator.frame)-20-20,
                                             _avator.height/2)
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(15)
                                    text:@"Passerbied"];
    [headerView addSubview:_nameLabel];
    
    _phoneLabel = [UILabel labelWithFrame:ccr(_nameLabel.x,
                                              CGRectGetMaxY(_nameLabel.frame),
                                              _nameLabel.width,
                                              _avator.height/2)
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(15)
                                     text:@"18698600911"];
    [headerView addSubview:_phoneLabel];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:ccr(SCREEN_WIDTH-20-20, (headerView.height - 30)/2, 30, 30)];
    arrow.image = IMG(@"arrow_right");
    [headerView addSubview:arrow];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:ccr(15, CGRectGetMaxY(headerView.frame)-0.7, SCREEN_WIDTH-15, 0.7)];
    line.backgroundColor = COLORRGB(0xdddddd);
    [headerView addSubview:line];
    
    self.tableView.tableHeaderView = headerView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    if (indexPath.row == 0) {
        cell.icon.image = IMG(@"tiny_history");
        cell.title.text = @"我的行程";
    } else if (indexPath.row == 1) {
        cell.icon.image = IMG(@"tiny_coupon");
        cell.title.text = @"我的优惠券";
    } else if (indexPath.row == 2) {
        cell.icon.image = IMG(@"tiny_shared");
        cell.title.text = @"好友分享礼券";
    } else if (indexPath.row == 3) {
        cell.icon.image = IMG(@"tiny_bill");
        cell.title.text = @"邮寄发票";
    } else {
        cell.icon.image = IMG(@"tiny_unbind");
        cell.title.text = @"解除手机绑定";
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyRouteVC *myRouteVC = [[MyRouteVC alloc] init];
        myRouteVC.title = @"我的行程";
        [self.navigationController pushViewController:myRouteVC animated:YES];
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        
    } else {
    }
}

@end
