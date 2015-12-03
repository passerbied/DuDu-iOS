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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xf0f0f0);
    [self createTableView];
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

#pragma mark - tableView dataSource 

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
    cell.type = @"快车券";
    NSString *date = @"2015-12-10";
    cell.date = [NSString stringWithFormat:@"有效期至%@",date];
    cell.detail = @"9.0折";
    cell.condition = @"最高抵扣5元";
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
