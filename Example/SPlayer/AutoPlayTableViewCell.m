//
//  AutoPlayTableViewCell.m
//  SPlayer_Example
//
//  Created by 小黄 on 2021/11/11.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#import "AutoPlayTableViewCell.h"
#import "Constant.h"




@implementation AutoPlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _identify = reuseIdentifier;
    }
    return self;
}

- (void)configPlayerWithUrl:(NSString *)url{
//    self.player = [[SUPlayer alloc] initWithURL:[NSURL URLWithString:url]];
//    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.rectInSuper.size.width - 20, 290)];
//    self.player.back = view;
//    self.player.skin = YES;
//    [self.contentView addSubview:view];
    
    self.player = [[SUPlayer alloc] initWithURL:[NSURL URLWithString:url] withFrame:CGRectMake(10, 0, self.rectInSuper.size.width - 20, 290)];
    [self.player setSkin:YES];
    [self.player addToSuperView:self.contentView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint point;
    id contentOfSet = [change objectForKey:@"new"];
    [contentOfSet getValue:&point];
    
//    [self isInRectOfHeight:400 atContentOfSet:point];
    [self pauseAtOutOfWindowWithWindowHeight:800 withContentOfSet:point];
}


/**
 notice：The starting value of the offset could be negative
 */
- (void)pauseAtOutOfWindowWithWindowHeight:(CGFloat)height withContentOfSet:(CGPoint)offset{
    if (self.rectInSuper.origin.y + self.rectInSuper.size.height < offset.y) {
        //pause
        if (self.player.state == SUPlayerStatePlaying) {
            [self.player pause];
        }
    }
    if (self.rectInSuper.origin.y > offset.y + height) {
        //pause
        if (self.player.state == SUPlayerStatePlaying) {
            [self.player pause];
        }
    }
    
}


/*
    当此cell处于屏幕上方 y0~yx的范围内，
 */
- (void)isInRectOfHeight:(CGFloat)height atContentOfSet:(CGPoint)ofset{
    /*
    这里应该 判断
    1、当前cell的y 大于 contentofset.y : 当前cell的起点在展示内
    2、当前cell的终点，即 y+height 小于  contentofset.y + contentsize.height (展示框的终点)
     */
    if (ofset.y + 92 <= self.rectInSuper.origin.y && self.rectInSuper.origin.y + self.rectInSuper.size.height <= ofset.y + 92 + height ) {
        //判断cell是否在window的0~400的高度范围内
        NSLog(@" 当前展示的 %@",self.identify);
        self.backgroundColor = [UIColor redColor];
    }
//        else{
//        self.backgroundColor = randomColor;
//    }
}


//- (void)dealloc{
//    NSLog(@"cell dealloc");
//}


@end
