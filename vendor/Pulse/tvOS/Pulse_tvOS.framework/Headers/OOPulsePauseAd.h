//
//  OOPulseVideoAd.h
//  Pulse
//
//  Created by Jacques du Toit on 11/11/15.
//  Copyright © 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Pulse_tvOS/OOPulseAd.h>
#import <Pulse_tvOS/OOMediaFile.h>
#import <Pulse_tvOS/OOPulseAdError.h>

@class VPAd;
@class OOPulse;

/**
 *  This is the protocol for pause ads owned by a OOPulseSession.
 *
 *  This protocol is used to notify the session about events
 *  regarding this ad, and provides access to relevant properties.
 *
 *  You must notify this object of the following events:
 *
 *  - The ad has been displayed: [OOPulsePauseAd adDisplayed]
 *  - The ad has been closed by the user: [OOPulsePauseAd adClosed]
 *  - The ad failed to play: [OOPulsePauseAd adFailedWithError:]
 *
 *  Depending on your application some of the other methods may need to be called
 *  in response to user interaction.
 *
 */
@protocol OOPulsePauseAd <OOPulseAd>

/**  @name Ad event notifications */

/**
 *  Notify the session that the ad has been displayed
 *
 *  This should only be called after your delegate has been instructed to show
 *  the ad through [OOPulseSessionDelegate showPauseAd:].
 */
- (void)adDisplayed;

/**
 *  Notify the session that the pause ad has been closed by the user.
 *
 *  Do not call if the ad was closed because the user resumed playback of the video content.
 */
- (void)adClosed;

/**
 *  Notify the session that, due to an error, the ad could not be played or that playback
 *  could not continue.
 *
 *  @param error The OOPulseAdError that best describes the problem.
 */
- (void)adFailedWithError:(OOPulseAdError)error;

/**  @name Ad properties */

/**
 * The MIME-type of the resource to display.
 */
- (NSString *)resourceType;

/**
 * The URL where the ad's resource is located.
 */
- (NSURL *)resourceURL;

/**
 The ad id.
 */
- (NSString *)identifier;

/**
 The custom ad identifier set in the Ooyala Pulse UI.
 */
- (NSString *)customIdentifier;

/**
 The Identifier of the campaign to which the ad belongs; supplied by Ooyala Pulse.
 */
- (NSString *)campaignIdentifier;

/**
 The custom Identifier of the campaign to which the ad belongs; set in the Ooyala Pulse UI.
 */
- (NSString *)customCampaignIdentifier;

/**
 The Identifier of the goal to which the ad belongs; supplied by Ooyala Pulse.
 */
- (NSString *)goalIdentifier;

/**
 The custom Identifier of the goal to which the ad belongs; set in the Ooyala Pulse UI.
 */
- (NSString *)customGoalIdentifier;

/**
 Whether or not the ad is part of an exclusive campaign.
 */
- (BOOL)partOfAnExclusiveCampaign;

/**
 A string that provides a common name for the ad.
 */
- (NSString *)title;

/**
 An array of OOAdCategory objects containing the categories of the Ad and their responsible authorities.
 */
- (NSArray *)categories;

/**
 *  Returns an array of companion banners for this ad.
 *
 *  Your application should choose the proper companion banner to display based on their
 *  zone identifier.
 *
 *  @return A NSArray of objects conforming to the OOPulseCompanionAd protocol.
 */
- (NSArray<id<OOPulseCompanionAd>>*)companions;

@end
