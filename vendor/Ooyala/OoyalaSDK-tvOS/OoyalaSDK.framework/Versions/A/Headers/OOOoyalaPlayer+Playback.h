//
//  OOOoyalaPlayer+Playback.h
//  OoyalaSDK
//
//  Created on 11/1/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_Playback_h
#define OOOoyalaPlayer_Playback_h

@interface OOOoyalaPlayer (Playback)

@property (readonly, nonatomic, getter=isPiPActivated) BOOL pipActivated;
@property (readonly, nonatomic, getter=isAudioOnly) BOOL audioOnly;

/**
 * Gets the duration of the asset.
 * @return the duration of the currently playing asset, in seconds
 */
- (Float64)duration;

/**
 * Get the current bitrate
 * @return a double indicating the current bitrate in bytes
 */
- (double)bitrate;

/**
 * Checks the expiration of the authToken, and compares it to the current time.
 * @return YES if token is expired, NO otherwise
 */
- (BOOL) isAuthTokenExpired;

/**
 * current seekable range for main video.
 */
- (CMTimeRange) seekableTimeRange;

/**
 * Get whether the player is playing ad
 * @return a BOOL indicating the current player is playing ad
 */
- (BOOL)isShowingAd;

/**
 * @return YES if self.isShowingAd==YES and the ad player reports that
 * it has custom controls, instead of using the Ooyala video controls.
 */
- (BOOL)isShowingAdWithCustomControls;

/**
 * Gets the current playhead time (the part of the video currently being accessed).
 * @return the current playhead time, in milliseconds
 */
- (Float64)playheadTime;

/**
 * Gets the  (approximate) real time of a live stream
 * @return currently playing time
 */
- (NSDate *)liveTime;

/**
 * Get the maximum buffered time
 * @return the buffered time in seconds of the currently playing item
 */
- (Float64)bufferedTime;

/**
 * Get whether the player is playing
 * @return a BOOL indicating the current player is playing
 */
- (BOOL)isPlaying;

/**
 * Return a collection of the times at which to show cue points.
 * E.g. for the content player, show when ads are scheduled to play.
 */
- (NSSet *)getCuePointsAtSecondsForCurrentPlayer; ///<NSNumber int seconds>

/**
 * Toggle the picture in picture mode
 * iOS 9 and up only
 */
- (void)togglePictureInPictureMode;

/**
 * Sets the current playhead time of the player (same as seek). For example, to start a video at the 30 second point, you would set the playhead to 30.
 * @param time the playhead time, in seconds
 */
- (void)setPlayheadTime:(Float64) time;

/**
 * Sets the current playhead time of the player (same as setPlayheadTime).
 * @param time the playhead time, in seconds
 */
- (void)seek:(Float64)time;

- (void)seekCompleted;

/**
 * Pauses the current video.
 */
- (void)pause;

/**
 * Plays the current video.
 */
- (void)play;

/**
 * Plays the current video with an initial time
 */
- (void)playWithInitialTime:(Float64)time;

@end

#endif /* OOOoyalaPlayer_Playback_h */
