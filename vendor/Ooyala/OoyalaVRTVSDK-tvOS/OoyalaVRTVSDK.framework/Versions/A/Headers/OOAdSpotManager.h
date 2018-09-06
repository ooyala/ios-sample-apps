/**
 * @class     OOAdSpotManager OOAdSpotManager.h "OOAdSpotManager.h"
 * @brief     OOAdSpotManager
 * @details   OOAdSpotManager.h in OoyalaSDK
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "CoreMedia/CMTime.h"
#import <Foundation/Foundation.h>
#import "OOAdSpot.h"

/**
 * A class that manages a list of ad spots for a content
 */
@interface OOAdSpotManager : NSObject

/**
* @return non-nil (possibly empty) NSNumber (int in seconds) set of cue point times for ads.
*/
- (NSSet*)getCuePointsAtSeconds;

/**
 * Mark all adspots as unplayed
 */
- (void)resetAds;

/**
 * Clear all adspots
 */
- (void)clear;

/**
 * Insert an adSpot
 *
 * @param ad
 *          the adSpot to insert
 */
- (void)insertAd:(OOAdSpot *)ad;

/**
 * Insert an adSpot
 *
 * @param adSpots
 *          the adSpot to insert
 */
- (void)insertAds:(NSArray *)adSpots;

/**
 * get the adspot before a certain time,
 *
 * @param time
 *          in CMTime
 * @returns the unplayed adspot before the specified time which, null if no
 *          such adspot
 */
- (OOAdSpot *)adBeforeTime:(Float64)time;

/**
 * mark an adspot as played
 *
 * @param ad
 *          the adspot to be marked
 */
- (void)markAsPlayed:(OOAdSpot *)ad;

/**
 * get the adspot list size
 *
 * @returns size
 */
- (NSUInteger)count;

@end
