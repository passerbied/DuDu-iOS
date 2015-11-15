//
//  Swizzle.h
//  youpinapp2-ios
//
//  Created by Wei Zhicheng on 5/9/12.
//  Copyright (c) 2012 FZXY. All rights reserved.
//

#ifndef __SWIZZLE_H__
#define __SWIZZLE_H__
#include <objc/runtime.h>

void 
Swizzle(Class c, SEL origSEL, SEL newSEL);


#endif /* __SWIZZLE_H__ */
