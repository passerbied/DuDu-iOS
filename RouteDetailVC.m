//
//  RouteDetailVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/1.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RouteDetailVC.h"
#import "CheckDetailVC.h"

@interface RouteDetailVC ()
{
    UIView      *_headerView;
    UIImageView *_timeImage;
    UILabel     *_timeLabel;
    UIImageView *_startImage;
    UILabel     *_startLabel;
    UIImageView *_endImage;
    UILabel     *_endLabel;

    UIImageView *_leftLine;
    UILabel     *_successLabel;
    UIImageView *_rightLine;
    UILabel     *_carStyleLabel;
    UILabel     *_priceLabel;
    UIImageView *_detailImage;
    UIButton    *_detailButton;
    UIImageView *_leftLine2;
    UILabel     *_impressLabel;
    UIImageView *_rightLine2;
    UIImageView *_commentImage;
    UIButton    *_commentButton;
    UILabel     *_estimateLabel;
    UIImageView *_shareImage;
    UIButton    *_shareButton;
}

@end

@implementation RouteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
}

- (void)createSubViews
{
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = COLORRGB(0xffffff);
    [self.view addSubview:_headerView];
    
    _timeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _timeImage.image = IMG(@"tiny_clock");
    [_headerView addSubview:_timeImage];
    
    _timeLabel = [UILabel labelWithFrame:CGRectZero
                                   color:COLORRGB(0x000000)
                                    font:HSFONT(12)
                                    text:@""
                               alignment:NSTextAlignmentLeft
                           numberOfLines:1];
    [_headerView addSubview:_timeLabel];
    
    _startImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _startImage.image = IMG(@"tiny_circle_green");
    [_headerView addSubview:_startImage];
    
    _startLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentLeft
                            numberOfLines:1];
    [_headerView addSubview:_startLabel];
    
    _endImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _endImage.image = IMG(@"tiny_circle_red");
    [_headerView addSubview:_endImage];
    
    _endLabel = [UILabel labelWithFrame:CGRectZero
                                  color:COLORRGB(0x000000)
                                   font:HSFONT(12)
                                   text:@""
                              alignment:NSTextAlignmentLeft
                          numberOfLines:1];
    [_headerView addSubview:_endLabel];
    
    _leftLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_leftLine];
    
    _successLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0xd7d7d7)
                                       font:HSFONT(12)
                                       text:@"成功支付"
                                  alignment:NSTextAlignmentCenter
                              numberOfLines:1];
    [self.view addSubview:_successLabel];
    
    _rightLine = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rightLine.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_rightLine];
    
    _carStyleLabel = [UILabel labelWithFrame:CGRectZero
                                       color:COLORRGB(0x000000)
                                        font:HSFONT(12)
                                        text:@""
                                   alignment:NSTextAlignmentCenter
                               numberOfLines:1];
    [self.view addSubview:_carStyleLabel];
    
    _priceLabel = [UILabel labelWithFrame:CGRectZero
                                    color:COLORRGB(0x000000)
                                     font:HSFONT(12)
                                     text:@""
                                alignment:NSTextAlignmentCenter
                            numberOfLines:1];
    [self.view addSubview:_priceLabel];
    
    _detailImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _detailImage.image = IMG(@"tiny_history");
    _detailImage.userInteractionEnabled = YES;
    [self.view addSubview:_detailImage];
    
    _detailButton = [UIButton buttonWithImageName:@""
                                      hlImageName:@""
                                            title:@"查看明细"
                                       titleColor:COLORRGB(0x000000)
                                             font:HSFONT(12)
                                       onTapBlock:^(UIButton *btn) {
                                           [self didClickDetailButtonAction];
                                       }];
    [self.view addSubview:_detailButton];
    
    _leftLine2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftLine2.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_leftLine2];
    
    _impressLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0xd7d7d7)
                                       font:HSFONT(12)
                                       text:@"描述我对他(她)的印象"
                                  alignment:NSTextAlignmentCenter
                              numberOfLines:1];
    [self.view addSubview:_impressLabel];
    
    _rightLine2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rightLine2.backgroundColor = COLORRGB(0xd7d7d7);
    [self.view addSubview:_rightLine2];
    
    _commentImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _commentImage.image = IMG(@"tiny_history");
    _commentImage.userInteractionEnabled = YES;
    [self.view addSubview:_commentImage];
    
    _commentButton = [UIButton buttonWithImageName:@""
                                       hlImageName:@""
                                             title:@"添加印象"
                                        titleColor:COLORRGB(0x000000)
                                              font:HSFONT(12)
                                        onTapBlock:^(UIButton *btn) {
                                            [self didClickCommentButtonAction];
                                        }];
    [self.view addSubview:_commentButton];
    
    _estimateLabel = [UILabel labelWithFrame:CGRectZero
                                       color:COLORRGB(0x000000)
                                        font:HSFONT(12)
                                        text:@""
                                   alignment:NSTextAlignmentCenter
                               numberOfLines:1];
    [self.view addSubview:_estimateLabel];
    
    _shareImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _shareImage.userInteractionEnabled = YES;
    _shareImage.layer.masksToBounds = YES;
    [self.view addSubview:_shareImage];
    
    _shareButton = [UIButton buttonWithImageName:@""
                                     hlImageName:@""
                                           title:@"代金券"
                                      titleColor:COLORRGB(0x000000)
                                            font:HSFONT(12)
                                      onTapBlock:^(UIButton *btn) {
                                          
                                      }];
    [self.view addSubview:_shareButton];
    [self calculateFrame];
}

