//
//  DuDuJSONResponseSerializer.h
//  DuDu
//
//  Created by 教路浩 on 15/12/17.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

static NSString * const JSONResponseSerializerWithBodyKey = @"statusCode";

@interface DuDuJSONResponseSerializer : AFJSONResponseSerializer

@end
