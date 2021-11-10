//
//  NSString+SULoader.m
//  SULoader
//
//  Created by 万众科技 on 16/6/28.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "NSString+SULoader.h"

@implementation NSString (SULoader)

+ (NSString *)tempFilePathWtihFileName:(NSString *)name{
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",name]];
}

+ (NSString *)tempFilePath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"MusicTemp.mp4"];
}


+ (NSString *)cacheFolderPath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"MusicCaches"];
}

+ (NSString *)fileNameWithURL:(NSURL *)url {
    return [[url.path componentsSeparatedByString:@"/"] lastObject];
}

+ (NSString *)fileNameNoFileFormatWithURL:(NSURL *)url {
    NSString *fileName = [[url.path componentsSeparatedByString:@"/"] lastObject];
    if (fileName != nil) {
        return [[fileName componentsSeparatedByString:@"."] firstObject];
    }
    return nil;
}

@end
