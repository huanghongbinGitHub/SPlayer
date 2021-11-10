//
//  SUFileHandle.h
//  SULoader
//
//  Created by 万众科技 on 16/6/28.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SULoaderCategory.h"
#import "NSURL+SULoader.h"

@interface SUFileHandle : NSObject


+ (BOOL)createTempFileWithUrl:(NSURL *)url;
/**
 *  创建临时文件
 */
+ (BOOL)createTempFile;




+ (void)writeTempFileData:(NSData *)data withFilePath:(NSString *)path;

/**
 *  往临时文件写入数据
 */
+ (void)writeTempFileData:(NSData *)data;



+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length withFilePath:(NSString *)path;

/**
 *  读取临时文件数据
 */
+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length;



+ (void)cacheTempFileWithFileName:(NSString *)name withSourcePath:(NSString *)path;
/**
 *  保存临时文件到缓存文件夹
 */

+ (void)cacheTempFileWithFileName:(NSString *)name;

/**
 *  是否存在缓存文件 存在：返回文件路径 不存在：返回nil
 */
+ (NSString *)cacheFileExistsWithURL:(NSURL *)url;

/**
 *  清空缓存文件
 */
+ (BOOL)clearCache;

@end
