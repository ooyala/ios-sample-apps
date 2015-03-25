/**
 * @class      OOOptions OOOptions.h "OOOptions.h"
 * @brief      OOOptions
 * @details    OOOptions.h in OoyalaSDK
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class OOFCCTVRatingConfiguration;

/**
 * A Class that implements configurable options
 */
@interface OOOptions : NSObject

@property (nonatomic) OOFCCTVRatingConfiguration *tvRatingConfiguration; /** tvRatingConfiguration TV rating configuration object for current OoyalaPlayer; Default: default setting object for OOFCCTVRatingConfiguration */
@property (nonatomic) BOOL showCuePoints; /** Show cue points for ads if this is set to YES; Default: YES */
@property (nonatomic) BOOL showLiveContentScrubber; /** If set to YES, show the live content scrubber during live content playback (for live stream only). Default: YES */
@property (nonatomic) BOOL showAdsControls; /** If set to YES, show ads controls (show the scrubber) during ad playback. Default: YES */
@property (nonatomic) BOOL preloadContent; /** If set to YES, load the content when the required information and authorization is available.If set to NO,  load the content after the pre-roll (if a pre-roll is available). Default: YES */
@property (nonatomic) BOOL showPromoImage; /** If set to YES, show the promo image if a promo image is available. Default: NO */
@property (nonatomic) NSTimeInterval connectionTimeout; /** The timeout value for network requests. Default: 60.0 seconds */

/**
 * Initialize an OOOptions object with the all properties with default values
 * @returns the initialized OOOptions
 */
-(instancetype) init;

/**
 * Initialize an OOOptions object with the given parameters
 * @returns the initialized OOOptions
 */
-(instancetype) initWithTVRatingsConfiguration:(OOFCCTVRatingConfiguration *)tvRatingConfiguration
                                 showCuePoints:(BOOL)showCuePoints
                       showLiveContentScrubber:(BOOL)showLiveContentScrubber
                               showAdsControls:(BOOL)showAdsControls
                                preloadContent:(BOOL)preloadContent
                                showPromoImage:(BOOL)showPromoImage
                             connectionTimeout:(NSTimeInterval)connectionTimeout;

@end