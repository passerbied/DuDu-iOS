//
//  CarStore.m
//  DuDu
//
//  Created by i-chou on 1/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "CarStore.h"

@implementation CarStore

- (id)init
{
    self = [super init];
    if (self) {
        self.cars = [NSMutableArray array];
    }
    return self;
}

@end
