//
//  SURequestTask.m
//  SULoader
//
//  Created by 万众科技 on 16/6/28.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "SURequestTask.h"


@interface SURequestTask ()<NSURLConnectionDataDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession * session;              //会话对象
@property (nonatomic, strong) NSURLSessionDataTask * task;         //任务

@end

@implementation SURequestTask

- (instancetype)init {
    if (self = [super init]) {
        [SUFileHandle createTempFile];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url{
    if (self = [super init]) {
       BOOL b = [SUFileHandle createTempFileWithUrl:url];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url withBasePath:(NSString *)path{
    if (self = [super init]) {
        self.loaderAddress = path;
       BOOL b = [SUFileHandle createTempFileWithUrl:url withLoaderAddress:path];
    }
    return self;
}

- (void)setRequestURL:(NSURL *)requestURL{
    _requestURL = requestURL;
    NSString *fileNoFormateName = [NSString fileNameNoFileFormatWithURL:requestURL];
    self.fileName = fileNoFormateName;
    NSString *fileCachePath = [NSString stringWithFormat:@"%@%@",self.loaderAddress,fileNoFormateName];
    [self setFileCachePath:[NSString tempFilePathWtihFileName:fileCachePath]];
}


- (void)start {
    NSLog(@"开始一次新的请求");
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self.requestURL originalSchemeURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:RequestTimeout];    //转换成正常的url
    if (self.requestOffset > 0) {
        [request addValue:[NSString stringWithFormat:@"bytes=%ld-%ld", self.requestOffset, self.fileLength - 1] forHTTPHeaderField:@"Range"];
        NSLog(@"开始一次新的请求,%@",[request valueForHTTPHeaderField:@"Range"]);
    }
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:request];
    [self.task resume];
}

- (void)setCancel:(BOOL)cancel {
    _cancel = cancel;
    [self.task cancel];
    [self.session invalidateAndCancel];
}

#pragma mark - NSURLSessionDataDelegate
//服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    if (self.cancel) return;
//    NSLog(@"服务器响应 response: %@",response);
    completionHandler(NSURLSessionResponseAllow);
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    NSString * contentRange = [[httpResponse allHeaderFields] objectForKey:@"Content-Range"];
    NSString * fileLength = [[contentRange componentsSeparatedByString:@"/"] lastObject];
    self.fileLength = fileLength.integerValue > 0 ? fileLength.integerValue : response.expectedContentLength;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidReceiveResponse)]) {
        [self.delegate requestTaskDidReceiveResponse];
    }
}

//服务器返回数据 可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    if (self.cancel) return;
    if (self.fileCachePath) {
        [SUFileHandle writeTempFileData:data withFilePath:self.fileCachePath];
    }
    self.cacheLength += data.length;
//    NSLog(@"服务器返回数据 %@,%@",@(self.cacheLength),@(data.length));
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidUpdateCache)]) {
        [self.delegate requestTaskDidUpdateCache];
    }
}

//请求完成会调用该方法，请求失败则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//    NSLog(@"服务器请求完成或者失败");
    if (self.cancel) {
//        NSLog(@"下载取消");
    }else {
        if (error) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFailWithError:)]) {
                [self.delegate requestTaskDidFailWithError:error];
            }
        }else {
            //可以缓存则保存文件
            if (self.cache) {
//                [SUFileHandle cacheTempFileWithFileName:[NSString fileNameWithURL:self.requestURL]];
                [SUFileHandle cacheTempFileWithFileName:[NSString fileNameWithURL:self.requestURL] withSourcePath:self.fileCachePath];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFinishLoadingWithCache:)]) {
                [self.delegate requestTaskDidFinishLoadingWithCache:self.cache];
            }
        }
    }
}

@end
