//
//  AddressPickerViewController.m
//  DuDu
//
//  Created by i-chou on 11/9/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "AddressPickerViewController.h"

@interface AddressPickerViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tips;

@end

@implementation AddressPickerViewController

- (id)initWithLocation:(NSString *)location
{
    return [super init];
}
/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = @"北京";
    [self.search AMapInputTipsSearch:tips];
}

#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error.debugDescription);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.tips setArray:response.tips];
    [self.tableView reloadData];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self.tips setArray:response.pois];
    [self.tableView reloadData];
}

//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    [self.tips setArray:response.geocodes];
//    for (AMapTip *p in response.geocodes) {
//        [self.tips addObject:p];
//    }
    [self.tableView reloadData];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *key = searchBar.text;
    /* 按下键盘enter, 搜索poi */
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords         = key;
    request.city             = @"010";
    request.requireExtension = YES;
    [self.search AMapPOIKeywordsSearch:request];
    self.searchBar.placeholder = key;
    [self.searchBar endEditing:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchTipsWithKey:searchText];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"locate"];
    }
    
    AMapTip *tip = self.tips[indexPath.row];
    
    if (tip.location == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"search"];
    }
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.district;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = self.tips[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(addressPicker:fromAddress:toAddress:)]) {
        if (self.isFrom) {
            [self.delegate addressPicker:self fromAddress:tip toAddress:nil];
        } else {
            [self.delegate addressPicker:self fromAddress:nil toAddress:tip];
        }
    }
    if (!self.isFromAddressVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Initialization

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

- (void)startLocation
{
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = self.location;
    
    //发起正向地理编码
    [self.search AMapGeocodeSearch:geo];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSearchBar];
    [self initTableView];
    
    [AMapSearchServices sharedServices].apiKey = AMAP_KEY;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
//    [self startLocation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.search.delegate = nil;
}

@end
