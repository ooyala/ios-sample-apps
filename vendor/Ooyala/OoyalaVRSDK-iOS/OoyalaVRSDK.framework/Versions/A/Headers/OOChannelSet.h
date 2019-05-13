/**
 * @class      OOChannelSet OOChannelSet.h "OOChannelSet.h"
 * @brief      OOChannelSet
 * @details    OOChannelSet.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
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

@property (readonly, nonatomic) NSString *nextChildren; /**< @internal the next children token */
@property (readonly, nonatomic) OOOrderedDictionary *channels; /**< The OOChannelSet's channels (keyed by embed code) */

/** @internal
 * Initialize a OOContentItem using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to initialize this OOChannelSet
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOChannelSet
 * @return the initialized OOChannelSet
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                         embedCode:(NSString *)theEmbedCode
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOChannelSet using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to update this OOChannelSet
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Get the first OOVideo for this OOChannelSet
 * @return the first OOVideo this OOChannelSet represents
 */
- (OOVideo *)firstVideo;

/** @internal
 * Get the next OOVideo for this OOChannelSet (this method should only be called at the end of a channel)
 * @param currentItem the current OOChannel
 * @return the next OOVideo from OOChannelSet
 */
- (OOVideo *)nextVideo:(OOChannel *)currentItem;

/** @internal
 * Get the previous OOVideo for this OOChannelSet (this method should only be called at the end of a channel)
 * @param currentItem the current OOChannel
 * @return the previous OOVideo from OOChannelSet
 */
- (OOVideo *)previousVideo:(OOChannel *)currentItem;

/** @internal
 * Get the OOVideo in this OOChannelSet with the specified embed code
 * @param embedCode the embed code to look up
 * @param currentItem the current OOVideo
 * @return the video in this OOChannelSet with the specified embed code
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/**
 * Find out it this OOChannelSet has more children
 * @return YES if it does, NO if it doesn't
 */
- (BOOL)hasMoreChildren;

/**
 * Fetch the additional children if they exist
 * @param callback the callback to execute when the children are fetched
 * @return YES if more children exist, NO if they don't or they are already in the process of being fetched
 */
- (BOOL)fetchMoreChildren:(OOFetchMoreChildrenCallback)callback;

/** @internal
 * Fetch and authorize more children if they exist. This method is thread safe.
 * @param callback the callback to execute when the children are fetched
 */
- (void)fetchAndAuthorizeMoreChildren:(OOFetchMoreChildrenCallback)callback;

/**
 * The number of channels this OOChannelSet has. Same as [channels count].
 * @return an NSUInteger with the number of channels
 */
- (NSUInteger)childrenCount;

/**
 * The total duration (not including Ads) of this OOChannelSet.  This only accounts for currently loaded channels.
 * @return an Float64 with the total duration in seconds
 */
- (Float64)duration;

@end
