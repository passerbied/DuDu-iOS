//
//  CarStore.m
//  DuDu
//
//  Created by i-chou on 1/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "CarStore.h"
#import "MainViewController.h"

@implementation CarStore

+ (instancetype)sharedCarStore
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedCarStore = nil;
    dispatch_once(&pred, ^{
        _sharedCarStore = [[self alloc] init];
    });
    return _sharedCarStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.cars = [NSMutableArray array];
    }
    return self;
}

- (NSString *)getCarStyleNameForCarStyleID:(NSNumber *)number
{
    for (CarModel *car in [MainViewController sharedMainViewController].carStyles) {
        if ([car.car_style_id intValue] == [number intValue]) {
            return car.car_style_name;
        }
    }
    return @"未知车型";
}

@end
