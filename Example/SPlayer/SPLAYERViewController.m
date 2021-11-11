//
//  SPLAYERViewController.m
//  SPlayer
//
//  Created by levine_hhb@163.com on 11/10/2021.
//  Copyright (c) 2021 levine_hhb@163.com. All rights reserved.
//

#import "SPLAYERViewController.h"
#import <SUPlayer.h>

@interface SPLAYERViewController ()

@property (nonatomic, strong)SUPlayer *player;
@property (nonatomic, strong)SUPlayer *player1;
@property (nonatomic, strong)SUPlayer *player2;

@end

@implementation SPLAYERViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ed554c11-0557-4c48-ad11-d3d4af80cdb8.mp4",
        @"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/ad924e7e-195d-47c5-ba8c-823ab674533cw1920h1080.mp4"
        ,@"http://roki.oss-cn-hangzhou.aliyuncs.com/cookbook/video/step/4e1808f5-02ad-4dbd-8241-df1c8c4b8d1ew720h960.mp4"
    ];
    CGFloat x = 0;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
