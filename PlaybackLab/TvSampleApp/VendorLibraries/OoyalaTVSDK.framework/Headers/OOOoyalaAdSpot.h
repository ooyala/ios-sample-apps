/**
 * @class      OOOoyalaAdSpot OOOoyalaAdSpot.h "OOOoyalaAdSpot.h"
 * @brief      OOOoyalaAdSpot
 * @details    OOOoyalaAdSpot.h in OoyalaSDK
 * @date       11/29/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOManagedAdSpot.h"
#import "OOAuthorizableItem.h"
#import "OOPlayableItem.h"
#import "OOOoyalaAPIClient.h"

/**
 * A single ooyala video ad associated with specific time
 */
@interface OOOoyalaAdSpot : OOManagedAdSpot <OOAuthorizableItem, OOPlayableItem> 

@property(readonly, nonatomic, strong) NSMutableArray *streams;
@property(readonly, nonatomic, strong) NSString *embedCode; /**< The OOOoyalaAdSpot's Embed Code */
@property(readonly, nonatomic) BOOL authorized;             /**< @internal Whether or not this OOOoyalaAdSpot is authorized */
@property(readonly, nonatomic) OOAuthCode authCode;         /**< @internal The response code from the authorize call */
@property(nonatomic, assign) BOOL heartbeatRequired;        /**< @internal if the heartbeat is required */

/**
 * Initialize an OOOoyalaAdSpot using the embed code
 * @param[in] theTime the time at which to play the ad
 * @param[in] theClickURL the clickthrough URL
 * @param[in] theTrackingURLs the tracking URLs
 * @param[in] theEmbedCode the embed code to initialize the OOOoyalaAdSpot with
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOOoyalaAdSpot
 * @returns the initialized OOOoyalaAdSpot
 */
- (id)initWithTime:(NSNumber *)theTime clickURL:(NSURL *)theClickURL trackingURLs:(NSArray *)theTrackingURLs embedCode:(NSString *)theEmbedCode api:(OOOoyalaAPIClient *)theAPI;

/** @internal
 * Initialize an OOOoyalaAdSpot using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOOoyalaAdSpot
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOOoyalaAdSpot
 * @returns the initialized OOOoyalaAdSpot
 */
- (id)initWithDictionary:(NSDictionary *)data api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOOoyalaAdSpot using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOOoyalaAdSpot
 * @returns OOReturnState.OOReturnStateFail if the parsing failed, OOReturnState.OOReturnStateMatched if it was successful
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * Fetch the additional required info for the ad
 * @returns NO if errors occurred, YES if successful
 */
- (BOOL)fetchPlaybackInfo;

/** @internal
 * The embed codes to authorize
 * @returns the embed codes to authorize as an NSArray
 */
- (NSArray *)embedCodesToAuthorize;

@end
