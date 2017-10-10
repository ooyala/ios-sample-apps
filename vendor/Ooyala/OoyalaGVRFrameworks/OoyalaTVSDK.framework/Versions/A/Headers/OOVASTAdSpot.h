#import "OOManagedAdSpot.h"
#import "OOTBXML.h"

/**
 * Represents all VAST information from a root VAST XML file. May have multiple vast XMLs as part of the ad hierarchy.
 * \ingroup vast
 */
@interface OOVASTAdSpot : OOManagedAdSpot {
@protected
  NSString *signature;
  NSInteger expires;
  NSMutableArray *ads;
}

@property(readonly, nonatomic, strong) NSString *signature;         /**< The signature for the vast request */
@property(readonly, nonatomic) NSInteger expires;                   /**< The expires for the vast request */
@property(readonly, nonatomic, strong) NSURL *vastURL;              /**< The url for the vast request */
@property(readonly, nonatomic, strong) NSMutableArray *ads;         /**< The actual ads */
@property(readonly, nonatomic, strong) NSMutableArray *vmapAdSpots; /**< The vmap ad spots */
@property(readonly, nonatomic) NSInteger contentDuration;           /**< The duration of the ad */
@property(readonly, nonatomic, strong) NSMutableDictionary *errors;           /**< The errors of ads */


- (id)initWithOffset:(NSInteger)timeoffset duration:(NSInteger)duration Element:(OOTBXMLElement *)e;

/**
 * Initialize a OOVASTAdSpot using the VAST URL
 * @param[in] theTime the time at which to play the ad
 * @param[in] theClickURL the clickthrough URL
 * @param[in] theTrackingURLs the tracking URLs
 * @param[in] theVASTURL the VAST URL to initialize the OOVASTAdSpot with
 * @returns the initialized OOVASTAdSpot
 */
- (id)initWithTime:(NSNumber *)theTime duration:(NSInteger)duration clickURL:(NSURL *)theClickURL trackingURLs:(NSArray *)theTrackingURLs vastURL:(NSURL *)theVASTURL;


/** @internal
 * Initialize a OOVASTAdSpot using the specified data (subclasses should override this)
 * @param[in] data the NSDictionary containing the data to use to initialize this OOVASTAdSpot
 * @param[in] theAPI the OOPlayerAPIClient that was used to fetch this OOVASTAd
 * @param[in] duration the content duration
 * @returns the initialized OOVASTAdSpot
 */
- (id)initWithDictionary:(NSDictionary *)data api:(OOPlayerAPIClient *)theAPI duration:(NSInteger)duration;

/** @internal
 * Update the OOVASTAdSpot using the specified data (subclasses should override and call this)
 * @param[in] data the NSDictionary containing the data to use to update this OOVASTAdSpot
 * @returns OOReturnState.OOReturnStateFail if the parsing failed, OOReturnState.OOReturnStateMatched if it was successful
 */
- (OOReturnState)updateWithDictionary:(NSDictionary *)data;

/** @internal
 * Fetch the additional required info for the ad
 * @note As of right now, we only support VAST 2.0 Linear Ads. Information about Non-Linear and Companion Ads are stored in the dictionaries nonLinear and companion respectively.
 * @returns NO if errors occurred, YES if successful
 */
- (BOOL)fetchPlaybackInfo;

@end
