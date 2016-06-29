//
//  IMAStreamManager.h
//  GoogleIMA3
//
//  Copyright (c) 2015 Google Inc. All rights reserved.
//
//  Declares IMAStreamManager interface that manages stream playback.
//  The interface represents an abstract API. There can be only one stream managed by a single
//  stream manager.
//  The implementing code should respond to the callbacks as defined in IMAStreamManagerDelegate.
//
//  A typical stream playback session:
//    1. Stream manager is retrieved. Delegate is set.
//    2. Stream playback will meanwhile start because of the adsLoader requestStream call.
//    3. delegate.didReceiveAdEvent: is called with a kIMAAdBreakStarted event.
//    4. Publisher should now hide content controls or disable seeking. Ad is now playing
//    5. delegate.didReceiveAdEvent: is called with a kIMAAdStart event. This event comes with
//       information about the ad.
//    6. delegate.didReceiveAdEvent is called with ad events like quartiles, midpoint and complete.
//    7. Ad break finishes and delegate.didReceiveAdEvent is called with a kIMAAdBreakEnded event.
//    8. Publisher should now show content controls or reenable seeking. Content is now playing.
//       playback should resume now.
//       It is possible to detach the delegate and destroy the ads manager.
//
//  Steps 3-8 may repeat several times for the same stream if there are multiple ads inserted in
//  the stream.

#import <Foundation/Foundation.h>

#import "IMAAdError.h"
#import "IMAAdEvent.h"
#import "IMAAdPlaybackInfo.h"
#import "IMAAdsRenderingSettings.h"
#import "IMAContentPlayhead.h"

@class IMAStreamManager;

#pragma mark IMAStreamManagerDelegate

/**
 *  A callback protocol for IMAStreamManager.
 */
@protocol IMAStreamManagerDelegate

/**
 *  Called when there is an IMAAdEvent.
 *
 *  @param streamManager the IMAStreamManager receiving the event
 *  @param event         the IMAAdEvent received
 */
- (void)streamManager:(IMAStreamManager *)streamManager didReceiveAdEvent:(IMAAdEvent *)event;

/**
 *  Called when there is an IMAAdEvent.
 *
 *  @param streamManager the IMAStreamManager receiving the error
 *  @param event         the IMAAdError received
 */
- (void)streamManager:(IMAStreamManager *)streamManager didReceiveAdError:(IMAAdError *)error;

@optional

/**
 *  Called every 200ms to provide time updates for the current stream.
 *
 *  @param streamManager the IMAStreamManager tracking ad playback
 *  @param mediaTime     the current media time in seconds
 *  @param totalTime     the total media length in seconds
 */
- (void)streamManager:(IMAStreamManager *)streamManager
    adDidProgressToTime:(NSTimeInterval)mediaTime
              totalTime:(NSTimeInterval)totalTime;

@end

#pragma mark - IMAStreamManager

/**
 *  The IMAStreamManager class is responsible for playing streams.
 */
@interface IMAStreamManager : NSObject

/**
 *  The IMAStreamManagerDelegate to notify with events during stream playback.
 */
@property(nonatomic, weak) NSObject<IMAStreamManagerDelegate> *delegate;

/**
 *  Identifier used during dynamic ad insertion to uniquely identify a stream.
 */
@property(nonatomic, copy, readonly) NSString *streamId;

/**
 *  Initializes and loads the stream.
 *
 *  @param adsRenderingSettings the IMAAdsRenderingSettings. Pass in to influence ad rendering.
 *                              Use nil to default to standard rendering.
 */
- (void)initializeWithAdsRenderingSettings:(IMAAdsRenderingSettings *)adsRenderingSettings;

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Cleans the stream manager's internal state for proper deallocation.
 */
- (void)destroy;

@end
