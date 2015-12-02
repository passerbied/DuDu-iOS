//
//  MyRouteVC.m
//  DuDu
//
//  Created by 教路浩 on 15/11/30.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "MyRouteVC.h"
#import "RouteCell.h"
#import "RouteDetailVC.h"

@interface MyRouteVC ()

@end

@implementation MyRouteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView
{
    self.tableView.backgroundColor = COLORRGB(0xffffff);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"routeCell";
    RouteCell *routeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!routeCell) {
        routeCell = [[RouteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self configureCell:routeCell atIndexPath:indexPath];
    CGRect frame = [routeCell calculateFrame];
    return frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"routeCell";
    RouteCell *routeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!routeCell) {
        routeCell = [[RouteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self configureCell:routeCell atIndexPath:indexPath];
    return routeCell;
}

- (void)configureCell:(RouteCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.routeTime = @"11月22日 08:40";
    cell.routeType = @"顺风车·乘客";
    cell.routeStatus = @"待评价";
    cell.startSite = @"朝阳区立水桥明天第一城蓝黛时空汇KTV";
    cell.endSite = @"朝阳区红军营南路傲城融富中心B座";
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouteDetailVC *detailVC = [[RouteDetailVC alloc] init];
    detailVC.title = @"行程详情";
    [self.navigationController pushViewController:detailVC animated:YES];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
