//
//  ResourceLoader.h
//  SPlayer
//
//  Created by 小黄 on 2021/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceLoader : NSObject

+ (UIImage *)loadImageByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
