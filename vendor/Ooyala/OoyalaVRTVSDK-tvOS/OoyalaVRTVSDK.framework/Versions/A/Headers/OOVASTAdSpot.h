#import "OOManagedAdSpot.h"
#import "OOTBXML.h"
#import "OOEnums.h"

@class OOPlayerAPIClient;
@class OOContentTreeAd;

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

@property (readonly, nonatomic) NSString *signature;         /**< The signature for the vast request */
@property (readonly, nonatomic) NSInteger expires;           /**< The expires for the vast request */
@property (readonly, nonatomic) NSURL *vastURL;              /**< The url for the vast request */
@property (readonly, nonatomic) NSMutableArray *ads;         /**< The actual ads */
@property (readonly, nonatomic) NSMutableArray *vmapAdSpots; /**< The vmap ad spots */
@property (readonly, nonatomic) NSInteger contentDuration;   /**< The duration of the ad */
@property (readonly, nonatomic) NSMutableDictionary *errors; /**< The errors of ads */


- (instancetype)initWithOffset:(NSInteger)timeoffset
                      duration:(NSInteger)duration
                       element:(OOTBXMLElement *)e;

/**
 * Initialize a OOVASTAdSpot using the VAST URL
 * @param theTime the time at which to play the ad
 * @param theClickURL the clickthrough URL
 * @param theTrackingURLs the tracking URLs
 * @param theVASTURL the VAST URL to initialize the OOVASTAdSpot with
 * @return the initialized OOVASTAdSpot
 */
- (instancetype)initWithTime:(NSNumber *)theTime
                    duration:(NSInteger)duration
                    clickURL:(NSURL *)theClickURL
                trackingURLs:(NSArray *)theTrackingURLs
                     vastURL:(NSURL *)theVASTURL;


/** @internal
 * Initialize a OOVASTAdSpot using the specified data (subclasses should override this)
 * @param contentTreeAd a @c OOContentTreeAd containing the data to use to initialize this OOVASTAdSpot
 * @param theAPI the OOPlayerAPIClient that was used to fetch this OOVASTAd
 * @param duration the content duration
 * @return the initialized OOVASTAdSpot
 */
- (instancetype)initWithContentTreeAd:(OOContentTreeAd *)contentTreeAd
                                  api:(OOPlayerAPIClient *)theAPI
                             duration:(NSInteger)duration;

/** @internal
 * Fetch the additional required info for the ad
 * @note As of right now, we only support VAST 2.0 Linear Ads. Information about Non-Linear and Companion Ads are stored in the dictionaries nonLinear and companion respectively.
 */
- (BOOL)fetchPlaybackInfo;

@end
