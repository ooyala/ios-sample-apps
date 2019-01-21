/**
 * @class      OOPlayer OOPlayer.h "OOPlayer.h"
 * @brief      OOPlayer
 * @details    OOPlayer.h in OoyalaSDK
 * @date       12/14/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "OOOoyalaError.h"
#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"
#import "OOAudioTrackSelectionProtocol.h"
#import "OOPlaybackSpeedSelectionProtocol.h"

#ifndef OOPlayer_h
#define OOPlayer_h

@interface OOPlayer : NSObject<OOPlayerProtocol, OOLifeCycle, OOAudioTrackSelectionProtocol, OOPlaybackSpeedSelectionProtocol> { // really, an Abstract class.
@protected
  OOOoyalaError *playerError;
  UIView *view;
  BOOL completed;
  BOOL supportsVideoGravityButton;
}

extern NSString *const PlayerErrorNotification;

@property (nonatomic) Float64 playheadTime; /** KVO compatible playhead time */
@property (nonatomic, readonly) OOOoyalaError *playerError; /**< The OOPlayer's current error if it exists */
@property (nonatomic, readonly) UIView *view;
@property (nonatomic) BOOL completed;

- (BOOL)isPlaying;

- (BOOL)isAudioOnlyStreamPlaying;

- (CMTimeRange)seekableTimeRange;

- (CGRect)videoRect;

- (void)setState:(OOOoyalaPlayerState)state;

@end

#endif /* OOPlayer_h */
