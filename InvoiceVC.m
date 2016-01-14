//
//  InvoiceVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "InvoiceVC.h"
#import "InvoiceDetailVC.h"

#define SIZE 10

@interface InvoiceVC ()
{
    ZBCLodingFooter *_loadingFooter;
    UITableView     *_tableView;
    UILabel         *_totalLabel;
    float           _totalPrice;
    int             _totalRoute;
    NSMutableArray  *_bookList;
    UIButton        *_selectAllButton;
    UIButton        *_nextButton;
    BOOL            _loadingMore;
    BOOL            _isAll;
    int             _currentPage;
    BOOL            _isSelectAll;
}

@end

@implementation InvoiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    _loadingFooter =
    [[ZBCLodingFooter alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 50)];
    _loadingFooter.delegate = self;
    _bookList = [NSMutableArray array];
    [self createTableView];
    [self getBooksForPage:0 isMore:NO];
}

- (void)getBooksForPage:(int)page isMore:(BOOL)isMore
{
    if (![UICKeyChainStore stringForKey:KEY_STORE_ACCESS_TOKEN service:KEY_STORE_SERVICE]) {
        [ZBCToast showMessage:@"请先登录"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    _loadingMore = isMore;
    [_loadingFooter loading];
    _loadingFooter.isLoadMore = isMore;
    [[DuDuAPIClient sharedClient] GET:BOOK_ORDER_LIST(page) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self fetchDataSuccess:responseObject
                    isLoadMore:isMore];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)updateFooter
{
    _totalPrice = 0;
    _totalRoute = 0;
    for (BookModel *book in _bookList) {
        if (book.isSelected) {
            _totalPrice += [book.order_allMoney floatValue];
            _totalRoute ++;
        }
    }
    if (_totalRoute == _bookList.count) {
        _isSelectAll = YES;
        [_selectAllButton setImage:IMG(@"checkbox_yes")
                          forState:UIControlStateNormal];
        [_selectAllButton setImage:IMG(@"checkbox_yes")
                          forState:UIControlStateSelected];
    } else {
        _isSelectAll = NO;
        [_selectAllButton setImage:IMG(@"checkbox_no")
                          forState:UIControlStateNormal];
        [_selectAllButton setImage:IMG(@"checkbox_no")
                          forState:UIControlStateSelected];
    }
    
    _totalLabel.text = [NSString stringWithFormat:@"合计:%.1f元 共%d个行程",_totalPrice,_totalRoute];
    NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:_totalLabel.text];
    NSString *priceText = [NSString stringWithFormat:@"%.1f",_totalPrice];
    NSUInteger priceLength = priceText.length;
    NSString *numberText = [NSString stringWithFormat:@"%d",_totalRoute];
    NSUInteger numberLength = numberText.length;
    NSUInteger numberLocation = _totalLabel.text.length-3-numberLength;
    [totalString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                         range:NSMakeRange(3, priceLength)];
    [totalString addAttributes:@{NSForegroundColorAttributeName:COLORRGB(0xedad49)}
                         range:NSMakeRange(numberLocation, numberLength)];
    _totalLabel.attributedText = totalString;
    
    [_nextButton setEnabled:_totalRoute >= 2];
}

- (void)selectAllBookDidTaped
{
    if (!_isSelectAll) {
        for (BookModel *book in _bookList) {
            book.isSelected = YES;
        }
    } else {
        for (BookModel *book in _bookList) {
            book.isSelected = NO;
        }
    }
    [_tableView reloadData];
    [self updateFooter];
}

- (void)fetchDataSuccess:(id)responseObject isLoadMore:(BOOL)isMore
{
    NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];

    if (!isMore) {
        
        //接口返回数据类型不统一，无法通过MTLJSONAdapter映射到Model，导致这么一大顿体力代码
        
//        _bookList = [[MTLJSONAdapter modelsOfClass:[BookModel class]
//                                     fromJSONArray:dic[@"info"]
//                                             error:nil] mutableCopy];
        NSArray *info = [NSArray arrayWithArray:dic[@"info"]];
        if (info.count) {
            for (NSDictionary *item in info) {
                BookModel *book = [[BookModel alloc] init];
                book.car_style = item[@"car_style"];
                book.coupon_id = item[@"coupon_id"];
                book.dest_lat = item[@"dest_lat"];
                book.dest_lng = item[@"dest_lng"];
                book.dest_loc_str = item[@"dest_loc_str"];
                book.driver_status = item[@"driver_status"];
                book.isbook = item[@"isbook"];
                book.order_allMoney = item[@"order_allMoney"];
                book.order_allTime = item[@"order_allTime"];
                book.order_duration_money = item[@"order_duration_money"];
                book.order_id = item[@"order_id"];
                book.order_initiate_rate = item[@"order_initiate_rate"];
                book.order_mileage = item[@"order_mileage"];
                book.order_mileage_money = item[@"order_mileage_money"];
                book.order_payStatus = item[@"order_payStatus"];
                book.order_status = item[@"order_status"];
                book.order_time = item[@"order_time"];
                book.relevance_id = item[@"relevance_id"];
                book.star_loc_str = item[@"star_loc_str"];
                book.startTimeStr = item[@"startTimeStr"];
                book.startTimeType = item[@"startTimeType"];
                book.start_lat = item[@"start_lat"];
                book.start_lng = item[@"start_lng"];
                book.user_id = item[@"user_id"];
                
                [_bookList addObject:book];
            }
        }
        _isAll = _bookList.count < SIZE;
        if (_isAll) {
            [_loadingFooter loadedAll];
        }
        [self updateFooter];
        [_tableView reloadData];
        _loadingMore = NO;
    } else {
        
//        NSArray *booklistTemp = [MTLJSONAdapter modelsOfClass:[BookModel class]
//                                                fromJSONArray:dic[@"info"]
//                                                        error:nil];
        
        NSMutableArray *booklistTemp = [NSMutableArray array];
        NSArray *info = [NSArray arrayWithArray:dic[@"info"]];
        if (info.count) {
            for (NSDictionary *item in info) {
                BookModel *book = [[BookModel alloc] init];
                book.car_style = item[@"car_style"];
                book.coupon_id = item[@"coupon_id"];
                book.dest_lat = item[@"dest_lat"];
                book.dest_lng = item[@"dest_lng"];
                book.dest_loc_str = item[@"dest_loc_str"];
                book.driver_status = item[@"driver_status"];
                book.isbook = item[@"isbook"];
                book.order_allMoney = item[@"order_allMoney"];
                book.order_allTime = item[@"order_allTime"];
                book.order_duration_money = item[@"order_duration_money"];
                book.order_id = item[@"order_id"];
                book.order_initiate_rate = item[@"order_initiate_rate"];
                book.order_mileage = item[@"order_mileage"];
                book.order_mileage_money = item[@"order_mileage_money"];
                book.order_payStatus = item[@"order_payStatus"];
                book.order_status = item[@"order_status"];
                book.order_time = item[@"order_time"];
                book.relevance_id = item[@"relevance_id"];
                book.star_loc_str = item[@"star_loc_str"];
                book.startTimeStr = item[@"startTimeStr"];
                book.startTimeType = item[@"startTimeType"];
                book.start_lat = item[@"start_lat"];
                book.start_lng = item[@"start_lng"];
                book.user_id = item[@"user_id"];
                
                [booklistTemp addObject:book];
            }
        }
        _isAll = booklistTemp.count < SIZE;
        if (_isAll) {
            [_loadingFooter loadedAll];
        }
        if (booklistTemp.count > 0) {
            [_tableView beginUpdates];
            NSMutableArray *indexs = [NSMutableArray array];
            [booklistTemp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [indexs addObject:[NSIndexPath indexPathForRow:_bookList.count + idx
                                                     inSection:0]];
            }];
            [_tableView insertRowsAtIndexPaths:indexs
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            [_bookList addObjectsFromArray:booklistTemp];
            [_tableView endUpdates];
        }
        _loadingMore = NO;
        [self updateFooter];
    }
    
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:ccr(0,
                                                        NAV_BAR_HEIGHT_IOS7,
                                                        SCREEN_WIDTH,
                                                        SCREEN_HEIGHT-NAV_BAR_HEIGHT_IOS7-[self loadFooterView].height)];
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLORRGB(0xffffff);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    _tableView.tableHeaderView = [self loadHeaderView];
    _tableView.tableFooterView = _loadingFooter;
    [self.view addSubview:_tableView];
    [self.view addSubview:[self loadFooterView]];
}

