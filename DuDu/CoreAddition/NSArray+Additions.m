//
//  NSArray+Additions.m
//  KickOffIOS
//
//  Created by Zhicheng Wei on 9/12/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//


/* from here 
 http://troybrant.net/blog/2010/02/adding-firstobject-to-nsarray/
 */

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (id)firstObject
{
    if ([self count] > 0)
		{
        return [self objectAtIndex:0];
		}
    return nil;
}

@end
