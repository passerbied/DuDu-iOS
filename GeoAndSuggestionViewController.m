//
//  GeoAndSuggestionViewController.m
//  QMapSearchDemo
//
//  Created by xfang on 14/11/17.
//  Copyright (c) 2014年 tencent. All rights reserved.
//

#import "GeoAndSuggestionViewController.h"
#import <QMapKit/QMapKit.h>
#import "OrderModel.h"

@interface GeoAndSuggestionViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, QMSSearchDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) QMSSearcher *mapSearcher;
@property (nonatomic, strong) QMSSuggestionResult *suggestionResut;

@end

@implementation GeoAndSuggestionViewController
{
    NSArray *_start_List;
    NSArray *_dest_List;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _start_List = [NSArray array];
    _dest_List = [NSArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
    
    [self getHistoryLocDescriptions:self.historyOrders];
    [self initSearchBar];
    [self initTableView];

}

- (void)initSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT_IOS7, CGRectGetWidth(self.view.bounds), 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    
    self.searchBar.placeholder  = @"输入地点";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [self.searchBar becomeFirstResponder];
    
    [self.view addSubview:self.searchBar];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:ccr(0, CGRectGetMaxY(self.searchBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.searchBar.frame))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)getHistoryLocDescriptions:(NSArray *)historyOrders
{
    for (int i = 0; i<historyOrders.count; i++) {
        OrderModel *order = historyOrders[i];
        QMSReverseGeoCodeSearchOption *option = [[QMSReverseGeoCodeSearchOption alloc] init];
        [option setGet_poi:NO];
        if (self.isFrom) {
            option.location = [NSString stringWithFormat:@"%@,%@",order.start_lat,order.start_lng];
        } else {
            option.location = [NSString stringWithFormat:@"%@,%@",order.dest_lat,order.dest_lng];
        }
        [self.mapSearcher searchWithReverseGeoCodeSearchOption:option];
    }
}

#pragma mark - QMSSearcher Delegate

- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error
{
    NSLog(@"error:%@", error.description);
}

- (void)searchWithSuggestionSearchOption:(QMSSuggestionSearchOption *)suggestionSearchOption didReceiveResult:(QMSSuggestionResult *)suggestionSearchResult
{
    self.suggestionResut = suggestionSearchResult;
    [self.tableView reloadData];
}

- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult
{
    if (!self.suggestionResut) {
        for (int i = 0; i<self.historyOrders.count; i++) {
            OrderModel *order = self.historyOrders[i];
            if (self.isFrom) {
                if ([reverseGeoCodeSearchOption.location isEqualToString:[NSString stringWithFormat:@"%@,%@",order.start_lat,order.start_lng]]) {
                    order.star_loc_description = reverseGeoCodeSearchResult.formatted_addresses.recommend;
                    [self.historyOrders setObject:order atIndexedSubscript:i];
                    NSArray *rows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:i inSection:0], nil];
                    [self.tableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];
                }
            } else {
                if ([reverseGeoCodeSearchOption.location isEqualToString:[NSString stringWithFormat:@"%@,%@",order.dest_lat,order.dest_lng]]) {
                    order.dest_loc_description = reverseGeoCodeSearchResult.formatted_addresses.recommend;
                    [self.historyOrders setObject:order atIndexedSubscript:i];
                    NSArray *rows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:i inSection:0], nil];
                    [self.tableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    self.searchBar.placeholder = searchBar.text;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //配置搜索参数
    QMSSuggestionSearchOption *suggetionOption = [[QMSSuggestionSearchOption alloc] init];
    [suggetionOption setKeyword:searchText];
    [suggetionOption setRegion:self.currentCity];
    
    [self.mapSearcher searchWithSuggestionSearchOption:suggetionOption];
}

#pragma mark - Search Result Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QMSSuggestionPoiData *poi;
    if ([self.suggestionResut.dataArray count]) {
        poi = self.suggestionResut.dataArray[indexPath.row];
    } else {
        OrderModel *order = self.historyOrders[indexPath.row];
        poi = [[QMSSuggestionPoiData alloc] init];
        if (self.isFrom) {
            poi.location = CLLocationCoordinate2DMake([order.start_lat floatValue],[order.start_lng floatValue]);
            poi.title = order.star_loc_str;
        } else {
            poi.location = CLLocationCoordinate2DMake([order.dest_lat floatValue],[order.dest_lng floatValue]);
            poi.title = order.dest_loc_str;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(addressPicker:fromAddress:toAddress:)]) {
        if (self.isFrom) {
            [self.delegate addressPicker:self fromAddress:poi toAddress:nil];
        } else {
            [self.delegate addressPicker:self fromAddress:nil toAddress:poi];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.suggestionResut.dataArray count]) {
        return [self.suggestionResut.dataArray count];
    }
    return [self.historyOrders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"REUSE_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    if (self.suggestionResut.dataArray.count) {
        QMSSuggestionPoiData *poi = [self.suggestionResut.dataArray objectAtIndex:[indexPath row
                                                                                   ]];
        
        [cell.textLabel setText:poi.title];
        [cell.detailTextLabel setText:poi.address];
    } else {
        OrderModel *order = self.historyOrders[indexPath.row];
        if (self.isFrom) {
            [cell.textLabel setText:order.star_loc_str];
            [cell.detailTextLabel setText:order.star_loc_description?order.star_loc_description:order.star_loc_str];
        } else {
            [cell.textLabel setText:order.dest_loc_str];
            [cell.detailTextLabel setText:order.dest_loc_description?order.dest_loc_description:order.dest_loc_str];
        }
    }
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
    self.searchBar.placeholder = self.searchBar.text;
}

@end
