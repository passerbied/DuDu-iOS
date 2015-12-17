//
//  DuDuJSONResponseSerializer.m
//  DuDu
//
//  Created by 教路浩 on 15/12/17.
//  Copyright © 2015年 i-chou. All rights reserved.
//

#import "DuDuJSONResponseSerializer.h"

@implementation DuDuJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error]; // may mutate `error`
    if (*error != nil) {
        NSError *err;
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableLeaves
                                                              error:&err];
        [userInfo setValue:dic forKey:JSONResponseSerializerWithDataKey];
        [userInfo setValue:[response valueForKey:JSONResponseSerializerWithBodyKey] forKey:JSONResponseSerializerWithBodyKey];
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        (*error) = newError;
    }
    
    return JSONObject;
    
}

@end
