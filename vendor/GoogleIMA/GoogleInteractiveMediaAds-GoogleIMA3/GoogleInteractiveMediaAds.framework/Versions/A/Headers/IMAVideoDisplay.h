//
//  IMAVideoDisplay.h
//  GoogleIMA3
//
//  Copyright (c) 2015 Google Inc. All rights reserved.
//
//  Declares a simple video display class used for ad playback.

#import "IMAAdPlaybackInfo.h"

@protocol IMAVideoDisplayDelegate<NSObject>

// Informs the SDK the ad has started playback.
- (void)onPlay;

// Informs the SDK the ad volume changed.
- (void)onVolumeChangedToVolume:(float)volume;

// Informs the SDK the video ad progressed.
- (void)onProgressWithMediaTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime;

// Informs the SDK the ad was clicked.
- (void)onClick;

// Informs the SDK the ad has paused.
- (void)onPause;

// Informs the SDK the ad has resumed after a pause.
- (void)onResume;

// Informs the SDK the ad has completed playback.
- (void)onComplete;

// Informs the SDK the ad playback failed.
- (void)onError;

// Informs the SDK the ad was skipped.
- (void)onSkip;

// Informs the SDK the ad skip button appeared.
- (void)onSkipShown;

// Informs the SDK the ad started.
- (void)onStart;

// Informs the SDK that timed metadata was received.
- (void)onTimedMetadata:(NSDictionary *)metadata;

// Informs the SDK that the ad has loaded.
- (void)onLoaded;

@optional

// Informs the SDK the video ad is buffered to |mediaTime| in seconds.
- (void)onBufferedWithMediaTime:(NSTimeInterval)mediaTime;

// Informs the SDK the ad is buffered and playback is likely to keep up.
- (void)onPlaybackReady;

// Informs the SDK the ad's media buffer is empty and playback will stall.
- (void)onStartBuffering;

@end

/**
 * Declares a simple video display class used for ad playback.
 */
@protocol IMAVideoDisplay <IMAAdPlaybackInfo>

// Allows the publisher to send player events to the SDK.
@property(nonatomic, weak) id<IMAVideoDisplayDelegate> delegate;

// Called to inform the VideoDisplay to load the passed URL.
- (void)loadUrl:(NSURL *)url;

// Called to inform the VideoDisplay to play.
- (void)play;

// Called to inform the VideoDisplay to pause.
- (void)pause;

// Called to remove all video assets from the player.
- (void)reset;

@end
