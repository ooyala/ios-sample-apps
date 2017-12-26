/**
 * @class      OOChannelSet OOChannelSet.h "OOChannelSet.h"
 * @brief      OOChannelSet
 * @details    OOChannelSet.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOContentItem.h"
#import "OOPaginatedParentItem.h"

@class OOOrderedDictionary;
@class OOChannel;
@class OOOoyalaError;

/**
 * A OOContentItem which contains channels, representing a single channel set as defined in Backlot.
 */
@interface OOChannelSet : OOContentItem <OOPaginatedParentItem> {
@protected
  OOOrderedDictionary *channels;
}

@property(readonly, nonatomic, strong) NSString *nextChildren; /**< @internal the next children token */
@property(readonly, nonatomic, strong) OOOrderedDictionary *channels; /**< The OOChannelSet's channels (keyed by embed code) */

/** @internal
 * Initialize a OOContentItem using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOChannelSet
 * @param[in] theEmbedCode the embed code to fetch from the dictionary
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOChannelSet
 * @returns the initialized OOChannelSet
 */
- (id)initWithDictionary:(NSDictionary *)data embedCode:(NSString *)theEmbedCode api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOChannelSet using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOChannelSet
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Get the first OOVideo for this OOChannelSet
 * @returns the first OOVideo this OOChannelSet represents
 */
- (OOVideo *)firstVideo;

/** @internal
 * Get the next OOVideo for this OOChannelSet (this method should only be called at the end of a channel)
 * @param[in] currentItem the current OOChannel
 * @returns the next OOVideo from OOChannelSet
 */
- (OOVideo *)nextVideo:(OOChannel *)currentItem;

/** @internal
 * Get the previous OOVideo for this OOChannelSet (this method should only be called at the end of a channel)
 * @param[in] currentItem the current OOChannel
 * @returns the previous OOVideo from OOChannelSet
 */
- (OOVideo *)previousVideo:(OOChannel *)currentItem;

/** @internal
 * Get the OOVideo in this OOChannelSet with the specified embed code
 * @param[in] embedCode the embed code to look up
 * @param[in] currentItem the current OOVideo
 * @returns the video in this OOChannelSet with the specified embed code
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/**
 * Find out it this OOChannelSet has more children
 * @returns YES if it does, NO if it doesn't
 */
- (BOOL)hasMoreChildren;

/**
 * Fetch the additional children if they exist
 * @param[in] callback the callback to execute when the children are fetched
 * @returns YES if more children exist, NO if they don't or they are already in the process of being fetched
 */
- (BOOL)fetchMoreChildren:(OOFetchMoreChildrenCallback)callback;

/** @internal
 * Fetch and authorize more children if they exist. This method is thread safe.
 * @param[in] callback the callback to execute when the children are fetched
 * @returns YES if more children exist, NO if they don't or they are already in the process of being fetched
 */
- (BOOL)fetchAndAuthorizeMoreChildren:(OOFetchMoreChildrenCallback)callback;

/**
 * The number of channels this OOChannelSet has. Same as [channels count].
 * @returns an NSUInteger with the number of channels
 */
- (NSUInteger)childrenCount;

/**
 * The total duration (not including Ads) of this OOChannelSet.  This only accounts for currently loaded channels.
 * @returns an Float64 with the total duration in seconds
 */
- (Float64)duration;

@end