- (UIView *)loadHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = COLORRGB(0xf0f0f0);
    
    UILabel *introLabel = [UILabel labelWithFrame:CGRectZero
                                            color:COLORRGB(0x000000)
                                             font:HSFONT(12)
                                             text:@"开票说明 | 开票历史"
                                        alignment:NSTextAlignmentRight
                                    numberOfLines:1];
    CGSize introSize = [introLabel.text sizeWithAttributes:@{NSFontAttributeName:introLabel.font}];
    [introLabel sizeToFit];
    introLabel.frame = ccr(SCREEN_WIDTH-5-introSize.width,
                           (50-introSize.height)/2,
                           introSize.width,
                           introSize.height);
    [headerView addSubview:introLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:ccr(0, 50-0.5, SCREEN_WIDTH, 0.5)];
    lineImage.backgroundColor = COLORRGB(0xd7d7d7);
    [headerView addSubview:lineImage];
    return headerView;
}

- (UIView *)loadFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = COLORRGB(0xf0f0f0);
    
    _selectAllButton = [UIButton buttonWithImageName:@"checkbox_no"
                                         hlImageName:@"checkbox_no"
                                          onTapBlock:^(UIButton *btn) {
                                              [self selectAllBookDidTaped];
                                          }];
    _selectAllButton.frame = ccr(20, 10, 16, 16);
    [footerView addSubview:_selectAllButton];
    
    UILabel *selectAllLabel = [UILabel labelWithFrame:CGRectZero
                                                color:COLORRGB(0x000000)
                                                 font:HSFONT(12)
                                                 text:@"全选"
                                            alignment:NSTextAlignmentLeft
                                        numberOfLines:1];
    CGSize allSize = [selectAllLabel.text sizeWithAttributes:@{NSFontAttributeName:selectAllLabel.font}];
    [selectAllLabel sizeToFit];
    selectAllLabel.frame = ccr(CGRectGetMaxX(_selectAllButton.frame)+10,
                               _selectAllButton.origin.y,
                               allSize.width,
                               allSize.height);
    [footerView addSubview:selectAllLabel];
    
    UILabel *introdceLabel = [UILabel labelWithFrame:CGRectZero
                                               color:COLORRGB(0x000000)
                                                font:HSFONT(11)
                                                text:@"需要至少选择5条行程才能开发票"
                                           alignment:NSTextAlignmentRight
                                       numberOfLines:1];
    CGSize introSize = [self getTextFromLabel:introdceLabel];
    introdceLabel.frame = ccr(SCREEN_WIDTH-10-introSize.width,
                              selectAllLabel.origin.y,
                              introSize.width,
                              introSize.height);
    [footerView addSubview:introdceLabel];
    
    _nextButton = [UIButton buttonWithImageName:@"orgbtn"
                                    hlImageName:@"orgbtn_pressed"
                              DisabledImageName:@"commbtn"
                                          title:@"下一步"
                                     titleColor:COLORRGB(0xffffff)
                                           font:HSFONT(15)
                             disabledTitleColor:COLORRGB(0xffffff)
                                     onTapBlock:^(UIButton *btn) {
                                         [self didClickNextButtonAction];
                                     }];
    _nextButton.frame = ccr(SCREEN_WIDTH-10-120,
                            CGRectGetMaxY(introdceLabel.frame)+10,
                            120,
                            40);
    [_nextButton setEnabled:NO];
    [footerView addSubview:_nextButton];
    
    _totalLabel = [UILabel labelWithFrame:ccr(_selectAllButton.origin.x,
                                              _nextButton.origin.y+(_nextButton.height-20)/2,
                                              SCREEN_WIDTH-_selectAllButton.origin.x-_nextButton.width-10-20,
                                              20)
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [footerView addSubview:_totalLabel];
    CGFloat footHeight = CGRectGetMaxY(_nextButton.frame)+10;
    footerView.frame = ccr(0,
                           SCREEN_HEIGHT-footHeight,
                           SCREEN_WIDTH,
                           footHeight
                           );
    return footerView;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bookList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"invoiceCell";
    InvoiceCell *invoiceCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!invoiceCell) {
        invoiceCell = [[InvoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        invoiceCell.delegate = self;
    }
    [self configureCell:invoiceCell atIndexPath:indexPath];
    CGRect frame = [invoiceCell calculateFrame];
    return frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"invoiveCell";
    InvoiceCell *invoiceCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!invoiceCell) {
        invoiceCell = [[InvoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        invoiceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        invoiceCell.delegate = self;
    }
    [self configureCell:invoiceCell atIndexPath:indexPath];
    return invoiceCell;
}

- (void)configureCell:(InvoiceCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    BookModel *book = _bookList[indexPath.row];

    NSDate *start = [NSDate dateWithTimeIntervalSince1970:[book.startTimeStr floatValue]];
    cell.startTime = [start displayWithFormat:@"yyyy-MM-dd H:mm"];
    cell.price = book.order_allMoney;
    cell.startSite = book.star_loc_str;
    cell.endSite = book.dest_loc_str;
    cell.isSelected = book.isSelected;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvoiceCell *invoiceCell = (InvoiceCell *)[tableView cellForRowAtIndexPath:indexPath];
    BookModel *book = _bookList[indexPath.row];
    book.isSelected = !book.isSelected;
    invoiceCell.isSelected = book.isSelected;
    [_bookList setObject:book atIndexedSubscript:indexPath.row];
    [invoiceCell calculateFrame];
    [self updateFooter];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bookList.count - indexPath.row < 2 && !_loadingMore) {
        if(!_isAll)
        {
            [self getBooksForPage:_currentPage+1 isMore:YES];
        } else {
            [_loadingFooter loadedAll];
        }
    }
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

- (void)didClickNextButtonAction
{
    InvoiceDetailVC *detailVC = [[InvoiceDetailVC alloc] init];
    detailVC.title = @"按行程开票";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - InvoiceCellDelegate

- (void)invoiceCell:(InvoiceCell *)cell didChecked:(BOOL)checked
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    BookModel *book = _bookList[indexPath.row];
    book.isSelected = checked;
    [_bookList setObject:book atIndexedSubscript:indexPath.row];
    [cell calculateFrame];
    [self updateFooter];
}

@end
