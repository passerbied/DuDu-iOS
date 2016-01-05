//
//  TicketVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "TicketVC.h"
#import "TicketCell.h"

@interface TicketVC ()
{
    UITableView *_tableView;
}

@end

@implementation TicketVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
    [self getCoupons];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7,
                                                        SCREEN_WIDTH,
                                                        SCREEN_HEIGHT-NAV_BAR_HEIGHT_IOS7)];
    _tableView.backgroundColor = COLORRGB(0xf0f0f0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.view addSubview:_tableView];
}

- (void)getCoupons
{
    [[DuDuAPIClient sharedClient] GET:USER_COUPON_INFO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        NSArray *couponArr = dic[@"info"];
        
        self.coupons = [MTLJSONAdapter modelsOfClass:[CouponModel class]
                                       fromJSONArray:couponArr
                                               error:nil];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableView dataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coupons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ticketCell";
    TicketCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!ticketCell) {
        ticketCell = [[TicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        ticketCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:ticketCell atIndexPath:indexPath];
    return ticketCell;
}

- (void)configureCell:(TicketCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CouponModel *coupon = self.coupons[indexPath.row];
    cell.type = coupon.coupon_type;
    NSString *date = coupon.coupon_exp_at; //TODO:等后台加入改字段，目前为空
    cell.date = [NSString stringWithFormat:@"有效期至%@",date];
    if (coupon.coupon_discount<0) {
        cell.detail = [NSString stringWithFormat:@"%.2f折",[coupon.coupon_discount floatValue]];
    } else {
        cell.detail = [NSString stringWithFormat:@"%.2f元",[coupon.coupon_discount floatValue]];
    }
    cell.condition = [NSString stringWithFormat:@"限消费满%.2f元，且在%@~%@时段使用",[coupon.coupon_max_monny floatValue],coupon.coupon_user_start_time,coupon.coupon_user_end_time];
    cell.bgImage.backgroundColor = COLORRGB(0xffffff);
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
