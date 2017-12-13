//
//  OOPlayerProtocol.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTimeRange.h>

/**
 * Defines different gravity modes, which control how video is adjusted to available screen size
 */
typedef enum
{
  /** Specifies that the video should be stretched to fill the layer’s bounds. */
  OOOoyalaPlayerVideoGravityResize,
  /** Specifies that the player should preserve the video’s aspect ratio and fit the video within the layer’s bounds */
  OOOoyalaPlayerVideoGravityResizeAspect,
  /** Specifies that the player should preserve the video’s aspect ratio and fill the layer’s bounds. */
  OOOoyalaPlayerVideoGravityResizeAspectFill
} OOOoyalaPlayerVideoGravity;

/**
 * Defines different possible player states
 */
typedef enum
{
  /** Initial state, player is created but no content is loaded */
  OOOoyalaPlayerStateInit,
  /** Loading content */
  OOOoyalaPlayerStateLoading,
  /** Content is loaded and initialized, player is ready to begin playback */
  OOOoyalaPlayerStateReady,
  /** Player is playing a video */
  OOOoyalaPlayerStatePlaying,
  /** Player is paused, video is showing */
  OOOoyalaPlayerStatePaused,
  /** Player has finished playing content */
  OOOoyalaPlayerStateCompleted,
  /** Player has encountered an error, check OOOoyalaPlayer.error */
  OOOoyalaPlayerStateError
} OOOoyalaPlayerState;

typedef enum
{
  /** user is playing a video */
  OOOoyalaPlayerDesiredStatePlaying,
  /** user is paused, video is showing */
  OOOoyalaPlayerDesiredStatePaused,
} OOOoyalaPlayerDesiredState;

@protocol OOPlayerProtocol<NSObject>

/**
 * @returns YES if the player will put its own controls on-screen;
 * NO if the player wants the Ooyala controls to be used instead.
 */
- (BOOL) hasCustomControls;

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

- (void)setVideoGravity:(OOOoyalaPlayerVideoGravity)gravity;

- (void)setClosedCaptionsLanguage:(NSString *)language;

/**
 * This returns the player state
 *
 * @return the state
 */
@property (nonatomic, readonly) OOOoyalaPlayerState state;
@property (nonatomic)           BOOL seekable;
@property (nonatomic, readonly) CMTimeRange seekableTimeRange;
@property (nonatomic)           BOOL allowsExternalPlayback;
@property (nonatomic, readonly) BOOL externalPlaybackActive;
@property (nonatomic)           float rate; // playback rate
@property (nonatomic, readonly) double bitrate;
@property (nonatomic, readonly) BOOL supportsVideoGravityButton;
@property (nonatomic, readonly, getter = isLiveClosedCaptionsAvailable) BOOL liveClosedCaptionsAvailable;
@property (nonatomic) float volume; /** the player volume*/

@end
