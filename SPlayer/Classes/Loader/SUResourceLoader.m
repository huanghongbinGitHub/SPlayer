//
//  SULoader.m
//  SULoader
//
//  Created by 万众科技 on 16/6/24.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "SUResourceLoader.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SUResourceLoader ()

@property (nonatomic, strong) NSMutableArray * requestList;
@property (nonatomic, strong) SURequestTask * requestTask;

@end

@implementation SUResourceLoader

- (instancetype)init {
    if (self = [super init]) {
        self.requestList = [NSMutableArray array];
    }
    return self;
}

- (void)stopLoading {
    self.requestTask.cancel = YES;
}

#pragma mark - AVAssetResourceLoaderDelegate

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"1、来自播放器的回调");
    NSLog(@"WaitingLoadingRequest < requestedOffset = %lld, currentOffset = %lld, requestedLength = %ld >", loadingRequest.dataRequest.requestedOffset, loadingRequest.dataRequest.currentOffset, loadingRequest.dataRequest.requestedLength);
    [self addLoadingRequest:loadingRequest];
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"CancelLoadingRequest  < requestedOffset = %lld, currentOffset = %lld, requestedLength = %ld >", loadingRequest.dataRequest.requestedOffset, loadingRequest.dataRequest.currentOffset, loadingRequest.dataRequest.requestedLength);
    [self removeLoadingRequest:loadingRequest];
}

#pragma mark - SURequestTaskDelegate
- (void)requestTaskDidUpdateCache {
    //在这里服务器返回数据，需要对请求进行再次处理
    NSLog(@"服务器返回数据，执行代理方法");
    [self processRequestList];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loader:cacheProgress:)]) {
        CGFloat cacheProgress = (CGFloat)self.requestTask.cacheLength / (self.requestTask.fileLength - self.requestTask.requestOffset);
        [self.delegate loader:self cacheProgress:cacheProgress];
    }
}

- (void)requestTaskDidFinishLoadingWithCache:(BOOL)cache {
    self.cacheFinished = cache;
}

- (void)requestTaskDidFailWithError:(NSError *)error {
    //加载数据错误的处理
    NSLog(@"cxcxcx");
}

#pragma mark - 处理LoadingRequest
- (void)addLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    //2、添加到List中，
    
    [self.requestList addObject:loadingRequest];
    NSLog(@"2、添加到List中，list。count%@",@(self.requestList.count));
    @synchronized(self) {
        if (self.requestTask) {
            if (loadingRequest.dataRequest.requestedOffset >= self.requestTask.requestOffset &&
                loadingRequest.dataRequest.requestedOffset <= self.requestTask.requestOffset + self.requestTask.cacheLength) {
                //数据已经缓存，则直接完成
                NSLog(@"数据已经缓存，则直接完成");
                [self processRequestList];
            }else {
                //数据还没缓存，则等待数据下载；如果是Seek操作，则重新请求
                if (self.seekRequired) {
                    NSLog(@"Seek操作，则重新请求");
                    [self newTaskWithLoadingRequest:loadingRequest cache:NO];
                }
            }
        }else {
            [self newTaskWithLoadingRequest:loadingRequest cache:YES];
        }
    }
}

- (void)newTaskWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest cache:(BOOL)cache {
    NSLog(@" === %@",loadingRequest.request.URL);
    NSUInteger fileLength = 0;
    if (self.requestTask) {
        fileLength = self.requestTask.fileLength;
        self.requestTask.cancel = YES;
    }
    NSString *address = [NSString stringWithFormat:@"%@",self];
    self.requestTask = [[SURequestTask alloc] initWithUrl:loadingRequest.request.URL withBasePath:address];
//    self.requestTask = [[SURequestTask alloc] init];
    self.requestTask.requestURL = loadingRequest.request.URL;
    self.requestTask.requestOffset = loadingRequest.dataRequest.requestedOffset;
    self.requestTask.cache = cache;
    if (fileLength > 0) {
        self.requestTask.fileLength = fileLength;
    }
    self.requestTask.delegate = self;
    [self.requestTask start];
    self.seekRequired = NO;
}

- (void)removeLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.requestList removeObject:loadingRequest];
}

- (void)processRequestList {
    NSMutableArray * finishRequestList = [NSMutableArray array];
    NSLog(@"服务器返回数据，执行代理方法，执行代理方法的子方法  %@",@(self.requestList.count));
    for (AVAssetResourceLoadingRequest * loadingRequest in self.requestList) {
        if ([self finishLoadingWithLoadingRequest:loadingRequest]) {
            [finishRequestList addObject:loadingRequest];
        }
    }
    [self.requestList removeObjectsInArray:finishRequestList];
}

- (BOOL)finishLoadingWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"填充数据");
    //填充信息
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(MimeType), NULL);
    loadingRequest.contentInformationRequest.contentType = CFBridgingRelease(contentType);
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    loadingRequest.contentInformationRequest.contentLength = self.requestTask.fileLength;
    
    //读文件，填充数据
    NSUInteger cacheLength = self.requestTask.cacheLength;
    NSUInteger requestedOffset = loadingRequest.dataRequest.requestedOffset;
    if (loadingRequest.dataRequest.currentOffset != 0) {
        requestedOffset = loadingRequest.dataRequest.currentOffset;
    }
    NSUInteger canReadLength = cacheLength - (requestedOffset - self.requestTask.requestOffset);
    NSUInteger respondLength = MIN(canReadLength, loadingRequest.dataRequest.requestedLength);
    
//    NSLog(@"cacheLength %ld, requestedOffset %lld, currentOffset %lld, canReadLength %ld, requestedLength %ld", cacheLength, loadingRequest.dataRequest.requestedOffset, loadingRequest.dataRequest.currentOffset,canReadLength, loadingRequest.dataRequest.requestedLength);
    
//    [loadingRequest.dataRequest respondWithData:[SUFileHandle readTempFileDataWithOffset:requestedOffset - self.requestTask.requestOffset length:respondLength ]];
    
    [loadingRequest.dataRequest respondWithData:[SUFileHandle readTempFileDataWithOffset:requestedOffset - self.requestTask.requestOffset length:respondLength withFilePath:self.requestTask.fileCachePath]];
    
    //如果完全响应了所需要的数据，则完成
    NSUInteger nowendOffset = requestedOffset + canReadLength;
    NSUInteger reqEndOffset = loadingRequest.dataRequest.requestedOffset + loadingRequest.dataRequest.requestedLength;
    if (nowendOffset >= reqEndOffset) {
        [loadingRequest finishLoading];
        return YES;
    }
    return NO;
}

@end
