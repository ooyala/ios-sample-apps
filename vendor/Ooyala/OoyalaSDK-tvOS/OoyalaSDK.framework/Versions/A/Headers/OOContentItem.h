/**
 * @class      OOContentItem OOContentItem.h "OOContentItem.h"
 * @brief      OOContentItem
 * @details    OOContentItem.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

#import "OOAuthCode.h"
#import "OOEnums.h"

@class OOPlayerAPIClient;
@class OOVideo;
@class OOFCCTVRating;
@class SsaiMetadata;
@class OOContentTree;
@class OOAuthorization;
@class OOMetadata;
@class OOMetadataIMAAd;
@class OOMarker;

/**
 * A single playable content item, such as video
 */
@interface OOContentItem : NSObject {
@protected
  NSString *embedCode;
  NSString *externalId;
  NSString *title;
  NSString *itemDescription;
  NSString *promoImageURL;
  NSString *hostedAtURL;    
  OOPlayerAPIClient *api;
  BOOL authorized;
  BOOL haEnabled;
  OOAuthCode authCode;
  SsaiMetadata *ssaiMetadata;
  NSString *contentType;
}

@property (readonly, nonatomic) NSString *embedCode;        /**< The OOContentItem's Embed Code */
@property (readonly, nonatomic) NSString *externalId;       /**< The OOContentItem's External ID if it exists */
@property (readonly, nonatomic) NSString *title;            /**< The OOContentItem's Title */
@property (readonly, nonatomic) NSString *itemDescription;  /**< The OOContentItem's Description */
@property (readonly, nonatomic) NSString *promoImageURL;    /**< The OOContentItem's Promo Image URL */
@property (readonly, nonatomic) NSString *hostedAtURL;      /**< The OOContentItem's Hosted At URL */
@property (readonly, nonatomic) NSString *markersURL;       /**< The OOContentItem's Chapter Markers URL */
@property (readonly, nonatomic) NSArray<OOMarker *> *markerList;   /**< The OOContentItem's Chapter Markers */
@property (readonly, nonatomic) OOPlayerAPIClient *api;     /**< @internal The API that was used to fetch the OOContentItem */
@property (readonly, nonatomic) BOOL authorized;            /**< Whether or not this OOContentItem is authorized */
@property (readonly, nonatomic) OOAuthCode authCode;        /**< The response code from the authorize call */

@property (readonly, nonatomic) NSDictionary *moduleData;
@property (readonly, nonatomic) BOOL heartbeatRequired;
@property (readonly, nonatomic) OOFCCTVRating *tvRating;
@property (readonly, nonatomic) NSString *assetPcode;       /**< The OOContentItem's Promo Image URL */
@property (readonly, nonatomic) BOOL haEnabled;
@property (readonly, nonatomic) BOOL needsMidStreamCheck;
@property (readonly, nonatomic) int midStreamCheckInterval;
@property (readonly, nonatomic) SsaiMetadata *ssaiMetadata;
@property (readonly, nonatomic) NSString *contentType;
@property (readonly, nonatomic) NSArray<OOMetadataIMAAd *> *externalAds;

/**
 * Initialize a OOContentItem
 * @param theEmbedCode the embed code
 * @param theTitle the title
 * @param theDescription the description
 * @return the initialized OOContentItem
 */
- (instancetype)initWithEmbedCode:(NSString *)theEmbedCode
                            title:(NSString *)theTitle
                      description:(NSString *)theDescription;

/** @internal
 * Initialize a OOContentItem using the specified data (subclasses should override this)
 * @param contentTree an instance of @c OOContentTree fetched from content_tree request
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @return the initialized OOContentItem
 */
- (instancetype)initWithContentTree:(OOContentTree *)contentTree
                          embedCode:(NSString *)theEmbedCode
                                api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the @c OOContentItem using the content_tree data (subclasses should override and call this)
 * @param contentTree the @c OOContentTree containing the data from content_tree request
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithContentTree:(OOContentTree *)contentTree;
/** @internal
 * Update the @c OOContentItem using the authorization data (subclasses should override and call this)
 * @param authorization the @c OOAuthorization containing the data from authorization request
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithAuthorization:(OOAuthorization *)authorization;
/** @internal
 * Update the @c OOContentItem using the metadata data (subclasses should override and call this)
 * @param metadata the @c OOMetadata containing the data from metadata request
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithMetadata:(OOMetadata *)metadata;

/**
 * Get the promo image URL for this content item that will be at least the specified dimensions
 * @param width the minimum width
 * @param height the minimum height
 * @return a string containing the promo image URL
 */
- (NSString *)getPromoImageURLForWidth:(NSInteger)width height:(NSInteger)height;

/** @internal
 * The embed codes to authorize
 * @return the embed codes to authorize as an NSArray
 */
- (NSArray *)embedCodesToAuthorize;

/**
 * Get the first OOVideo for this OOContentItem
 * @return the first OOVideo this OOContentItem represents
 */
- (OOVideo *)firstVideo;

/** @internal
 * Get the OOVideo in this OOContentItem with the specified embed code
 * @param embedCode the embed code to look up
 * @param currentItem the current OOVideo
 * @return the video in this OOContentItem with the specified embed code
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode
                withCurrentItem:(OOVideo *)currentItem;

/** @internal
 * Create a OOContentItem from the given data
 * @param contentTree an instance of @c OOContentTree fetched from content_tree request
 * @param embedCode the embed code to fetch from the dictionary
 * @param api the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @return the created OOContentItem (could be a Movie, OOChannel, or OOChannelSet)
 */
+ (OOContentItem *)contentItemFromContentTree:(OOContentTree *)contentTree
                                    embedCode:(NSString *)embedCode
                                          api:(OOPlayerAPIClient *)api;

/** @internal
 * Create a OOContentItem from the given data
 * @param contentTree an instance of @c OOContentTree fetched from content_tree request
 * @param embedCodes the embed codes to fetch from the dictionary
 * @param api the OOPlayerAPIClient that was used to fetch this OOContentItem
 * @return the created OOContentItem (could be a Movie, OOChannel, OODynamicChannel, or OOChannelSet)
 */
+ (OOContentItem *)contentItemFromContentTree:(OOContentTree *)contentTree
                                   embedCodes:(NSArray *)embedCodes
                                          api:(OOPlayerAPIClient *)api;

/**
 * The total duration (not including Ads) of this OOContentItem
 * @return an Float64 with the total duration in seconds
 */
- (Float64)duration;

/**
 * Creates an JSON array of OOMarkers
 * @returns the array of OOMarkers
 */
- (NSArray *)markersJSONArray;

@end
