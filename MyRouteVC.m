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
{
    OrderStore *_orderStore;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createTableView];
    [self fetchData];
}

- (void)initData
{
    _orderStore = [[OrderStore alloc] init];
}

- (void)fetchData
{
    [[DuDuAPIClient sharedClient] GET:USER_ORDER_INFO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject][@"info"];
        NSArray *ingArr = dic[@"ing"];
        NSArray *historyArr = dic[@"history"];
        NSArray *ing = [MTLJSONAdapter modelsOfClass:[OrderModel class]
                                                  fromJSONArray:ingArr
                                                          error:nil];
        NSArray *history = [MTLJSONAdapter modelsOfClass:[OrderModel class]
                                           fromJSONArray:historyArr
                                                   error:nil];
        [OrderStore sharedOrderStore].ing = [ing mutableCopy];
        [OrderStore sharedOrderStore].history = [history mutableCopy];

        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
    NSLog(@"%d",[OrderStore sharedOrderStore].history.count);
    return [OrderStore sharedOrderStore].history.count;
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
    OrderModel *order = [OrderStore sharedOrderStore].history[indexPath.row];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[order.startTimeStr floatValue]];
    cell.routeTime = [date displayWithFormat:@"m月d日 H:mm"];
//    cell.routeType = [order.car_style stringValue];
//    cell.routeStatus = @"待评价";
    cell.startSite = order.star_loc_str;
    cell.endSite = order.dest_loc_str;
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
