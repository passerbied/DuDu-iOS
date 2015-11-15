//
//  NSObject+Additions.m
//  KickOffIOS
//
//  Created by Zhicheng Wei on 9/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "NSObject+Additions.h"
#include <objc/runtime.h>


@implementation NSObject (Additions)

- (void)exchangeMethodFrom:(SEL)oldSEL to:(SEL)newSEL
{
	Method oldMethod = class_getInstanceMethod([self class], oldSEL);
    Method newMethod = class_getInstanceMethod([self class], newSEL);
	method_exchangeImplementations(oldMethod, newMethod);
}


@end
