//
//  OOPulseCompanionAd.h
//  Pulse
//
//  Created by Joao Sampaio on 12/04/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Pulse_tvOS/OOPulseAd.h>
#import <Pulse_tvOS/OOMediaFile.h>
#import <Pulse_tvOS/OOPulseAdError.h>

@class VPAd;
@class OOPulse;

/**
 *  This protocol is used to handle companion banners, and notify
 *  the [OOPulseSession] about events regarding the companion banner.
 *
 *  As a minimum, the session object must be notified that the
 *  companion banner was displayed: [OOPulseCompanionAd adDisplayed].
 * 
 *  Depending on your application, you may also need the clickthrough
 *  URL ([OOPulseCompanionAd clickthroughURL]) to respond to viewers
 *  tapping a companion banner.
 */
@protocol OOPulseCompanionAd <OOPulseAd>

/**
 *  Notify the session that the ad has been displayed
 */
- (void)adDisplayed;

/**
 *  The URL where the ad's resource is located.
 */
- (NSURL *)resourceURL;

/**
 *  The MIME type of the resource to be displayed.
 */
- (NSString *)resourceType;

/**
 *  Returns the zone identifier assigned to this companion ad.
 */
- (NSString *) zoneIdentifier;

/**
 The companion ad id assigned by Ooyala Pulse.
 */
- (NSString *) identifier;

/**
 The custom companion ad id set in the Ooyala Pulse UI.
 */
- (NSString *) customIdentifier;

/**
 The companion's width.
 */
- (NSInteger) width;

/**
 The companion's height.
 */
- (NSInteger) height;

@end
