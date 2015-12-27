//
//  UserModel.h
//  DuDu
//
//  Created by i-chou on 12/21/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) NSNumber *user_id;
@property (nonatomic, assign) NSString *avator;

@end