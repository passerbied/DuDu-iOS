//
//  HitchhikeView.h
//  DuDu
//
//  Created by i-chou on 2/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HitchhikeViewDelegate;

@interface HitchhikeView : UIView

@property (nonatomic, strong) id<HitchhikeViewDelegate> delegate;

@property (nonatomic, strong) UILabel *startLocationLabel;
@property (nonatomic, strong) UILabel *destLocationLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *peopleCountLabel;

//- (void)setStartLocation:(NSString *)start_location;
//- (void)setDestLocation:(NSString *)dest_location;
//- (void)setStartTime:(NSString *)start_time;
//- (void)setPeopleCount:(NSString *)people_count;

@end

@protocol HitchhikeViewDelegate <NSObject>

- (void)hitchhikeView:(HitchhikeView *)hitchhikeView didTapped:(UILabel *)label;

@end