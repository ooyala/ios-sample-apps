/**
 * @class      OOContentItem OOContentItem.h "OOContentItem.h"
 * @brief      OOContentItem
 * @details    OOContentItem.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOAuthorizableItem.h"

@class OOPlayerAPIClient;
@class OOVideo;
@class OOFCCTVRating;

/**
 * A single playable content item, such as video
 */
@interface OOContentItem : NSObject <OOAuthorizableItem> {
@protected
  NSString *embedCode;
  NSString *externalId;
  NSString *title;
  NSString *itemDescription;
  NSString *promoImageURL;
  NSString *hostedAtURL;    
  OOPlayerAPIClient *api;
  BOOL authorized;
  OOAuthCode authCode;
}

@property(readonly, nonatomic, strong) NSString *embedCode;    /**< The OOContentItem's Embed Code */
@property(readonly, nonatomic, strong) NSString *externalId;   /**< The OOContentItem's External ID if it exists */
@property(readonly, nonatomic, strong) NSString *title;        /**< The OOContentItem's Title */
@property(readonly, nonatomic, strong) NSString *itemDescription;  /**< The OOContentItem's Description */
@property(readonly, nonatomic, strong) NSString *promoImageURL;  /**< The OOContentItem's Promo Image URL */
@property(readonly, nonatomic, strong) NSString *hostedAtURL;    /**< The OOContentItem's Hosted At URL */
@property(readonly, nonatomic, strong) OOPlayerAPIClient *api;   /**< @internal The API that was used to fetch the OOContentItem */
@property(readonly, nonatomic) BOOL authorized;                /**< Whether or not this OOContentItem is authorized */
@property(readonly, nonatomic) OOAuthCode authCode;              /**< The response code from the authorize call */
@property (readonly, nonatomic, strong) NSDictionary *metadata;
@property (readonly, nonatomic, strong) NSDictionary *moduleData;
@property (nonatomic, assign) BOOL heartbeatRequired;
@property (readonly, nonatomic) OOFCCTVRating *tvRating;
@property(readonly, nonatomic, strong) NSString *assetPcode;  /**< The OOContentItem's Promo Image URL */

/**
 * Initialize a OOContentItem
 * @param[in] theEmbedCode the embed code
 * @param[in] theTitle the title
 * @param[in] theDescription the description
 * @returns the initialized OOContentItem
 */
- (id)initWithEmbedCode:(NSString *)theEmbedCode title:(NSString *)theTitle description:(NSString *)theDescription;

/** @internal
 * Initialize a OOContentItem using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOContentItem
 * @param[in] theEmbedCode the embed code to fetch from the dictionary
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @returns the initialized OOContentItem
 */
- (id)initWithDictionary:(NSDictionary *)data embedCode:(NSString *)theEmbedCode api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOContentItem using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOContentItem
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Get the promo image URL for this content item that will be at least the specified dimensions
 * @param[in] width the minimum width
 * @param[in] height the minimum height
 * @returns a string containing the promo image URL
 */
- (NSString *)getPromoImageURLForWidth:(NSInteger)width height:(NSInteger)height;

/** @internal
 * The embed codes to authorize
 * @returns the embed codes to authorize as an NSArray
 */
- (NSArray *)embedCodesToAuthorize;

/**
 * Get the first OOVideo for this OOContentItem
 * @returns the first OOVideo this OOContentItem represents
 */
- (OOVideo *)firstVideo;

/** @internal
 * Get the OOVideo in this OOContentItem with the specified embed code
 * @param[in] embedCode the embed code to look up
 * @param[in] currentItem the current OOVideo
 * @returns the video in this OOContentItem with the specified embed code
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/** @internal
 * Create a OOContentItem from the given data
 * @param[in] data the data to create the OOContentItem with
 * @param[in] embedCode the embed code to fetch from the dictionary
 * @param[in] api the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @returns the created OOContentItem (could be a Movie, OOChannel, or OOChannelSet)
 */
+ (OOContentItem *)contentItemFromDictionary:(NSDictionary *)data embedCode:(NSString *)embedCode api:(OOPlayerAPIClient *)api;

/** @internal
 * Create a OOContentItem from the given data
 * @param[in] data the data to create the OOContentItem with
 * @param[in] embedCodes the embed codes to fetch from the dictionary
 * @param[in] api the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @returns the created OOContentItem (could be a Movie, OOChannel, OODynamicChannel, or OOChannelSet)
 */
+ (OOContentItem *)contentItemFromDictionary:(NSDictionary *)data embedCodes:(NSArray *)embedCodes api:(OOPlayerAPIClient *)api;

/**
 * The total duration (not including Ads) of this OOContentItem
 * @returns an Float64 with the total duration in seconds
 */
- (Float64)duration;

@end
