//
//  ZBCStarRating.m
//  ZBCool
//
//  Created by Passerbied on 5/29/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCStarRating.h"

@implementation ZBCStarRating

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.starImage = [UIImage imageNamed:@"gn_icon_scoreinput"];
        self.starHighlightedImage = [UIImage imageNamed:@"gn_icon_scoreinput_sl"];
        self.horizontalMargin = 0;
        self.maxRating = 5.0;
        self.editable = YES;
        self.displayMode=EDStarRatingDisplayFull;
        [self  setNeedsDisplay];
    }
    return self;
}

@end
