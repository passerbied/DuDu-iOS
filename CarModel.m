//
//  CarModel.m
//  DuDu
//
//  Created by i-chou on 12/31/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"car_style_id"            : @"car_style_id",
             @"car_style_name"          : @"car_style_name",
             @"per_kilometer_money"     : @"per_kilometer_money",
             @"per_max_kilometer"       : @"per_max_kilometer",
             @"per_max_kilometer_money" : @"per_max_kilometer_money",
             @"wait_time_money"         : @"wait_time_money",
             @"start_money"             : @"start_money"
             };
}

+ (NSString *)managedObjectEntityName {
    return @"CarModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}


@end
