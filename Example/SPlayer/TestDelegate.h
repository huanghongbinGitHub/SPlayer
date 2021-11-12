//
//  TestDelegate.h
//  SPlayer_Example
//
//  Created by 小黄 on 2021/11/11.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Tdelegate <NSObject>

- (void)log;

@end

@interface TestDelegate : NSObject

@property (nonatomic, weak) id<Tdelegate> delegate;

@end

NS_ASSUME_NONNULL_END
