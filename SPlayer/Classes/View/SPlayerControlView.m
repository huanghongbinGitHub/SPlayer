//
//  SPlayerControlView.m
//  SPlayer
//
//  Created by sh on 2021/11/8.
//

#import "SPlayerControlView.h"

@interface SPlayerControlView()


@end

@implementation SPlayerControlView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.playBtn];
        [self addSubview:self.playBackBtn];
        [self addSubview:self.playForwardBtn];
        [self addSubview:self.playSlider];
    }
    return self;
}

- (UIButton *)playForwardBtn{
    if (!_playForwardBtn) {
        _playForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"快进"];
        [_playForwardBtn setImage:image forState:UIControlStateNormal];
        _playForwardBtn.bounds = CGRectMake(0, 0, image.size.width * 0.7f, image.size.height * 0.7f);
        _playForwardBtn.center = CGPointMake(self.center.x + 50, self.center.y);
        [_playForwardBtn addTarget:self action:@selector(playForward:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playForwardBtn;
}

- (UIButton *)playBackBtn{
    if (!_playBackBtn) {
        _playBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"倒退"];
        [_playBackBtn setImage:image forState:UIControlStateNormal];
        _playBackBtn.bounds = CGRectMake(0, 0, image.size.width * 0.7f, image.size.height * 0.7f);
        _playBackBtn.center = CGPointMake(self.center.x - 50, self.center.y);
        [_playBackBtn addTarget:self action:@selector(playBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBackBtn;
}

- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _playBtn.bounds = CGRectMake(0, 0, 250, 40);
        _playBtn.center = self.center;
        //        _playBtn.backgroundColor = kSystemYellowEFCE17Color;
//        _playBtn.layer.cornerRadius = 20;
//        _playBtn.layer.masksToBounds = YES;
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //        [_playBtn setTitle:Locstr(@"开始") forState:UIControlStateNormal];
        //        [_playBtn setTitleColor:RKWhiteColor forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"播放"];
        [_playBtn setImage:image forState:UIControlStateNormal];
        _playBtn.bounds = CGRectMake(0, 0, image.size.width * 0.7f, image.size.height * 0.7f);
        [_playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)setState:(SUPlayerState)state{
    _state = state;
    NSLog(@"state %@",@(state));
    if (state == SUPlayerStatePaused) {
        [self.playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    }
    else if (state == SUPlayerStatePlaying){
        [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}


-(SPlayerSlider *)playSlider
{
    if(!_playSlider){
        _playSlider = [[SPlayerSlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 20 - 14, self.frame.size.width - 40, 20)];
        //已经划过的进度条
        [_playSlider setMinimumTrackImage:[UIImage imageNamed:@"pic_progressbar_n_171x3_"] forState:UIControlStateNormal];
        // 滑块颜色
        _playSlider.thumbTintColor = [UIColor yellowColor];
        // 通常状态下
        [_playSlider setThumbImage:[UIImage imageNamed:@"player_full_slider_iphone_12x15_"] forState:UIControlStateNormal];
        // 滑动状态下
        [_playSlider setThumbImage:[UIImage imageNamed:@"player_full_slider_iphone_12x15_"] forState:UIControlStateHighlighted];
        
        // slider开始滑动事件
        [_playSlider addTarget:self action:@selector(videoSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_playSlider addTarget:self action:@selector(videoSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_playSlider addTarget:self action:@selector(videoSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        //        _playSlider.alpha = 0;
        //        _playSlider.backgroundColor = [UIColor redColor];
    }
    return _playSlider;
}

- (void)videoSliderTouchBegan:(UISlider *)slider{
    NSLog(@"videoSliderTouchBegan");
    self.sliding = YES;
}

- (void)videoSliderValueChanged:(UISlider *)slider{
    NSLog(@"videoSliderValueChanged");
}

- (void)videoSliderTouchEnded:(UISlider *)slider{
    NSLog(@"videoSliderTouchEnded");
    if (self.playSliderToValue) {
        self.playSliderToValue(slider.value);
    }
}

- (void)play:(UIButton *)sender{
    if (self.play) {
        self.play();
    }
}


- (void)playForward:(UIButton *)sender{
//    self.sliding = YES;
    if (self.playForward) {
        self.playForward(5.0f);
    }
}

- (void)playBack:(UIButton *)sender{
//    self.sliding = YES;
    if (self.playBack) {
        self.playBack(5.0f);
    }
}

@end
