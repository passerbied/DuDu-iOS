//
//  Utils.h
//  Yuebanr
//
//  Created by Passerbied on 11/25/13.
//  Copyright (c) 2013 metasolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)getMyBundlePath1:(NSString *)filename;

+ (NSString*)emptyIfNull:(NSString *)string;

+ (NSString *)urlWithToken:(NSString *)href;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  过滤数字
 *
 *  @param string       字符串
 *  @return NSString    过滤后数字
 */
+ (NSString *)filterUnNumber:(NSString *)string;

/**
 *  检查是否打开推送通知
 */
+ (BOOL)remoteNotificationEnabled;

+ (NSDictionary *)testDicFrom:(NSString *)jsonName;

/**
 *  获取测试用Json文件的数组数据
 *
 *  @param jsonName json文件名
 *
 *  @return 测试数据
 */
+ (NSMutableArray *)testArrayFrom:(NSString *)jsonName;

+ (CGRect)getLabelRect:(UILabel *)label;

/**
 *  判断当前是否是夜间服务时段(22:00~05:00)
 *
 *
 *  @return BOOL
 */
+ (BOOL)checkNightService;

@end
