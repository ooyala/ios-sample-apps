//
//  OOPulseSessionDelegate.h
//  Pulse
//
//  Created by Jacques du Toit on 14/10/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Pulse_tvOS/OOPulseVideoAd.h>
#import <Pulse_tvOS/OOPulseAdBreak.h>
#import <Pulse_tvOS/OOPulsePauseAd.h>

/**
 *  This delegate is used by OOPulseSession to communicate with your application.
 *
 *  It will inform your application of the proper time to perform certain actions, or
 *  when some events have occurred.
 */
@protocol OOPulseSessionDelegate <NSObject>

@required

/**  @name Actions */

/**
 *  When called you should start (or resume) playback of the content.
 *
 */
- (void)startContentPlayback;

/**
 *  When called you should pause playback of the content (if it was playing), and
 *  prepare your user interface for video ad playback.
 *
 *  You will be notified of each ad to display through 
 *  [OOPulseSessionDelegate startAdPlaybackWithAd:timeout:].
 *
 *  @param adBreak The OOPulseAdBreak that has started.
 */
- (void)startAdBreak:(id<OOPulseAdBreak>)adBreak;

/**
 *  When called you should start playback of the given ad.
 *
 *  You are responsible for notifying the ad when certain events have occurred.
 *
 *  @param ad      The OOPulseVideoAd to be displayed.
 *  @param timeout The time you have until the first frame of the ad has displayed.
 *                 If this was not possible, you are responsible for calling
 *                 [OOPulseVideoAd adFailedWithError:] with OOPulseAdErrorTimedOut.
 */
- (void)startAdPlaybackWithAd:(id<OOPulseVideoAd>)ad timeout:(NSTimeInterval)timeout;

@optional

/**
 *  When called you should display the provided pause ad.
 *
 *  You are responsible for notifying the ad when certain events have occurred.
 *
 *  @param ad      The OOPulsePauseAd to be displayed.
 */
- (void) showPauseAd:(id<OOPulsePauseAd>)ad;

@required

/**  @name Events */

/**
 *  The session has ended. 
 * 
 *  No further delegate methods will be called.
 */
- (void)sessionEnded;

/**
 *  An illegal operation has occurred. 
 *
 *  Most likely protocol methods in
 *  OOPulseSession or OOPulseVideoAd were called when they were not expected.
 *
 *  One way to recover from this would be to stop the current session, and continue
 *  playing the content.
 *
 *  @param error The error that occurred.
 */
- (void)illegalOperationOccurredWithError:(NSError *)error;

@end
