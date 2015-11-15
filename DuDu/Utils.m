//
//  Utils.m
//  Yuebanr
//
//  Created by Passerbied on 11/25/13.
//  Copyright (c) 2013 metasolo. All rights reserved.
//

#import "Utils.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath:MYBUNDLE_PATH]

@implementation Utils

+ (NSString *)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent :filename];
        return s;
    }
    return nil ;
}

+ (NSString*)emptyIfNull:(id)obj
{
    if([obj isKindOfClass:[NSNull class]]){
        return @"";
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj stringValue];
    }
    
    return obj?obj:@"";
}

//判断数字合法性
+ (BOOL)validateNumber:(NSString*)number {
    
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;

    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    
    return res;
}

//判断电话号码合法性
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1[3458]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}


+ (NSString *)filterUnNumber:(NSString *)string
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
}

+ (BOOL)remoteNotificationEnabled
{
    if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == 7 ||
        [[UIApplication sharedApplication] enabledRemoteNotificationTypes] == 15) {
        
        return YES;
    }
    return NO;
}

+ (NSDictionary *)testDicFrom:(NSString *)jsonName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableLeaves error:&err];
    return dic;
}

+ (NSMutableArray *)testArrayFrom:(NSString *)jsonName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    NSError *err;
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:&err];
    return arr;
}

@end
