
#define ADD(__x__, __y__) [__x__ stringByAppendingString:__y__]

#if 0
#define BASE_URL                        @"http://101.201.145.241:81"

#else
#warning is testing
#define BASE_URL                        @"http://101.201.145.241:81"

#endif

#define KEY_STORE_SERVICE               @"duduacauntservice"
#define KEY_STORE_ADMIN                 @"admin"
#define KEY_STORE_USERID                @"userid"
#define KEY_STORE_PASSWORD              @"password"
#define KEY_STORE_ACCESS_TOKEN          @"accesstoken"

//APIs

//请求验证码，并取得token
#define LOGIN_SEND_VER_CODE(telephone)          [NSString stringWithFormat:@"/login/send-ver-code?user_telephone=%@",telephone]

//登陆用户
#define LOGIN_NEW_LOGIN(telephone,verCode)      [NSString stringWithFormat:@"/login/new-login?user_telephone=%@&verCode=%@",telephone,verCode]

//向短信服务注册手机
#define LOGIN_REGEDIT(telephone)        [NSString stringWithFormat:@"/login/regedit?user_telephone=%@",telephone]

//请求服务器发送验证码（参数：token）：弃用
#define LOGIN_SET_MOBILE(telephone)     [NSString stringWithFormat:@"/login/set-mobile-phone-number=%lld",telephone]

//用户端版本检查并返回车型列表（参数：APP名称，用于标记APP平台）
#define ECK_VERSION                     @"/exam/eck-version?app_name=dudu-ios"

//初次绑定手机	（参数：token，verCode）：弃用
#define PHONE_SMS(vercode)              [NSString stringWithFormat:@"/login/phone-sms?verCode=%d",vercode]

//重复绑定手机(参数：telephone，verCode，token)：弃用
#define LOGIN_WITH_SMS_CODE(telephone,verCode) [NSString stringWithFormat:@"/login/login-with-sms-code?user_telephone=%lld&verCode=%ld",telephone,verCode]

//获取用户基本信息（参数：token）
#define TOKEN_LOGIN                     @"/login/token-login"

//检索用户所有的优惠券(参数：user_id,token)
#define USER_COUPON_INFO                @"/user/user-coupon-info"

//检索所有的历史订单(参数：causer_id,token)
#define USER_ORDER_INFO                 @"/user/user-order-info"

//查询当前订单详情(参数：user_id,token,order_id)
#define FLUSH_ORDER_STATUS(order_id)    [NSString stringWithFormat:@"/order/flush-order-status?order_id=%ld",order_id]

//取消当前订单	(参数：user_id,token,order_id)
#define CANCEL_ORDER(order_id)          [NSString stringWithFormat:@"/order/cancel-order?order_id=%@",order_id]

//用户下单(参数：lat lng是坐标, car_style是车型Id，startTimeType(0,现在乘车， 1预约) , startTimeStr预约的时间搓（无论是现在还是预约都要传，服务器要用）,est_distance预计里程（可选）)
#define ADD_ORDER(start_lat, start_lng, starLocStr, dest_lat, dest_lng, dest_loc_str, car_style, startTimeType, startTimeStr)  [NSString stringWithFormat:@"/order/add-order?start_lat=%@&start_lng=%@&starLocStr=%@&dest_lat=%@&dest_lng=%@&dest_loc_str=%@&car_style=%@&startTimeType=%@&startTimeStr=%@",start_lat, start_lng, starLocStr, dest_lat, dest_lng, dest_loc_str, car_style, startTimeType, startTimeStr]

//修改订单（参数：car_style_id, order_id）
#define ORDER_CHANGE_ORDER_CAR_STYLE(order_id,car_style_id) [NSString stringWithFormat:@"/order/change-order-car-style?order_id=%@&car_style_id=%@",order_id,car_style_id]

//评星
#define ORDER_EVALUATE(evaluate_level, order_id)        [NSString stringWithFormat:@"/order/evaluate?evaluate_level=%d&order_id=%@",evaluate_level, order_id]

//发票
#define BOOK_ORDER_LIST(page)                 [NSString stringWithFormat:@"book-order-list?page=%d",page]

//检查更新（返回车型列表）
#define CHECK_VERSION                   @"/exam/check-version"

//Umeng
#define UM_APP_KEY                      @""

//Jpush key
#define JPUSH_Key                       @"d31c0b7595c24685d3e1fafa"

//Agreement

//AboutUs

//AppStore
#define APPSTORE_URL                    @""
#define RATE_URL                        @""

//微信
#define Weixin_App_ID                   @"wx3141b44ce382fb8c"
#define Weixin_App_Secret               @"3a3570fca9d350e015b304fc19e4a5e2"
#define Weixin_RedirectUrl              ADD(BASE_URL,@"auth/weixin/callback")

//高徳MAP_KEY
#define AMAP_KEY @"d42442167ce54d6fe790fdb161bb96f6"

//腾讯地图KEY
#define QMAP_KEY @"U5CBZ-HLOW5-JYJI2-QKN2Z-SZJGH-5WBSP"





