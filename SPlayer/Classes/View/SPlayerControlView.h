//
//  SPlayerControlView.h
//  SPlayer
//
//  Created by sh on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "SPlayerHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPlayerControlView : UIView

@property (nonatomic, assign) SUPlayerState state;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) SPlayerSlider *playSlider;

@property (nonatomic, strong) UIButton *playBackBtn;

@property (nonatomic, strong) UIButton *playForwardBtn;

@property (nonatomic, assign) BOOL sliding;

//@property (nonatomic, assign) BOOL
@property (nonatomic, copy) void (^playSliderToValue)(float value);

//@property (nonatomic, assign) BOOL
@property (nonatomic, copy) void (^playBack)(float value);

//@property (nonatomic, assign) BOOL
@property (nonatomic, copy) void (^playForward)(float value);

//@property (nonatomic, assign) BOOL
@property (nonatomic, copy) void (^play)(void);
@end

NS_ASSUME_NONNULL_END
