/**
 * @class      OOAdSpot OOAdSpot.h "OOAdSpot.h"
 * @brief      OOAdSpot
 * @details    OOAdSpot.h in OoyalaSDK
 * @warning    This is an abstract class. It is not meant to be instantiated.
 * @date       11/29/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOAdSpot.h"
#import "OOReturnState.h"

@class OOPlayerAPIClient;

/**
 * Base class for concrete ad spot implementations.
 * Should not be used directly by app developers, instead use OOOoyalaAdSpot or OOVASTAd
 */
@interface OOManagedAdSpot : OOAdSpot

@property (readonly) NSURL *clickURL; /**< The URL which should be opened when the OOAdSpot is clicked */
@property (readonly) NSArray *trackingURLs; /**< The Array of URLs which should be pinged when the OOAdSpot plays */
@property (weak) OOPlayerAPIClient *api;   /**< @internal The API that was used to fetch the OOAdSpot */

/** @internal
 * Initialize an OOAdSpot using the embed code
 * @param[in] theTime the time at which to play the ad
 * @param[in] theClickURL the clickthrough URL
 * @param[in] theTrackingURLs the tracking URLs
 * @returns the initialized OOAdSpot
 */
- (id)initWithTime:(NSNumber *)theTime clickURL:(NSURL *)theClickURL trackingURLs:(NSArray *)theTrackingURLs;

/** @internal
 * Initialize an OOAdSpot using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOAdSpot
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOAdSpot
 * @returns the initialized OOAdSpot
 */
- (id)initWithDictionary:(NSDictionary *)data api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOAdSpot using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOAdSpot
 * @returns OOReturnState.OOReturnStateFail if the parsing failed, OOReturnState.OOReturnStateMatched if it was successful
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * Fetch the additional required info for the OOAdSpot
 * @returns NO if errors occurred, YES if successful
 */
- (BOOL)fetchPlaybackInfo;

- (id)fetchPlaybackInfo:(void (^)(BOOL))callback;

/** @internal
 * Create an OOAdSpot from the given data
 * @param[in] data the data to create the OOAdSpot with
 * @param[in] api the OOPlayerAPIClient that was used to fetch this OOAdSpot
 * @returns the created OOAdSpot (OOOoyalaAdSpot or OOVASTAd)
 */
+ (OOManagedAdSpot *)adSpotFromDictionary:(NSDictionary *)data api:(OOPlayerAPIClient *)api;

@end
