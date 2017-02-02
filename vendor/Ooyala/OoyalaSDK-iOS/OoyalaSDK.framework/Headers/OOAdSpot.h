/**
 * @class      OOAdSpot OOAdSpot.h "OOAdSpot.h"
 * @brief      OOAdSpot
 * @details    OOAdSpot.h in OoyalaSDK
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * A Generic class to hold AdSpot time info
 */
@interface OOAdSpot : NSObject

/** time to play the ad in second */
@property NSNumber *time;

/** the priority to distinguish ad spots of same time, adspot having a smaller priority will be played first */
@property int priority;

/**
 * Initialize an ad spot with time
 * @param[in] t the ad spot time
 * @returns initialized ad spot
 */
- (id)initWithTime:(NSNumber *)t;

/**
 * compare two ad spots based on their time *
 * @param[in] other the other object to compare
 * @returns compare results as NSComparisonResult
 */
- (NSComparisonResult)compare:(OOAdSpot *)other;

@end
