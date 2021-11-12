//
//  PlayUIViewController.m
//  SPlayer_Example
//
//  Created by 小黄 on 2021/11/11.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#import "PlayUIViewController.h"
#import <SUPlayer.h>

@interface PlayUIViewController ()


@property (nonatomic, strong)SUPlayer *player;
@property (nonatomic, strong)SUPlayer *player1;
@property (nonatomic, strong)SUPlayer *player2;

@end

@implementation PlayUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"自动播放" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 30, 30);
    
    NSArray *array = @[
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ed554c11-0557-4c48-ad11-d3d4af80cdb8.mp4",
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ad924e7e-195d-47c5-ba8c-823ab674533cw1920h1080.mp4"
        ,@"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/4e1808f5-02ad-4dbd-8241-df1c8c4b8d1ew720h960.mp4"
    ];
    CGFloat x = 30;
    for (int i = 0; i < array.count; i++) {
        SUPlayer *player = [[SUPlayer alloc] initWithURL:[NSURL URLWithString:array[i]]];
        player.skin = YES;
//        AVPlayerLayer *layer = [AVPlayerLayer
        UIView *view ;
        if (i == 2) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, x,240, 320)];
            x += 330;
        }else if(i == 1){
            view = [[UIView alloc] initWithFrame:CGRectMake(0, x, 414, 1080 * 414 / 1920)];
            x += (1080 * 414.0f / 1920.0f);
            x += 10;
        }
        
        else if(i == 0){
            view = [[UIView alloc] initWithFrame:CGRectMake(0, x,414, 250)];
            x += 310;
        }
        
        [self.view addSubview:view];
        player.back = view;

        if (i == 0) {
            self.player = player;
            [self.player play];
        }else if(i == 1){
            self.player1 = player;
//            [self.player1 play];
        }else if(i == 2){
            self.player2 = player;
//            [self.player2 play];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
