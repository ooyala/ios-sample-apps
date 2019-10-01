/**
 * @class      OOPlayer OOPlayer.h "OOPlayer.h"
 * @brief      OOPlayer
 * @details    OOPlayer.h in OoyalaSDK
 * @date       12/14/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"
#import "OOAudioTrackSelectionProtocol.h"
#import "OOPlaybackSpeedSelectionProtocol.h"

#ifndef OOPlayer_h
#define OOPlayer_h

@class OOOoyalaError;

// really, an Abstract class.
@interface OOPlayer : NSObject <OOPlayerProtocol, OOLifeCycle,
                                OOAudioTrackSelectionProtocol, OOPlaybackSpeedSelectionProtocol> {
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

@end

#endif /* OOPlayer_h */
