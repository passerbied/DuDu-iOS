//
//  BookModel.h
//  DuDu
//
//  Created by i-chou on 1/6/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property (nonatomic, copy) NSString *order_ids;
@property (nonatomic, copy) NSString *book_price;
@property (nonatomic, copy) NSString *book_title;
@property (nonatomic, copy) NSString *book_type;
@property (nonatomic, copy) NSString *book_receive_people;
@property (nonatomic, copy) NSString *book_reveive_tel;
@property (nonatomic, copy) NSString *book_receive_addr;

@end
