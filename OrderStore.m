//
//  OrderStore.m
//  DuDu
//
//  Created by i-chou on 1/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "OrderStore.h"

@implementation OrderStore

+ (instancetype)sharedOrderStore
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedOrderStore = nil;
    dispatch_once(&pred, ^{
        _sharedOrderStore = [[self alloc] init];
    });
    return _sharedOrderStore;
}

- (id)init
{
    return [super init];
}

@end
