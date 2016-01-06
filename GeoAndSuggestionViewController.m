//
//  GeoAndSuggestionViewController.m
//  QMapSearchDemo
//
//  Created by xfang on 14/11/17.
//  Copyright (c) 2014年 tencent. All rights reserved.
//

#import "GeoAndSuggestionViewController.h"
#import <QMapKit/QMapKit.h>

@interface GeoAndSuggestionViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, QMSSearchDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) QMSSearcher *mapSearcher;

@property (nonatomic, strong) QMSSuggestionResult *suggestionResut;

@end

@implementation GeoAndSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchBar];
    [self initTableView];

    self.mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
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
}

#pragma mark - QMSSearcher Delegate

- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error
{
    NSLog(@"error:%@", error);
}

- (void)searchWithSuggestionSearchOption:(QMSSuggestionSearchOption *)suggestionSearchOption didReceiveResult:(QMSSuggestionResult *)suggestionSearchResult
{
    NSLog(@"suggest result:%@", suggestionSearchResult);
    self.suggestionResut = suggestionSearchResult;
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    self.searchBar.placeholder = searchBar.text;
}

#pragma mark - UISearchBarDelegate

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
    QMSSuggestionPoiData *poi = self.suggestionResut.dataArray[indexPath.row];
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
    return [self.suggestionResut.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"REUSE_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    QMSSuggestionPoiData *poi = [self.suggestionResut.dataArray objectAtIndex:[indexPath row
                                                                               ]];
    
    [cell.textLabel setText:poi.title];
    [cell.detailTextLabel setText:poi.address];
    
    return cell;
}

@end
