//
//  ZBCStarRatingView.h
//  ZBCool
//
//  Created by Passerbied on 5/6/14.
//  Copyright (c) 2014 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@protocol ZBCStarRatingViewDelegate;

@interface ZBCStarRatingView : UIView <EDStarRatingProtocol>

@property (nonatomic, assign) float ratingValue;

@property (nonatomic, strong) UIImage *backbroundImage;

@property (nonatomic,strong) NSObject<ZBCStarRatingViewDelegate> *delegate;

- (id)initWithFrame:(CGRect)frame withRateValue:(float)value;

@end

@protocol ZBCStarRatingViewDelegate <NSObject>

@optional

- (void)didStarRatingValueChanged:(float)value;

@end
