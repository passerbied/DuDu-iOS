//
//  ValuationRuleListVC.m
//  DuDu
//
//  Created by i-chou on 1/17/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "ValuationRuleListVC.h"
#import "MainViewController.h"
#import "ValuationRuleVC.h"

@interface ValuationRuleListVC ()

@end

@implementation ValuationRuleListVC
{
    NSArray *_carStyles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _carStyles = [MainViewController sharedMainViewController].carStyles;
    [self setExtraCellLineHidden:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _carStyles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"carStyleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = HSFONT(15);
        cell.textLabel.textColor = COLORRGB(0x000000);
    }
    CarModel *car = _carStyles[indexPath.row];
    cell.textLabel.text = car.car_style_name;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarModel *car = _carStyles[indexPath.row];
    ValuationRuleVC *ruleVC = [[ValuationRuleVC alloc] init];
    ruleVC.title = [NSString stringWithFormat:@"%@计价规则",car.car_style_name];
    ruleVC.carStyle = car;
    [self.navigationController pushViewController:ruleVC animated:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
