//
//  ShareModel.h
//  DuDu
//
//  Created by i-chou on 1/21/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *weixin_pic;
@property (nonatomic, copy) NSString *weixin_title;
@property (nonatomic, copy) NSString *weixin_link;
@property (nonatomic, copy) NSNumber *wait_order_time; //本不该放在这，但接口图方便，只能这样了
@property (nonatomic, assign) double wait_order_time_seconds;

@end
