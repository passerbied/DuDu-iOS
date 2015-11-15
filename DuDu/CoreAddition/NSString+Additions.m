//
//  NSString+Additions.m
//  KickOffIOS
//
//  Created by Zhicheng Wei on 9/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)trim
{
		return[self stringByTrimmingCharactersInSet:
			   [NSCharacterSet characterSetWithCharactersInString:@" \t\n"]];
}

@end
