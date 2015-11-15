//
//  NSData+Additions.m
//  KickOffIOS
//
//  Created by Zhicheng Wei on 9/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "NSData+Additions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Additions)

- (NSData *)MD5Value
{
	unsigned char bytes[CC_MD5_DIGEST_LENGTH];
	CC_MD5([self bytes], (int)[self length], bytes);
	return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}

- (NSString *)hexify
{
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
	
    if (!dataBuffer)
        return [NSString string];
	
    NSUInteger       len        = [self length];
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(len * 2)];
	
    for (int i = 0; i < len; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx",
								 (unsigned long)dataBuffer[i]]];
	
    return [NSString stringWithString:hexString];
}

@end
