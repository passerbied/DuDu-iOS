//
//  LawVC.m
//  DuDu
//
//  Created by i-chou on 1/15/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "LawVC.h"
#import "WebVC.h"

@interface LawVC ()

@end

@implementation LawVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
}


#pragma mark - Table view data source

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = COLORRGB(0x000000);
        cell.textLabel.font = HSFONT(15);
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"法律声明及隐私政策";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"用车使用条款";
    } else {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebVC *webVC = [[WebVC alloc] init];
    if (indexPath.row == 0) {
        webVC.resourcePath = @"law";
        webVC.title = @"法律声明及隐私政策";
    } else {
        webVC.resourcePath = @"agreement";
        webVC.title = @"用车使用条款";
    }
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
