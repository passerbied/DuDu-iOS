//
//  ZBCStarRatingView.m
//  ZBCool
//
//  Created by Passerbied on 5/6/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import "ZBCStarRatingView.h"

@implementation ZBCStarRatingView
{
    EDStarRating *_starRating;
    UILabel *_ratingValueLabel;
    UIImageView *_backgroundView;
    UILabel *_valueLabel;
}

- (id)initWithFrame:(CGRect)frame withRateValue:(float)value
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _backgroundView = [[UIImageView alloc] initWithFrame:ccr(
                                                                 0,
                                                                 0,
                                                                 frame.size.width,
                                                                 frame.size.height
                                                                 )];
        _backgroundView.image = self.backbroundImage;
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.userInteractionEnabled = YES;
        
        [self addSubview:_backgroundView];
        
        _starRating = [[EDStarRating alloc] initWithFrame:ccr(
                                                              0,
                                                              0,
                                                              frame.size.width-50,
                                                              frame.size.height
                                                              )];
        _starRating.backgroundColor = [UIColor clearColor];
        _starRating.rating = value/2;
        _starRating.starImage = [UIImage imageNamed:@"gn_icon_scoreinput"];
        _starRating.starHighlightedImage = [UIImage imageNamed:@"gn_icon_scoreinput_sl"];
        _starRating.maxRating = 5.0;
        _starRating.horizontalMargin = 0;
        _starRating.editable=YES;
        _starRating.displayMode=EDStarRatingDisplayHalf;
        _starRating.delegate = self;
        [_starRating  setNeedsDisplay];
        
        [_backgroundView addSubview:_starRating];
        
        _ratingValueLabel = [[UILabel alloc] initWithFrame:ccr(
                                                               CGRectGetMaxX(_starRating.frame),
                                                               0,
                                                               40,
                                                               frame.size.height
                                                               )];
        _ratingValueLabel.backgroundColor = [UIColor clearColor];
        _ratingValueLabel.text = [NSString stringWithFormat:@"%.1f",value];
        _ratingValueLabel.font = HSFONT(18);
        _ratingValueLabel.textAlignment = NSTextAlignmentCenter;
        _ratingValueLabel.textColor = COLORRGB(0xffa700);
        
        [_backgroundView addSubview:_ratingValueLabel];
    }
    
    return self;
}


- (void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    if ([self.delegate respondsToSelector:@selector(didStarRatingValueChanged:)]) {
        [self.delegate didStarRatingValueChanged:rating*2];
    }
    
    self.ratingValue = rating*2;
    
    _ratingValueLabel.text = STR_F(self.ratingValue);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
