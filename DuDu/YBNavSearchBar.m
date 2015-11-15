//
//  YBNavSearchBar.m
//  Yuebanr
//
//  Created by Passerbied on 1/6/14.
//  Copyright (c) 2014 metasolo. All rights reserved.
//

//#define LOCATION_WHIDTH 133
#define LOCATION_HEIGHT 30

#import "YBNavSearchBar.h"

@implementation YBNavSearchBar
{
    UIImageView *_locationBg;
}

static YBNavSearchBar* sharedInstance = nil;

+ (YBNavSearchBar *)sharedYBNavSearchBar {
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        sharedInstance = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _locationBg = [[UIImageView alloc] initWithImage:[IMG(@"topbar-input") stretchableImageWithLeftCapWidth:15 topCapHeight:20]];
        _locationBg.frame = ccr(0, 0, frame.size.width, frame.size.height);
        _locationBg.userInteractionEnabled = YES;
        [self addSubview:_locationBg];
        
        UIButton *clearBtn = [UIButton buttonWithImageName:@"icon-clear" hlImageName:@"icon-clear" onTapBlock:^(UIButton *btn){
            self.locationField.rightViewMode = UITextFieldViewModeNever;
            self.locationField.text = @"";
            if ([self.delegate respondsToSelector:@selector(doClear)]) {
                [self.delegate doClear];
            }
        }];
        self.locationField = [[UITextField alloc] initWithFrame:ccr(5, 0, frame.size.width-5, LOCATION_HEIGHT)];
        
        self.locationField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.locationField.textAlignment = NSTextAlignmentCenter;
        self.locationField.clearButtonMode = UITextFieldViewModeNever;
        self.locationField.rightViewMode = UITextFieldViewModeNever;
        self.locationField.rightView = clearBtn;
        self.locationField.font = HSFONT(15);
        self.locationField.textColor = COLORRGB(0xe6b5a9);
        self.locationField.returnKeyType = UIReturnKeyDone;
        self.locationField.backgroundColor = [UIColor clearColor];
        [_locationBg addSubview:self.locationField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _locationBg.frame = ccr(0, 0, self.frame.size.width, LOCATION_HEIGHT);
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
