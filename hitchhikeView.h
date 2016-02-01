//
//  hitchhikeView.h
//  DuDu
//
//  Created by i-chou on 2/1/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hitchhikeView : UIView

- (void)setStartLocation:(NSString *)start_location;
- (void)setDestLocation:(NSString *)dest_location;
- (void)setStartTime:(NSString *)start_time;
- (void)setPeopleCount:(NSString *)people_count;

@end

@protocol hitchhikeViewDelegate <NSObject>

- (void)hitchhikeView:(hitchhikeView *)hitchhikeView didTapped:(UILabel *)label;

@end