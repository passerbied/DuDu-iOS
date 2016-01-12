//
//  DuDuAPIClient.m
//  DuDu
//
//  Created by i-chou on 12/20/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "DuDuAPIClient.h"
#import "ZBCProgressHUD.h"
#import "APService.h"
#import "DuDuJSONResponseSerializer.h"

@implementation DuDuAPIClient

+ (instancetype)sharedClient {
    static DuDuAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //对成功请求返回的err>0的情况，封装到failure分支下处理。
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    return _sharedClient;
}

- (void)showErrorMessage:(NSString *)message
{
    [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
    [ZBCProgressHUD showCompleteHUD:NO
                          labelText:@""
                   detailsLabelText:[Utils emptyIfNull:message]
                           animated:YES
                            desView:KEY_WINDOW.rootViewController.view];
}

//- (void)showErrorMessage:(NSDictionary *)dic
//{
//    NSString *message;
//    //收到认证错误，删除本地Token
//    if ([dic[@"err"] intValue] == 2) {
//        [UICKeyChainStore removeAllItems];
//    }
//    
//    message = dic[@"order_info"]?dic[@"order_info"]:dic[@"info"];
//    
//    [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
//    [ZBCProgressHUD showCompleteHUD:NO
//                          labelText:@""
//                   detailsLabelText:[Utils emptyIfNull:message]
//                           animated:YES
//                            desView:KEY_WINDOW.rootViewController.view];
//}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZBCProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:[Utils urlWithToken:URLString] relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
        if (error) {
            if (failure) {
//                [self showErrorMessage:error.localizedDescription];
                NSLog(@"%@",error.localizedDescription);
                failure(task, error);
            }
        } else {
            if (success) {
                NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
                if (dic && [dic[@"err"] integerValue] > 0 && [dic[@"err"] integerValue] != 5 && [dic[@"err"] integerValue] != 11 && [dic[@"err"] integerValue] != 12 && [dic[@"err"] integerValue] != 17) { //err > 0 -> 返回操作错误信息, 5->优惠券不可用,11->有未完成的订单, 12->司机也没有其他合适的车辆, 17->没有当前的车型,但是有其他的车型可选
                    //                    if ([dic[@"err"] integerValue] == 2) { // err == 2 -> 认证失败，清token，解除JPUSH绑定
                    //                        [UICKeyChainStore removeAllItems];
                    //                        [APService setTags:[NSSet setWithObjects:@"dudu_ios", nil]
                    //                                     alias:@"-1"
                    //                          callbackSelector:nil
                    //                                    object:self];
                    //                    }
                    if (dic[@"order_info"]) {
                        [self showErrorMessage:dic[@"order_info"]];
                    } else {
                        [self showErrorMessage:dic[@"info"]];
                    }
                    failure(task, error);
                } else {
                    success(task, responseObject);
                    [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
                }
            }
        }
    }];
    
    [task resume];
    
    return task;
}

//- (NSURLSessionDataTask *)GET:(NSString *)URLString
//                   parameters:(id)parameters
//                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
//{
////    [ZBCProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:[Utils urlWithToken:URLString] relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
//    
//    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
//        if (error) {
//            if (failure) {
//                [self showErrorMessage:error];
//                failure(task, error);
//            }
//        } else {
//            if (success) {
//                NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
//                
//                if (dic && ([dic[@"err"] integerValue] > 0 && [dic[@"err"] integerValue] != 5 && [dic[@"err"] integerValue] != 11 && [dic[@"err"] integerValue] != 12 && [dic[@"err"] integerValue] != 17)){
//                    [self showErrorMessage:error];
//                    failure(task, error);
//                } else {
//                    success(task, responseObject);
//                }
//            }
//        }
//    }];
//    
//    [task resume];
//    
//    return task;
//}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      jsonData:(NSData *)jsonData
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:nil error:nil];
    request.HTTPBody = jsonData;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
                
            }
        }
    }];
    
    [task resume];
    
    return task;
}

+ (id)parseJSONFrom:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return nil;
}

+ (id)parseArrayFrom:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return nil;
}


@end
