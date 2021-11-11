//
//  ResourceLoader.m
//  SPlayer
//
//  Created by 小黄 on 2021/11/10.
//

#import "ResourceLoader.h"

@implementation ResourceLoader

+ (UIImage *)loadImageByName:(NSString *)name{
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imagefailName = [NSString stringWithFormat:@"%@@%zdx.png",name,scale];
    NSString *imagePath = [currentBundle pathForResource:imagefailName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",@"SPlayer"]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
