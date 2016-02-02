//
//  CarModel.h
//  DuDu
//
//  Created by i-chou on 12/31/15.
//  Copyright © 2015 i-chou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CarModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *car_style_name;
@property (nonatomic, strong) NSNumber *car_style_id;
@property (nonatomic, assign) CGFloat  per_kilometer_money;
@property (nonatomic, assign) CGFloat  per_max_kilometer;
@property (nonatomic, assign) CGFloat  per_max_kilometer_money;
@property (nonatomic, assign) CGFloat  wait_time_money;
@property (nonatomic, assign) CGFloat  start_money;
@property (nonatomic, copy)  NSString  *night_service_times;

//- (id)initWithCarStyle:(NSNumber *)car_style_id;

@end
