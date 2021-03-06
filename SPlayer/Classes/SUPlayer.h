//
//  SUPlayer.h
//  SULoader
//
//  Created by 万众科技 on 16/6/24.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUResourceLoader.h"
#import <UIKit/UIKit.h>
#import "SPlayerHeader.h"


@interface SUPlayer : NSObject<SULoaderDelegate>

@property (nonatomic, assign) SUPlayerState state;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, assign) CGFloat cacheProgress;

@property (nonatomic, strong) UIView *back;

//Whether or not skin is included
@property (nonatomic, assign) BOOL skin;

@property (nonatomic, assign) BOOL muted;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) SkinType type;   //show {slider，forward，back}
/**
 *  初始化方法，url：歌曲的网络地址或者本地地址
 */
- (instancetype)initWithURL:(NSURL *)url;


- (instancetype)initWithURL:(NSURL *)url withFrame:(CGRect)frame;


- (void)addToSuperView:(UIView *)view;

/**
 *  播放下一首歌曲，url：歌曲的网络地址或者本地地址
 *  逻辑：stop -> replace -> play
 */
- (void)replaceItemWithURL:(NSURL *)url;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;

/**
 *  停止
 */
- (void)stop;

/**
 *  正在播放
 */
- (BOOL)isPlaying;

/**
 *  跳到某个时间进度
 */
- (void)seekToTime:(CGFloat)seconds;

/**
 *  当前歌曲缓存情况 YES：已缓存  NO：未缓存（seek过的歌曲都不会缓存）
 */
- (BOOL)currentItemCacheState;

/**
 *  当前歌曲缓存文件完整路径
 */
- (NSString *)currentItemCacheFilePath;

/**
 *  清除缓存
 */
+ (BOOL)clearCache;


- (void)removeObserver;

@end
