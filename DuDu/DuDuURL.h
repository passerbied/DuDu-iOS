
#define ADD(__x__, __y__) [__x__ stringByAppendingString:__y__]

#if 0
#define BASE_URL                        @"http://"

#else
#warning is testing
#define BASE_URL                        @"http://dev"

#endif

#define KEY_STORE_SERVICE               @"duduacauntservice"
#define KEY_STORE_ADMIN                 @"admin"
#define KEY_STORE_USERID                @"userid"
#define KEY_STORE_PASSWORD              @"password"
#define KEY_STORE_ACCESS_TOKEN          @"accesstoken"

//Version
#define UPDATE                          @"version/update"

//Umeng
#define UM_APP_KEY                      @""

//Jpush key
#define JPUSH_Key                       @""

//Agreement

//AboutUs

//AppStore
#define APPSTORE_URL                    @""
#define RATE_URL                        @""

//微信
#define Weixin_App_ID                   @""
#define Weixin_App_Secret               @""
#define Weixin_RedirectUrl              ADD(BASE_URL,@"auth/weixin/callback")

//MAP_KEY
#define MAP_KEY @"d42442167ce54d6fe790fdb161bb96f6"




