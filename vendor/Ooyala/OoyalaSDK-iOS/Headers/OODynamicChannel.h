/**
 * @class      OODynamicChannel OODynamicChannel.h "OODynamicChannel.h"
 * @brief      OODynamicChannel
 * @details    OODynamicChannel.h in OoyalaSDK
 * @date       11/30/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOChannel.h"

/**
 * A OOContentItem which contains other items, dynamically created out of list of embed codes.
 *
 * Use OOOoyalaPlayer::setEmbedCodes: method to create a dynamic channel out of list of embed codes
 */
@interface OODynamicChannel : OOChannel {
@protected
  NSArray *embedCodes;
}

/** Ordered list of embed codes */
@property(readonly, nonatomic, strong) NSArray *embedCodes;

/** @internal
 * Initialize a OODynamicChannel using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OODynamicChannel
 * @param[in] theEmbedCodes the embed codes to fetch from the dictionary (ordered)
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OODynamicChannel
 * @returns the initialized OODynamicChannel
 */
- (id)initWithDictionary:(NSDictionary *)data embedCodes:(NSArray *)theEmbedCodes api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Initialize a OODynamicChannel using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OODynamicChannel
 * @param[in] theEmbedCodes the embed codes to fetch from the dictionary (ordered)
 * @param[in] theParent the parent OOChannelSet of this OODynamicChannel
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OODynamicChannel
 * @returns the initialized OODynamicChannel
 */
- (id)initWithDictionary:(NSDictionary *)data embedCodes:(NSArray *)theEmbedCodes parent:(OOChannelSet *)theParent api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OODynamicChannel using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OODynamicChannel
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * The embed codes to authorize
 * @returns the embed codes to authorize as an NSArray
 */
- (NSArray *)embedCodesToAuthorize;

/**
 * The total duration (not including Ads) of this OODynamicChannel
 * @returns an Float64 with the total duration in seconds
 */
- (Float64)duration;

@end
