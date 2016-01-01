//
//  OrderStore.h
//  DuDu
//
//  Created by i-chou on 1/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStore : NSObject

@property (nonatomic, strong) NSArray *history;
@property (nonatomic, strong) NSDictionary *ing;

+ (instancetype)sharedOrderStore;

@end
