/**
 * @class      OOVideo OOVideo.h "OOVideo.h"
 * @brief      OOVideo
 * @details    OOVideo.h in OoyalaSDK
 * @date       11/21/11
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import "OOPlayableItem.h"
#import "OOContentItem.h"

@class OOManagedAdSpot;
@class OOPlayerAPIClient;
@class OOChannel;
@class OOClosedCaptions;
@class OOUnbundledVideo;
@class SsaiMetadata;

/**
 * this class implements video stream object
 */
@interface OOVideo : OOContentItem <OOPlayableItem> {
@protected
  NSMutableArray *ads;
  OOClosedCaptions *closedCaptions;
  OOChannel *parent;
  Float64 duration;
  BOOL live;
}

@property (readonly, nonatomic) NSMutableArray *ads;                    /**< @internal An NSMutableArray containing the ads */
@property (readonly, nonatomic) OOClosedCaptions *closedCaptions;       /**< @internal An NSMutableArray containing the closedCaptions */
@property (readonly, nonatomic) OOChannel *parent;                      /**< This OOVideo's parent OOChannel if it exists (could be a OODynamicChannel) */
@property (readonly, nonatomic) Float64 duration;                       /**< The OOVideo's Total Duration (Length) */
@property (readonly, nonatomic) BOOL live;                              /**< Whether or not the video is live */
@property (readonly, nonatomic) NSURL *fairplayKeyURL;                  /**< If this is an offline Fairplay asset, this is where the Fairplay key is located */
@property (nonatomic) int retryCount;                                   /**< Keeps track of the number of retries already done for a given error. Used by the HA plugin to try an reset the video with the player. */
@property (readonly, nonatomic) NSString *defaultLanguageCode;          /**< The OOContentItem's Default language Code (eng, deu etc.) */

/**
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param unbundledVideo defines the streams and ads to use initializing the OOVideo.
 */
- (instancetype)initWithUnbundledVideo:(OOUnbundledVideo*)unbundledVideo;

/** @internal
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param theStreams NSArray containing OOStreams.
 * @param theAds NSArray containing OOManagedAdSpots.
 */
- (instancetype)initWithUnbundledStreams:(NSArray*)theStreams ads:(NSArray*)theAds;

/** @internal
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param data the NSDictionary containing the data to use to initialize this OOVideo
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOVideo
 * @return the initialized OOVideo
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                         embedCode:(NSString *)theEmbedCode
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Initialize a OOVideo using the specified data (subclasses should override this)
 * @param data the NSDictionary containing the data to use to initialize this OOVideo
 * @param theEmbedCode the embed code to fetch from the dictionary
 * @param theParent the parent OOChannel of this OOVideo
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOVideo
 * @return the initialized OOVideo
 */
- (instancetype)initWithDictionary:(NSDictionary *)data
                         embedCode:(NSString *)theEmbedCode
                            parent:(OOChannel *)theParent
                               api:(OOPlayerAPIClient *)theAPI;

/** @internal
 * Update the OOVideo using the specified data (subclasses should override and call this)
 * @param data the NSDictionary containing the data to use to update this OOVideo
 * @return a OOReturnState based on if the data matched or not (or parsing failed)
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * Update the OOVideo high availability parameters using the specified data
 * @param data the NSDictionary containing the data to use to update this OOVideo
 * @return a BOOL value based on if the data matched or not (or parsing failed)
 */
- (BOOL)updateHighAvailabilityWithDictionary:(NSDictionary *)data;

/**
 * Get the first OOVideo for this OOVideo, which is this OOVideo
 * @return self
 */
- (OOVideo *)firstVideo;

/**
 * Get the next OOVideo for this OOVideo from the parent
 * @return nil if this is the last OOVideo or there is no parent, otherwise the next OOVideo
 */
- (OOVideo *)nextVideo;

/**
 * Get the previous OOVideo for this OOVideo from the parent
 * @return nil if this is the first OOVideo or there is no parent, otherwise the previous OOVideo
 */
- (OOVideo *)previousVideo;

/** @internal
 * Get the OOVideo with the specified embed code
 * @param embedCode the embed code to look up
 * @param currentItem the current OOVideo
 * @return the video if embed code matches, else nil
 */
- (OOVideo *)videoFromEmbedCode:(NSString *)embedCode withCurrentItem:(OOVideo *)currentItem;

/** @internal
 * Fetch the additional required info for playback (ads and closed captions)
 * @return NO if errors occurred or YES if successful
 */
- (BOOL)fetchPlaybackInfo;

/**
 * @internal
 */
- (id)fetchPlaybackInfo:(void (^)(BOOL))callback;


/**
 * Check if the OOVideo has ads
 * @return whether the OOVideo has ads or not
 */
- (BOOL)hasAds;

/**
 * Check if the OOVideo has Closed Captions
 * @return whether the OOVideo has closed captions or not
 */
- (BOOL)hasClosedCaptions;

/**
 * Insert an OOAdSpot to play during this video
 * @param ad the OOAdSpot to play during this video
 */
- (void)insertAd:(OOManagedAdSpot *)ad;

/**
 * Edit the list of ads, allowing for removal of ads.
 * @param predicate block that returns TRUE for ads to keep, FALSE for ads to remove.
 */
-(void)filterAds:(NSPredicate*)predicate;

-(BOOL)isSsaiEnabled;

@end