- (void)setData
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.orderInfo.startTimeStr floatValue]];
    _timeLabel.text = [date displayWithFormat:@"yyyy-M-d H:mm"];
    _startLabel.text = self.orderInfo.star_loc_str;
    _endLabel.text = self.orderInfo.dest_loc_str;
    
    CarModel *carInfo = [[CarModel alloc] initWithCarStyle:self.orderInfo.car_style];
    _carStyleLabel.text = carInfo.car_style_name;
    
    NSString *price = @"9";
    _priceLabel.text = [NSString stringWithFormat:@"%@元",price];
    NSString *mostComment = @"驾驶平稳";
    NSString *personalComment = @"";
    if ([personalComment isEqualToString:@""]) {
        _estimateLabel.text = [NSString stringWithFormat:@"大多数人对他(她)的印象是:%@",mostComment];
    } else {
        _estimateLabel.text = personalComment;
    }
}

- (void)calculateFrame
{
    [self setData];
    _timeImage.frame = ccr(10, 10, 16, 16);
    CGSize timeSize = [self getTextFromLabel:_timeLabel];
    _timeLabel.frame = ccr(CGRectGetMaxX(_timeImage.frame)+10,
                           _timeImage.origin.y-(_timeImage.height-_timeLabel.height)/2,
                           timeSize.width,
                           20);
    _startImage.frame = ccr(_timeImage.origin.x,
                            CGRectGetMaxY(_timeImage.frame)+10,
                            _timeImage.width,
                            _timeImage.height);
    CGSize startSize = [self getTextFromLabel:_startLabel];
    _startLabel.frame = ccr(_timeLabel.origin.x,
                            _startImage.origin.y-(_startImage.height-_startLabel.height)/2,
                            startSize.width,
                            20);
    _endImage.frame = ccr(_startImage.origin.x,
                          CGRectGetMaxY(_startImage.frame)+10,
                          _startImage.width,
                          _startImage.height);
    CGSize endSize = [self getTextFromLabel:_endLabel];
    _endLabel.frame = ccr(_startLabel.origin.x,
                          _endImage.origin.y-(_endImage.height-_endLabel.height)/2,
                          endSize.width,
                          20);
    _headerView.frame = ccr(0,
                            NAV_BAR_HEIGHT_IOS7,
                            SCREEN_WIDTH,
                            CGRectGetMaxY(_endLabel.frame)+10);

    CGSize successSize = [self getTextFromLabel:_successLabel];
    CGFloat lineLength = (SCREEN_WIDTH-successSize.width-5*2)/4;
    _leftLine.frame = ccr(lineLength,
                          CGRectGetMaxY(_headerView.frame)+10+(successSize
                          .height-0.5)/2,
                          lineLength,
                          0.5);
    _successLabel.frame = ccr(CGRectGetMaxX(_leftLine.frame)+5,
                              CGRectGetMaxY(_headerView.frame)+10,
                              successSize.width,
                              successSize.height);
    _rightLine.frame = ccr(CGRectGetMaxX(_successLabel.frame)+5,
                           _leftLine.origin.y,
                           _leftLine.width,
                           _leftLine.height);
    
    _carStyleLabel.frame = ccr((SCREEN_WIDTH-[self getTextFromLabel:_carStyleLabel].width)/2,
                               CGRectGetMaxY(_successLabel.frame)+25,
                               [self getTextFromLabel:_carStyleLabel].width,
                               [self getTextFromLabel:_carStyleLabel].height);
    
    NSString *price = _priceLabel.text;
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
    NSUInteger priceLength = price.length-1;
    [priceString addAttributes:@{NSFontAttributeName:HSFONT(20)}
                         range:NSMakeRange(0, priceLength)];
    _priceLabel.attributedText = priceString;
    CGSize priceSize = [self getTextFromLabel:_priceLabel];
    _priceLabel.frame = ccr((SCREEN_WIDTH-priceSize.width)/2,
                            CGRectGetMaxY(_carStyleLabel.frame)+10,
                            priceSize.width,
                            priceSize.height);
    CGSize detailSize = [self getTextFromLabel:_detailButton.titleLabel];
    _detailImage.frame = ccr((SCREEN_WIDTH-detailSize.width-16)/2,
                             CGRectGetMaxY(_priceLabel.frame)+10,
                             16,
                             16);
    _detailButton.frame = ccr(CGRectGetMaxX(_detailImage.frame),
                              _detailImage.origin.y+1,
                              detailSize.width,
                              detailSize.height);
    CGSize impressSize = [self getTextFromLabel:_impressLabel];
    CGFloat lineLength2 = (SCREEN_WIDTH-impressSize.width-5*2)/4;
    _leftLine2.frame = ccr(lineLength2,
                           CGRectGetMaxY(_detailButton.frame)+50+
                           (impressSize.height-0.5)/2,
                           lineLength2, 0.5);
    _impressLabel.frame = ccr(CGRectGetMaxX(_leftLine2.frame)+5,
                              CGRectGetMaxY(_detailButton.frame)+50,
                              impressSize.width,
                              impressSize.height);
    _rightLine2.frame = ccr(CGRectGetMaxX(_impressLabel.frame)+5,
                            _leftLine2.origin.y,
                            _leftLine2.width,
                            _leftLine2.height);
    CGSize commentSize = [self getTextFromLabel:_commentButton.titleLabel];
    _commentImage.frame = ccr(_detailImage.origin.x,
                              CGRectGetMaxY(_impressLabel.frame)+20,
                              16,
                              16);
    _commentButton.frame = ccr(CGRectGetMaxX(_commentImage.frame),
                               _commentImage.origin.y+1,
                               commentSize.width,
                               commentSize.height);
    CGSize estimateSize = [self getTextFromLabel:_estimateLabel];
    _estimateLabel.frame = ccr((SCREEN_WIDTH-estimateSize.width)/2,
                               CGRectGetMaxY(_commentButton.frame)+10,
                               estimateSize.width,
                               estimateSize.height);
    _shareImage.frame = ccr((SCREEN_WIDTH-50)/2,
                            SCREEN_HEIGHT-50-10,
                            50,
                            50);
    _shareImage.layer.cornerRadius = _shareImage.width/2;
    _shareButton.frame = _shareImage.frame;
    _shareButton.layer.cornerRadius = _shareButton.width/2;
}

#pragma mark - click event

- (void)didClickDetailButtonAction
{
    CheckDetailVC *checkDetailVC = [[CheckDetailVC alloc] init];
    checkDetailVC.title = @"查看明细";
    [self.navigationController pushViewController:checkDetailVC animated:YES];
}

- (void)didClickCommentButtonAction
{
    CommentVC *commentVC = [[CommentVC alloc] init];
    commentVC.title = @"添加印象";
    commentVC.delegate = self;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (CGSize)getTextFromLabel:(UILabel *)label
{
    CGSize textSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label sizeToFit];
    return textSize;
}

#pragma mark - CommentVC delegate

- (void)didClickSubmitButtonWithComment:(NSString *)comment
{
    _estimateLabel.text = comment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
