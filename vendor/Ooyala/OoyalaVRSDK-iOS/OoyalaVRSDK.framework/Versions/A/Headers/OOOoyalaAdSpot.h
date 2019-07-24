/**
 * @class      OOOoyalaAdSpot OOOoyalaAdSpot.h "OOOoyalaAdSpot.h"
 * @brief      OOOoyalaAdSpot
 * @details    OOOoyalaAdSpot.h in OoyalaSDK
 * @date       11/29/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOManagedAdSpot.h"
#import "OOAuthorizableItem.h"
#import "OOPlayableItem.h"

@class OOOoyalaAPIClient;

/**
 * A single ooyala video ad associated with specific time
 */
@interface OOOoyalaAdSpot : OOManagedAdSpot <OOAuthorizableItem, OOPlayableItem> 

@property (readonly, nonatomic) NSMutableArray *streams;
@property (readonly, nonatomic) NSString *embedCode; /**< The OOOoyalaAdSpot's Embed Code */
@property (readonly, nonatomic) BOOL authorized;             /**< @internal Whether or not this OOOoyalaAdSpot is authorized */
@property (readonly, nonatomic) OOAuthCode authCode;         /**< @internal The response code from the authorize call */
@property (nonatomic) BOOL heartbeatRequired;        /**< @internal if the heartbeat is required */

/**
 * Initialize an OOOoyalaAdSpot using the embed code
 * @param theTime the time at which to play the ad
 * @param theClickURL the clickthrough URL
 * @param theTrackingURLs the tracking URLs
 * @param theEmbedCode the embed code to initialize the OOOoyalaAdSpot with
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOOoyalaAdSpot
 * @return the initialized OOOoyalaAdSpot
 */
- (instancetype)initWithTime:(NSNumber *)theTime
                    clickURL:(NSURL *)theClickURL
                trackingURLs:(NSArray *)theTrackingURLs
                   embedCode:(NSString *)theEmbedCode
                         api:(OOOoyalaAPIClient *)theAPI;

/** @internal
 * Initialize an OOOoyalaAdSpot using the specified data (subclasses should override this)
 * @param data the NSDictionary containing the data to use to initialize this OOOoyalaAdSpot
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOOoyalaAdSpot
 * @return the initialized OOOoyalaAdSpot
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOOoyalaAdSpot using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to update this OOOoyalaAdSpot
 * @return OOReturnState.OOReturnStateFail if the parsing failed, OOReturnState.OOReturnStateMatched if it was successful
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 Fetch the additional required info for the ad

 @param callback NO if errors occurred, YES if successful
 */
- (void)fetchPlaybackInfoWithCallback:(void (^)(BOOL success))callback;

/** @internal
 * The embed codes to authorize
 * @return the embed codes to authorize as an NSArray
 */
- (NSArray *)embedCodesToAuthorize;

@end
