//
//  NSObject+Additions.h
//  KickOffIOS
//
//  Created by Zhicheng Wei on 9/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Additions)

- (void)exchangeMethodFrom:(SEL)oldSEL to:(SEL)newSEL;

@end
