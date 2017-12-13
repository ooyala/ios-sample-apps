//
//  OOPulseAdBreak.h
//  Pulse
//
//  Created by Jacques du Toit on 07/03/16.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * This is the protocol for an ad break owned by an OOPulseSession. 
 *
 * An ad break is a collection of ads that are to be displayed in sequence.
 *
 * This protocol is used to request information regarding the ad break,
 * or to stop the ad break forcefully.
 */
@protocol OOPulseAdBreak <NSObject>

/**
 *  The number of playable ads remaining in this ad break.
 *
 */
- (NSInteger)playableAdsRemaining;

/**
 *  The number of playable ads in this ad break.
 *
 */
- (NSInteger)playableAdsTotal;

/**
 *  Forcefully stop the ad break.
 *
 *  This may be called at any time while the ad break is active. 
 *
 *  After the ad break is stopped the session will continue with
 *  [OOPulseSessionDelegate startContentPlayback], or
 *  [OOPulseSessionDelegate sessionEnded] if the content has already finished.
 */
- (void)stopAdBreak;

@end