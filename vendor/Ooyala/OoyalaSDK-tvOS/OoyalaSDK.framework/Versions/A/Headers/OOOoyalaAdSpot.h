/**
 * @class      OOOoyalaAdSpot OOOoyalaAdSpot.h "OOOoyalaAdSpot.h"
 * @brief      OOOoyalaAdSpot
 * @details    OOOoyalaAdSpot.h in OoyalaSDK
 * @date       11/29/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOManagedAdSpot.h"

#import "OOPlayableItem.h"
#import "OOAuthCode.h"

@class OOOoyalaAPIClient;
@class OOPlayerAPIClient;
@class OOAuthorization;
@class OOContentTreeAd;

/**
 * A single ooyala video ad associated with specific time
 */
@interface OOOoyalaAdSpot : OOManagedAdSpot <OOPlayableItem> 

@property (readonly, nonatomic) NSMutableArray *streams;
@property (readonly, nonatomic) NSString *embedCode;      /**< The OOOoyalaAdSpot's Embed Code */
@property (readonly, nonatomic) BOOL authorized;          /**< @internal Whether or not this OOOoyalaAdSpot is authorized */
@property (readonly, nonatomic) OOAuthCode authCode;      /**< @internal The response code from the authorize call */

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
 * @param contentTreeAd a @c OOContentTreeAd from content_tree response
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOOoyalaAdSpot
 * @return the initialized OOOoyalaAdSpot
 */
- (instancetype)initWithContentTreeAd:(OOContentTreeAd *)contentTreeAd
                                  api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOOoyalaAdSpot using the specified data (subclasses should override and call this)
 * @param authorization an instance of @c OOAuthorization from authorization request
 */
- (void)updateWithAuthorization:(OOAuthorization *)authorization;

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
