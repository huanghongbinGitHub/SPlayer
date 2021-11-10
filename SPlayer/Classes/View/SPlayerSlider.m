//
//  SPlayerSlider.m
//  SPlayer
//
//  Created by 小黄 on 2021/11/8.
//

#import "SPlayerSlider.h"

@interface SPlayerSlider()

@property (nonatomic, strong) UIImageView *thumbBackgroundImageView;

@end

@implementation SPlayerSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addSubview:self.thumbBackgroundImageView];
}

- (void)setThumbBackgroundImage:(UIImage *)thumbBackgroundImage {
    _thumbBackgroundImage = thumbBackgroundImage;
    self.thumbBackgroundImageView.image = thumbBackgroundImage;
}

// 获取滑动条上跟踪按钮的bounds
- (CGRect)thumbRect {
    return [self thumbRectForBounds:self.bounds
                                      trackRect:[self trackRectForBounds:self.bounds]
                                          value:self.value];
}

- (UIImageView *)thumbBackgroundImageView {
    
    if (!_thumbBackgroundImageView) {
        _thumbBackgroundImageView = [[UIImageView alloc] init];
    }
    return _thumbBackgroundImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.thumbBackgroundImageView.frame = (CGRect){{0,0},_thumbBackgroundImage.size};
    CGRect thumbRect = [self thumbRect];
    CGFloat centerX = thumbRect.origin.x+thumbRect.size.width*0.5;
    CGFloat centerY = thumbRect.origin.y+thumbRect.size.height*0.5;
    self.thumbBackgroundImageView.center = CGPointMake(centerX, centerY);
}

@end
