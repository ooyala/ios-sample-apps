/**
 * @class      OOPlayer OOPlayer.h "OOPlayer.h"
 * @brief      OOPlayer
 * @details    OOPlayer.h in OoyalaSDK
 * @date       12/14/11
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "OOOoyalaPlayer.h"
#import "OOPlayerProtocol.h"
#import "OOLifeCycle.h"

@interface OOPlayer : NSObject<OOPlayerProtocol, OOLifeCycle> {
@protected
  NSString *error;
  UIView *view;
  BOOL completed;
}

extern NSString *const PlayerErrorNotification;

@property(nonatomic) Float64 playheadTime; /** KVO compatible playhead time */
@property(readonly, nonatomic, strong) NSString *error; /**< The OOPlayer's current error if it exists */
@property(readonly, nonatomic, strong) UIView *view;
@property(nonatomic) BOOL completed;
@property(readonly, nonatomic, getter = isLiveClosedCaptionsAvailable) BOOL liveClosedCaptionsAvailable;

/**
 * Init the player
 */
- (id) initWithStreams:(NSArray *)streams;

- (BOOL)isPlaying;

- (void)setVideoGravity:(OOOoyalaPlayerVideoGravity)gravity;

- (BOOL)isAudioOnlyStreamPlaying;

- (void) setLiveClosedCaptionsEnabled:(BOOL)enabled;

- (CMTimeRange) seekableTimeRange;

-(CGRect)videoRect;

- (void)setState:(OOOoyalaPlayerState)state;
@end
