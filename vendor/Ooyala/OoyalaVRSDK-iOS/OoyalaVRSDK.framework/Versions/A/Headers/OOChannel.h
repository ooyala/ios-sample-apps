/**
 * @class      OOChannel OOChannel.h "OOChannel.h"
 * @brief      OOChannel
 * @details    OOChannel.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOContentItem.h"
#import "OOPaginatedParentItem.h"

@class OOOrderedDictionary;
@class OOVideo;
@class OOChannelSet;
@class OOOoyalaError;

/**
 * A OOContentItem which contains other items, representing a single channel as defined in Backlot.
 */
@interface OOChannel : OOContentItem <OOPaginatedParentItem> {
@protected
  OOOrderedDictionary *videos;
  OOChannelSet *parent;
}

@property (readonly, nonatomic) NSString *nextChildren; /**< @internal the next children token */
@property (readonly, nonatomic) OOOrderedDictionary *videos; /**< The OOChannel's videos (keyed by embed code) */
@property (readonly, nonatomic) OOChannelSet *parent; /**< This OOChannel's parent OOChannelSet if it exists */

/** @internal
 * Initialize a OOChannel using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to initialize this OOChannel
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOChannel
 * @return the initialized OOChannel
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                         embedCode:(NSString *)theEmbedCode
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Initialize a OOChannel using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to initialize this OOChannel
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theParent the parent OOChannelSet of this OOChannel
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOChannel
 * @return the initialized OOChannel
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                         embedCode:(NSString *)theEmbedCode
                            parent:(OOChannelSet *)theParent
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOChannel using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to update this OOChannel
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Get the first OOVideo for this OOChannel
 * @return the first OOVideo this OOChannel represents
 */
- (OOVideo *)firstVideo;

/**
 * Get the last OOVideo for this OOChannel
 * @return the last OOVideo this OOChannel represents
 */
- (OOVideo *)lastVideo;

/** @internal
 * Get the next OOVideo for this OOChannel
 * @param currentItem the current OOVideo
 * @return the next OOVideo from OOChannel
 */
- (OOVideo *)nextVideo:(OOVideo *)currentItem;

/** @internal
 * Get the previous OOVideo for this OOChannel
 * @param currentItem the current OOVideo
 * @return the previous OOVideo from OOChannel
 */
- (OOVideo *)previousVideo:(OOVideo *)currentItem;

/** @internal
 * Get the OOVideo in this OOChannel with the specified embed code
 * @param embedCode the embed code to look up
 * @param currentItem the current OOVideo
 * @return the video in this channel with the specified embed code
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/**
 * Find out it this OOChannel has more children
 * @return YES if it does, NO if it doesn't
 */
- (BOOL)hasMoreChildren;

/**
 * Fetch the additional children if they exist. This will happen in the background and callback will be called when the fetch is complete.
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
 * The number of videos this OOChannel has. Same as [videos count].
 * @return an NSUInteger with the number of videos
 */
- (NSUInteger)childrenCount;

/**
 * The total duration (not including Ads) of this OOChannel
 * @return an Float64 with the total duration in seconds
 */
- (Float64)duration;

@end
