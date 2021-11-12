//
//  AutoPlayTableViewCell.h
//  SPlayer_Example
//
//  Created by 小黄 on 2021/11/11.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SUPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoPlayTableViewCell : UITableViewCell

@property (nonatomic, retain) NSString *identify;   

@property (nonatomic, assign) CGRect displayRect;

@property (nonatomic, assign) CGRect rectInSuper;

- (void)configPlayerWithUrl:(NSString *)url;

@property (nonatomic, strong) SUPlayer *player;

@end

NS_ASSUME_NONNULL_END
