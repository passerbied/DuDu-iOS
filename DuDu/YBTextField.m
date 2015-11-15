//
//  YBTextField.m
//  Yuebanr
//
//  Created by i-chou on 6/26/13.
//  Copyright (c) 2013 metasolo. All rights reserved.
//

#import "YBTextField.h"

@implementation YBTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetAlpha(context, 0.3);

    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:self.font}];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGSize size = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect inset = ccr((bounds.size.width -size.width)/2, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}


@end
