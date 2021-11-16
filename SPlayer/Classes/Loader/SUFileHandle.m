//
//  SUFileHandle.m
//  SULoader
//
//  Created by 万众科技 on 16/6/28.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "SUFileHandle.h"
#import "NSString+SULoader.h"

@interface SUFileHandle ()

@property (nonatomic, strong) NSFileHandle * writeFileHandle;
@property (nonatomic, strong) NSFileHandle * readFileHandle;

@end

@implementation SUFileHandle

+ (BOOL)createTempFileWithUrl:(NSURL *)url withLoaderAddress:(NSString *)loader{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString *fileNameNoFormate = [NSString fileNameNoFileFormatWithURL:url];
    fileNameNoFormate = [NSString stringWithFormat:@"%@%@",loader,fileNameNoFormate];
    NSString * path = [NSString tempFilePathWtihFileName:fileNameNoFormate];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}

+ (BOOL)createTempFileWithUrl:(NSURL *)url {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString *fileNameNoFormate = [NSString fileNameNoFileFormatWithURL:url];
    NSString * path = [NSString tempFilePathWtihFileName:fileNameNoFormate];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}

+ (BOOL)createTempFile {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSString tempFilePath];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}

+ (void)writeTempFileData:(NSData *)data withFilePath:(NSString *)path {
    NSLog(@"缓存写入 %@ 长度 %@",path,@(data.length));
    NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle seekToEndOfFile];   //跳到文件末尾
    [handle writeData:data];
}

+ (void)writeTempFileData:(NSData *)data {
    NSLog(@"临时目录 ： %@",[NSString tempFilePath]);
    NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:[NSString tempFilePath]];
    [handle seekToEndOfFile];   //跳到文件末尾
    [handle writeData:data];
}

+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length withFilePath:(NSString *)path {
    NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:path];
//    NSLog(@" ==== %@",[NSString tempFilePath]);
    [handle seekToFileOffset:offset];
    return [handle readDataOfLength:length];
}

+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length {
    NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:[NSString tempFilePath]];
    NSLog(@" ==== %@",[NSString tempFilePath]);
    [handle seekToFileOffset:offset];
    return [handle readDataOfLength:length];
}

+ (void)cacheTempFileWithFileName:(NSString *)name withSourcePath:(NSString *)path{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * cacheFolderPath = [NSString cacheFolderPath];
    if (![manager fileExistsAtPath:cacheFolderPath]) {
        [manager createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", cacheFolderPath, name];
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:path toPath:cacheFilePath error:nil];
    NSLog(@"cache file : %@", success ? @"success" : @"fail");
//    [manager removeItemAtPath:path error:nil];
}

+ (void)cacheTempFileWithFileName:(NSString *)name {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * cacheFolderPath = [NSString cacheFolderPath];
    if (![manager fileExistsAtPath:cacheFolderPath]) {
        [manager createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", cacheFolderPath, name];
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:[NSString tempFilePath] toPath:cacheFilePath error:nil];
    NSLog(@"cache file : %@", success ? @"success" : @"fail");
}

+ (NSString *)cacheFileExistsWithURL:(NSURL *)url {
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", [NSString cacheFolderPath], [NSString fileNameWithURL:url]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        return cacheFilePath;
    }
    return nil;
}

+ (BOOL)clearCache {
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:[NSString cacheFolderPath] error:nil];
}

@end
