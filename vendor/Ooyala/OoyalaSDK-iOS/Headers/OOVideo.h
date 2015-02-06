/**
 * @class      OOVideo OOVideo.h "OOVideo.h"
 * @brief      OOVideo
 * @details    OOVideo.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOPlayableItem.h"
#import "OOContentItem.h"

@class OOManagedAdSpot;
@class OOPlayerAPIClient;
@class OOChannel;
@class OOClosedCaptions;

@interface OOVideo : OOContentItem <OOPlayableItem> {
@protected
  NSMutableArray *ads;
  OOClosedCaptions *closedCaptions;
  OOChannel *parent;
  Float64 duration;
  BOOL live;
}

@property(readonly, nonatomic, strong) NSMutableArray *ads;            /**< @internal An NSMutableArray containing the ads */
@property(readonly, nonatomic, strong) OOClosedCaptions *closedCaptions; /**< @internal An NSMutableArray containing the closedCaptions */
@property(readonly, nonatomic, strong) OOChannel *parent;                /**< This OOVideo's parent OOChannel if it exists (could be a OODynamicChannel) */
@property(readonly, nonatomic) Float64 duration;                       /**< The OOVideo's Total Duration (Length) */
@property(readonly, nonatomic) BOOL live;                              /**< Whether or not the video is live */

/** @internal
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOVideo
 * @param[in] theEmbedCode the embed code to fetch from the dictionary
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOVideo
 * @returns the initialized OOVideo
 */
- (id)initWithDictionary:(NSDictionary *)data embedCode:(NSString *)theEmbedCode api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOVideo
 * @param[in] theEmbedCode the embed code to fetch from the dictionary
 * @param[in] theParent the parent OOChannel of this OOVideo
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOVideo
 * @returns the initialized OOVideo
 */
- (id)initWithDictionary:(NSDictionary *)data embedCode:(NSString *)theEmbedCode parent:(OOChannel *)theParent api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOVideo using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOVideo
 * @returns a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/**
 * Get the first OOVideo for this OOVideo, which is this OOVideo
 * @returns self
 */
- (OOVideo *)firstVideo;

/**
 * Get the next OOVideo for this OOVideo from the parent
 * @returns nil if this is the last OOVideo or there is no parent, otherwise the next OOVideo
 */
- (OOVideo *)nextVideo;

/**
 * Get the previous OOVideo for this OOVideo from the parent
 * @returns nil if this is the first OOVideo or there is no parent, otherwise the previous OOVideo
 */
- (OOVideo *)previousVideo;

/** @internal
 * Get the OOVideo with the specified embed code
 * @param[in] embedCode the embed code to look up
 * @param[in] currentItem the current OOVideo
 * @returns the video if embed code matches, else nil
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/** @internal
 * Fetch the additional required info for playback (ads and closed captions)
 * @returns NO if errors occurred or YES if successful
 */
- (BOOL)fetchPlaybackInfo;

/**
 * @internal
 */
- (id)fetchPlaybackInfo:(void (^)(BOOL))callback;

/**
 * Check if the OOVideo has ads
 * @returns whether the OOVideo has ads or not
 */
- (BOOL)hasAds;

/**
 * Check if the OOVideo has Closed Captions
 * @returns whether the OOVideo has closed captions or not
 */
- (BOOL)hasClosedCaptions;

/**
 * Insert an OOAdSpot to play during this video
 * @param ad the OOAdSpot to play during this video
 */
- (void)insertAd:(OOManagedAdSpot *)ad;

/**
 * Edit the list of ads, allowing for removal of ads.
 * @param block returns TRUE for ads to keep, FALSE for ads to remove.
 */
-(void)filterAds:(NSPredicate*)predicate;

@end
