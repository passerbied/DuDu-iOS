//
//  DuDuAPIClient.m
//  DuDu
//
//  Created by i-chou on 12/20/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "DuDuAPIClient.h"
#import "ZBCProgressHUD.h"

@implementation DuDuAPIClient

+ (instancetype)sharedClient {
    static DuDuAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
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

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                [self showErrorMessage:error.localizedDescription];
                NSLog(@"%@",error.localizedDescription);
                failure(task, error);
            }
        } else {
            if (success) {
                NSDictionary *dic = [DuDuAPIClient parseJSONFrom:responseObject];
                if (dic && [dic[@"err"] integerValue] > 0) { //err > 0 -> 返回操作错误信息
                    if ([dic[@"err"] integerValue] == 2) { // err == 2 -> 认证失败，清token
                        [UICKeyChainStore removeAllItemsForService:KEY_STORE_SERVICE];
                    }
                    [self showErrorMessage:dic[@"info"]];
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

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                [self showErrorMessage:error];
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
                [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
                
            }
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"DELETE" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                [self showErrorMessage:error];
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
                [ZBCProgressHUD hideHUDForWindow:KEY_WINDOW animated:NO];
                
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
