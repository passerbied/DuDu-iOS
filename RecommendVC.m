//
//  RecommendVC.m
//  DuDu
//
//  Created by 教路浩 on 15/12/2.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "RecommendVC.h"
#import "CouponStore.h"

@interface RecommendVC ()

@end

@implementation RecommendVC
{
    UILabel *_couponlabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(0xffffff);
    [self createSubViews];
}

- (void)createSubViews
{
    UIView *couponView = [[UIView alloc] initWithFrame:ccr(0, NAV_BAR_HEIGHT_IOS7, SCREEN_WIDTH, 200)];
    couponView.backgroundColor = COLORRGB(0xf0f0f0);
    [self.view addSubview:couponView];
    _couponlabel = [UILabel labelWithFrame:ccr((SCREEN_WIDTH-200)/2,
                                               (couponView.height-50)/2,
                                               200,
                                               50)
                                     color:COLORRGB(0x000000)
                                      font:HSFONT(20)
                                      text:@"加载中..."
                                 alignment:NSTextAlignmentCenter
                             numberOfLines:1];
    _couponlabel.backgroundColor = [UIColor clearColor];
    _couponlabel.layer.borderColor = COLORRGB(0xf39a00).CGColor;
    _couponlabel.layer.borderWidth = 1.0f;
    [couponView addSubview:_couponlabel];
    
    UIButton *shareButton = [UIButton buttonWithImageName:@""
                                              hlImageName:@""
                                                    title:@"分享至微信朋友圈"
                                               titleColor:COLORRGB(0xf39a00)
                                                     font:HSFONT(15)
                                               onTapBlock:^(UIButton *btn) {
                                                   [self shareCoupon];
                                               }];
    shareButton.frame = ccr((SCREEN_WIDTH-150)/2, SCREEN_HEIGHT-100-50, 150, 50);
    shareButton.backgroundColor = COLORRGB(0xf0f0f0);
    [self.view addSubview:shareButton];
    
    [self setData];
}

- (void)setData
{
    self.share_coupon = @"优惠券";
    self.share_title = [CouponStore sharedCouponStore].shareInfo.weixin_title;
    self.share_desc = [CouponStore sharedCouponStore].shareInfo.weixin_title;
    self.share_link = [CouponStore sharedCouponStore].shareInfo.weixin_link;
    self.share_thumb = [CouponStore sharedCouponStore].shareInfo.weixin_pic;
    _couponlabel.text = self.share_coupon;
}

- (void)shareCoupon
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:IMG(self.share_thumb)];
    message.title = self.share_title;
    message.description = self.share_desc;
    
    
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.share_link;
    message.mediaObject = webObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

//- (void)onReq:(BaseReq *)req
//{
//    NSLog(@"onReq======= openID:%@; type:%d",req.openID,req.type);
//}
//
//- (void)onResp:(BaseResp *)resp
//{
//    NSLog(@"onResp========== errCode:%d; err:%@; type:%d",resp.errCode,resp.errStr,resp.type);
//    
//    if (resp.errCode) {
//        [ZBCToast showMessage:resp.errStr];
//    } else {
//        
//        [[DuDuAPIClient sharedClient] GET:SHARE parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//        }];
//    }
//    
//}

@end
