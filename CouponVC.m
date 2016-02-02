//
//  CouponVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/3.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "CouponVC.h"
#import "CouponCell.h"

@interface CouponVC ()
{
    UITableView *_tableView;
}

@end

@implementation CouponVC

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
    
    if (self.showUnuseHeader) {
        UIView *header = [[UIView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 45)];
        UILabel *content = [UILabel labelWithFrame:ccr(5, 5, SCREEN_WIDTH-10, 35)
                                             color:COLORRGB(0x63666b)
                                              font:HSFONT(15)
                                              text:@"不使用优惠券"
                                         alignment:NSTextAlignmentCenter
                                     numberOfLines:1];
        content.backgroundColor = COLORRGB(0xffffff);
        content.layer.borderColor = COLORRGB(0xf39a00).CGColor;
        content.layer.borderWidth = 0.5f;
        content.layer.masksToBounds = YES;
        content.layer.cornerRadius = 5.0;
        [header addSubview:content];
        UIButton *btn = [UIButton buttonWithImageName:nil
                                          hlImageName:nil
                                           onTapBlock:^(UIButton *btn) {
                                               if ([self.delegate respondsToSelector:@selector(didSelectUnuseCoupon)]) {
                                                   [self.delegate didSelectUnuseCoupon];
                                               }
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }];
        btn.frame = content.frame;
        [header addSubview:btn];
        
        _tableView.tableHeaderView = header;
    }
    
    [self.view addSubview:_tableView];
}

- (void)getCoupons
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [[DuDuAPIClient sharedClient] GET:USER_COUPON_INFO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[CouponModel class]
                                       fromJSONArray:dic[@"info"]
                                               error:nil];
        [CouponStore sharedCouponStore].info = arr;
        self.coupons = [CouponStore sharedCouponStore].info;

        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableView dataSource 
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50.0f;
//}

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
    CouponCell *couponCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!couponCell) {
        couponCell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:couponCell atIndexPath:indexPath];
    return couponCell;
}

- (void)configureCell:(CouponCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CouponModel *coupon = self.coupons[indexPath.row];
    cell.coupon_title = coupon.coupon_title;
    cell.coupon_type = coupon.coupon_type;
    NSString *date = coupon.coupon_exp_at;
    cell.date = [NSString stringWithFormat:@"有效期至%@",date];
    if ([coupon.coupon_discount floatValue] < 1) {
        cell.detail = [NSString stringWithFormat:@"%.1f折",[coupon.coupon_discount floatValue]*10];
    } else {
        cell.detail = [NSString stringWithFormat:@"%.1f元",[coupon.coupon_discount floatValue]];
    }
    cell.condition = [NSString stringWithFormat:@"限消费满%.1f元，且在%@~%@时段使用(%@专用)",[coupon.coupon_max_monny floatValue],coupon.coupon_user_start_time,coupon.coupon_user_end_time,coupon.car_style_name];
    cell.bgImage.backgroundColor = COLORRGB(0xffffff);
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(couponVC:didSelectCouponIndex:)]) {
        [self.delegate couponVC:self didSelectCouponIndex:(int)indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
