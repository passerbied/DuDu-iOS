//
//  UserModel.m
//  DuDu
//
//  Created by i-chou on 12/21/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"objectId" : @"objectId",
             @"name"     : @"name",
             @"token"    : @"token",
             @"mobile"   : @"mobile",
             @"user_id"  : @"user_id",
             };
}

+ (NSString *)managedObjectEntityName {
    return @"UserModel";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return nil;
}


@end
