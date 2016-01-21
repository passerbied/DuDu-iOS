//
//  adModel.h
//  DuDu
//
//  Created by i-chou on 1/22/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *advertisement_id;
@property (nonatomic, copy) NSString *advertisement_name;
@property (nonatomic, copy) NSString *advertisement_url;
@property (nonatomic, copy) NSNumber *advertisement_status;
@property (nonatomic, copy) NSString *advertisement_add_time;

@end
