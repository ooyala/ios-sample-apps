//
//  OOPulseSession.h
//  Pulse
//
//  Created by Jacques du Toit on 12/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Pulse_tvOS/Pulse.h>

#import <Pulse_tvOS/OOPulseSessionDelegate.h>
#import <Pulse_tvOS/OOPulseAdError.h>

/**
 Callback to confirm that session was successfully extended.
 */
typedef void(^OOSessionExtensionSuccessBlock)();

/**
 *  This protocol is used to interact with an ad session.
 *
 *  You must notify this object of the following events:
 *
 *  - The content has started: [OOPulseSession contentStarted]
 *  - The content playback position has changed: [OOPulseSession contentPositionChanged:]
 *  - The content has played to completion: [OOPulseSession contentFinished]
 *
 *  The session will notify you through the delegate provided to
 *  [OOPulseSession startSessionWithDelegate:].
 */
@protocol OOPulseSession <NSObject>

/**  @name Methods */

/**
 *  Start the ad session. The provided delegate will be notified when to play
 *  the content/ads.
 *
 *  This will trigger an ad break through [OOPulseSessionDelegate startAdBreak]
 *  if any prerolls ads are available, otherwise it will trigger the start of the content
 *  through [OOPulseSessionDelegate startContentPlayback].
 *
 *  @param delegate The OOPulseSessionDelegate delegate that will be notified.
 */
- (void)startSessionWithDelegate:(id<OOPulseSessionDelegate>)delegate;

/**
 * Request additional ads for the ad session.
 *
 * @param  contentMetadata Information about the content which a requested ad session is to be played with, as well as information targeting the desired campaign(s).
 * @param  requestSettings Information about the environment in which the requested ad(s) will play.
 * @param  onSuccess The OOSessionExtensionSuccessBlock that will be notified when the session extension completes.
 */

- (void)extendSessionWithContentMetadata:(OOContentMetadata *)contentMetadata
                         requestSettings:(OORequestSettings *)requestSettings
                                 success:(OOSessionExtensionSuccessBlock)onSuccess;

/**
 *  Forcefully stop the session.
 *  
 *  This may be called at any time during a session. No further delegate methods
 *  will be called after the session is stopped. 
 *
 */
- (void)stopSession;

/**  @name Content event notifications */

/**
 *  Notify the session that content playback has started.
 *
 *  This should only be called after your delegate has been instructed to play
 *  the content through [OOPulseSessionDelegate startContentPlayback], or if
 *	you have previously paused it with a call to [OOPulseSession contentPaused].
 */
- (void)contentStarted;

/**
 *  Notify the session that the content playback position has changed, either
 *  as a result of seeking or normal playback.
 *
 *  This may trigger an ad break through [OOPulseSessionDelegate startAdBreak]
 *  if any midroll ads are available.
 *
 *  @param position The content position in seconds since start.
 */
- (void)contentPositionChanged:(NSTimeInterval)position;

/**
 *  Notify the session that content playback has been paused by
 *  the user.
 *
 *  This may trigger a pause ad to display through [OOPulseSessionDelegate showPauseAd],
 *  if such an ad is available.
 */
- (void)contentPaused;

/**
 *  Notify the session that the content has played to completion.
 *
 *  This may trigger an ad break through [OOPulseSessionDelegate startAdBreak]
 *  if any postroll ads are available.
 */
- (void)contentFinished;

@end
