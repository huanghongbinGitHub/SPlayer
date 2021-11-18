//
//  SPlayerHeader.h
//  SPlayer
//
//  Created by 小黄 on 2021/11/8.
//

#ifndef SPlayerHeader_h
#define SPlayerHeader_h


#endif /* SPlayerHeader_h */


typedef NS_ENUM(NSInteger, SUPlayerState) {
    SUPlayerStateWaiting,
    SUPlayerStatePlaying,
    SUPlayerStatePaused,
    SUPlayerStateStopped,
    SUPlayerStateBuffering,
    SUPlayerStateError
};


typedef enum : NSInteger {
    SkinTypeWithAllView,
    SkinTypeWithOnlyPlayBtn

}SkinType;


#import "SPlayerSlider.h"
