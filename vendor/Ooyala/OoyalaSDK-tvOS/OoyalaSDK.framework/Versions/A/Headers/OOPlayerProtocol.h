//
//  OOPlayerProtocol.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTimeRange.h>
#import "OOPlayerState.h"

#ifndef OOPlayerProtocol_h
#define OOPlayerProtocol_h

@class UIImage;

@protocol OOPlayerProtocol<NSObject>

/**
 * @returns YES if the player will put its own controls on-screen;
 * NO if the player wants the Ooyala controls to be used instead.
 */
- (BOOL)hasCustomControls;

/**
 * This is called when pause is clicked
 */
- (void)pause;

/**
 * This is called when play is clicked
 */
- (void)play;

/**
 * This is called when stop is clicked
 */
- (void)stop;

/**
 * Get the current playhead time
 * @returns the current playhead time as CMTime
 */
- (Float64)playheadTime;

/**
 * Get the current item's duration
 * @returns duration as CMTime
 */
- (Float64)duration;

/**
 * Get the current item's buffer
 * @returns buffer as CMTimeRange
 */
- (Float64)buffer;

/**
 * Set the current playhead time of the player
 * @param[in] time CMTime to set the playhead time to
 */
- (void)seekToTime:(Float64)time;

/**
 * @returns current frame of playing asset
 */
- (UIImage *)screenshot;

- (void)setVideoGravity:(OOOoyalaPlayerVideoGravity)gravity;

- (void)setClosedCaptionsLanguage:(NSString *)language;

- (void)disablePlaylistClosedCaptions;

/**
 * This returns the player state
 *
 * @return the state
 */
@property (nonatomic, readonly) OOOoyalaPlayerState state;
@property (nonatomic)           BOOL seekable;
@property (nonatomic, readonly) CMTimeRange seekableTimeRange;
@property (nonatomic)           BOOL allowsExternalPlayback;
@property (nonatomic)           BOOL usesExternalPlaybackWhileExternalScreenIsActive;
@property (nonatomic, readonly) BOOL externalPlaybackActive;
@property (nonatomic)           float rate; // playback rate
@property (nonatomic, readonly) double bitrate;
@property (nonatomic, readonly) BOOL supportsVideoGravityButton;
@property (nonatomic, readonly, getter = isLiveClosedCaptionsAvailable) BOOL liveClosedCaptionsAvailable;
@property (nonatomic) float volume; /** the player volume*/

@end

#endif // OOPlayerProtocol_h
