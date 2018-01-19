#import <Foundation/Foundation.h>
#import "OOSecureURLGenerator.h"

@class OOFCCTVRatingConfiguration;
@class OOIQConfiguration;
@protocol AVPictureInPictureControllerDelegate;

/**
 * Configurations to change the behavior of the OoyalaPlayer
 * \ingroup key
 */
@interface OOOptions : NSObject

@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration; /** tvRatingConfiguration TV rating configuration object for current OoyalaPlayer; Default: default setting object for OOFCCTVRatingConfiguration */
@property (nonatomic) OOIQConfiguration *iqConfiguration; /** iqConfiguration iq configuration object for current player; Default: default analytics values object like playerID for OOiqConfiguration */
@property (nonatomic) BOOL showCuePoints; /** Show cue points for ads if this is set to YES; Default: YES */
@property (nonatomic) BOOL showLiveContentScrubber; /** If set to YES, show the live content scrubber during live content playback (for live stream only). Default: YES */
@property (nonatomic) BOOL showAdsControls; /** If set to YES, show ads controls (show the scrubber) during ad playback. Default: YES */
@property (nonatomic) BOOL preloadContent; /** If set to YES, load the content when the required information and authorization is available.If set to NO,  load the content after the pre-roll (if a pre-roll is available). Default: YES */
@property (nonatomic) BOOL showPromoImage; /** If set to YES, show the promo image if a promo image is available. Default: NO */
@property (nonatomic) NSTimeInterval connectionTimeout; /** The timeout value for network requests. Default: 60.0 seconds */
@property (nonatomic) id<OOSecureURLGenerator> secureURLGenerator; /** Helper for signing URLs with provider's secret and API key. */
@property (weak, nonatomic) id<AVPictureInPictureControllerDelegate> pipDelegate; /** The picture in picture delegate to receive PIP events*/
@property (nonatomic) BOOL bypassPCodeMatching; /** Bypass the check to ensure the provided PCode matches the asset's Pcode */
@property (nonatomic) BOOL disableVASTOoyalaAds; /** Disable the support of VAST and Ooyala Ads that is enabled in the SDK by default */
/**
 * Initialize an OOOptions object with the all properties with default values
 * @returns the initialized OOOptions
 */
-(instancetype) init;

/**
 * Logs all properties that are part of this OOOptions.
 *
 */
-(void) logProperties;

@end
