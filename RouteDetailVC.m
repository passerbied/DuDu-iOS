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
    UIImageView *_avatarImage;
    UIButton    *_avatarButton;
    UILabel     *_screenNameLabel;
    UILabel     *_carNumberLabel;
    UILabel     *_carTypeLabel;
    UILabel     *_carColorLabel;
    UIImageView *_phoneImage;
    UIButton    *_phoneButton;
    UIImageView *_leftLine;
    UILabel     *_successLabel;
    UIImageView *_rightLine;
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
    _avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _avatarImage.backgroundColor = COLORRGB(0xcccccc);
    _avatarImage.userInteractionEnabled = YES;
    _avatarImage.layer.masksToBounds = YES;
    [self.view addSubview:_avatarImage];
    
    _avatarButton = [UIButton buttonWithImageName:@""
                                      hlImageName:@""
                                       onTapBlock:^(UIButton *btn) {
                                           
                                       }];
    _avatarButton.frame = _avatarImage.frame;
    _avatarButton.layer.masksToBounds = YES;
    [self.view addSubview:_avatarButton];
    
    _screenNameLabel = [UILabel labelWithFrame:CGRectZero
                                         color:COLORRGB(0x000000)
                                          font:HSFONT(12)
                                          text:@""
                                     alignment:NSTextAlignmentLeft
                                 numberOfLines:1];
    [self.view addSubview:_screenNameLabel];
    
    _carNumberLabel = [UILabel labelWithFrame:CGRectZero
                                        color:COLORRGB(0x000000)
                                         font:HSFONT(12)
                                         text:@""
                                    alignment:NSTextAlignmentLeft
                                numberOfLines:1];
    [self.view addSubview:_carNumberLabel];
    
    _carTypeLabel = [UILabel labelWithFrame:CGRectZero
                                      color:COLORRGB(0x000000)
                                       font:HSFONT(12)
                                       text:@""
                                  alignment:NSTextAlignmentLeft
                              numberOfLines:1];
    [self.view addSubview:_carTypeLabel];
    
    _carColorLabel = [UILabel labelWithFrame:CGRectZero
                                       color:COLORRGB(0x000000)
                                        font:HSFONT(12)
                                        text:@""
                                   alignment:NSTextAlignmentLeft
                               numberOfLines:1];
    [self.view addSubview:_carColorLabel];
    
    _phoneImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _phoneImage.userInteractionEnabled = YES;
    _phoneImage.layer.masksToBounds = YES;
    [self.view addSubview:_phoneImage];
    
    _phoneButton = [UIButton buttonWithImageName:@""
                                     hlImageName:@""
                                      onTapBlock:^(UIButton *btn) {
                                          
                                      }];
    _phoneButton.frame = _phoneImage.frame;
    _phoneButton.layer.masksToBounds = YES;
    [self.view addSubview:_phoneButton];
    
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
    _avatarImage.image = IMG(@"account");
    _screenNameLabel.text = @"天空海豹";
    _carNumberLabel.text = @"辽***26Q";
    _carTypeLabel.text = @"长城";
    _carColorLabel.text = @"白色";
    _phoneImage.image = nil;
    _phoneImage.backgroundColor = [UIColor redColor];
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
    _avatarImage.frame = ccr(10, NAV_BAR_HEIGHT_IOS7+10, 50, 50);
    _avatarImage.layer.cornerRadius = _avatarImage.width/2;
    _avatarButton.frame = _avatarImage.frame;
    _avatarButton.layer.cornerRadius = _avatarButton.width/2;
    CGSize screenSize = [self getTextFromLabel:_screenNameLabel];
    CGFloat gap = (50-screenSize.height*2)/3;
    _screenNameLabel.frame = ccr(CGRectGetMaxX(_avatarImage.frame)+10,
                                 NAV_BAR_HEIGHT_IOS7+10+gap,
                                 screenSize.width,
                                 screenSize.height);
    CGSize numberSize = [self getTextFromLabel:_carNumberLabel];
    _carNumberLabel.frame = ccr(_screenNameLabel.origin.x,
                                CGRectGetMaxY(_screenNameLabel.frame)+gap,
                                numberSize.width,
                                numberSize.height);
    CGSize typeSize = [self getTextFromLabel:_carTypeLabel];
    _carTypeLabel.frame = ccr(CGRectGetMaxX(_carNumberLabel.frame)+5,
                              _carNumberLabel.origin.y,
                              typeSize.width,
                              typeSize.height);
    CGSize colorSize = [self getTextFromLabel:_carColorLabel];
    _carColorLabel.frame = ccr(CGRectGetMaxX(_carTypeLabel.frame)+5,
                               _carTypeLabel.origin.y,
                               colorSize.width,
                               colorSize.height);
    _phoneImage.frame = ccr(SCREEN_WIDTH-40-30,
                            NAV_BAR_HEIGHT_IOS7+15,
                            40,
                            40);
    _phoneImage.layer.cornerRadius = _phoneImage.width/2;
    _phoneButton.frame = _phoneButton.frame;
    _phoneButton.layer.cornerRadius = _phoneButton.width/2;
    CGSize successSize = [self getTextFromLabel:_successLabel];
    CGFloat lineLength = (SCREEN_WIDTH-successSize.width-5*2)/4;
    _leftLine.frame = ccr(lineLength,
                          CGRectGetMaxY(_avatarImage.frame)+10+(successSize
                          .height-0.5)/2,
                          lineLength,
                          0.5);
    _successLabel.frame = ccr(CGRectGetMaxX(_leftLine.frame)+5,
                              CGRectGetMaxY(_avatarImage.frame)+10,
                              successSize.width,
                              successSize.height);
    _rightLine.frame = ccr(CGRectGetMaxX(_successLabel.frame)+5,
                           _leftLine.origin.y,
                           _leftLine.width,
                           _leftLine.height);
    NSString *price = _priceLabel.text;
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
    NSUInteger priceLength = price.length-1;
    [priceString addAttributes:@{NSFontAttributeName:HSFONT(20)}
                         range:NSMakeRange(0, priceLength)];
    _priceLabel.attributedText = priceString;
    CGSize priceSize = [self getTextFromLabel:_priceLabel];
    _priceLabel.frame = ccr((SCREEN_WIDTH-priceSize.width)/2,
                            CGRectGetMaxY(_successLabel.frame)+30,
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
