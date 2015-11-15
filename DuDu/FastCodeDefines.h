#ifndef __FastCodeDefines__
#define __FastCodeDefines__

// fast make
#define ccp(__X__,__Y__)             CGPointMake(__X__,__Y__)
#define ccs(__W__,__H__)             CGSizeMake(__W__,__H__)
#define ccr(__X__,__Y__,__W__,__H__) CGRectMake(__X__,__Y__,__W__,__H__)


// fast creation
#define IMG(name)       [UIImage imageNamed:[NSString stringWithFormat:@"%@",(name)]]
#define IMG_VIEW(name)  [[UIImageView alloc] initWithImage:[UIImage imageNamed:(name)]]
#define LocalStr(key)   NSLocalizedString(key,key)
//#define FONT(size)      [UIFont systemFontOfSize:(size)]
//#define FONT(s)      [UIFont fontWithName:@"Arial" size:(s)]
#define HSFONT(s)      [UIFont systemFontOfSize:(s)]//[UIFont fontWithName:@"HiraginoSansGB-W3" size:(s)]
#define BFONT(size)     [UIFont boldSystemFontOfSize:(size)]
#define BUNDLE(name)    [[NSBundle mainBundle] pathForResource:(name)]
#define URL(url)        [NSURL URLWithString:(url)]

//filter array
#define FILTER(array,where) [(array) filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:(where)]]

//filter link
#define LINKS_HREF(links,rel)   FILTER(links, @"rel = '" rel "'").count ? (FILTER(links, @"rel = '" rel "'")[0][@"href"]):@""

//iOS_Version
#define IS_IOS7 ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1))

//Device Version
#define IS_BETTER_THAN_IPHONE_4S [[UIScreen mainScreen] bounds].size.height > 500.0
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)568 ) < DBL_EPSILON)

// Components size
#define SCREEN_SCALE         ([[UIScreen mainScreen] bounds].size.width/320)
//#define SCREEN_HEIGHT_SCALE        [[UIScreen mainScreen] bounds].size.height/960
#define SCREEN_WIDTH         [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT        [[UIScreen mainScreen] bounds].size.height
#define NAV_BAR_HEIGHT       44
#define NAV_BAR_HEIGHT_IOS7  64
#define NAV_BAR_HEIGHT_PLUS  93
#define TOOL_BAR_HEIGHT      44
#define TAB_BAR_HEIGHT       49
#define STATUS_BAR_HEIGHT    20

//key window
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

// current language
#define CN 1
#define ENG 2
#define JAN 3

/* color helper */
#define COLORRGBA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0	\
green:((c>>8)&0xFF)/255.0	\
blue:(c&0xFF)/255.0         \
alpha:a]
#define COLORRGB(c)    [UIColor colorWithRed:((c>>16)&0xFF)/255.0	\
                                         green:((c>>8)&0xFF)/255.0	\
                                         blue:(c&0xFF)/255.0         \
                                         alpha:1.0]

/* log helper */
#define LOG_STR(str)     NSLog(@"%@", str)
#define LOG_INT(int)     NSLog(@"%d", int)
#define LOG_FLOAT(float) NSLog(@"%f", float)
#define LOG_ERROR(exception,reason) NSLog(@"function:%s | line:%d | exception:%@ | reason:%@",__func__, __LINE__,exception,reason)

/* string format helper */
#define STR_STR(str)     [NSString stringWithFormat:@"%@",str]
#define STR_D(double)     [NSString stringWithFormat:@"%d",double]
#define STR_F(float)     [NSString stringWithFormat:@"%.1f",float]
#define STR_I(int)     [NSString stringWithFormat:@"%d",int]

#define kDateFormat  @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z"
#define bDateFormat  @"yyyy'-'MM'-'dd"

#endif /* __FastCodeDefines __*/


