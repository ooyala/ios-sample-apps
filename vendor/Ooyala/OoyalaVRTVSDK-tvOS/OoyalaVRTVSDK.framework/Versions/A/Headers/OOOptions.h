@import Foundation;

@class OOFCCTVRatingConfiguration;
@class OOIQConfiguration;
@protocol AVPictureInPictureControllerDelegate;
@protocol OOPlayerInfo;
@protocol OOSecureURLGenerator;

/**
 Configurations to change the behavior of the OoyalaPlayer
 */
@interface OOOptions : NSObject
/**
 tvRatingConfiguration TV rating configuration object for current OoyalaPlayer

 @discussion Default: default setting object for OOFCCTVRatingConfiguration
 */
@property (nonatomic, nonnull) OOFCCTVRatingConfiguration *tvRatingConfiguration;
/**
 iqConfiguration iq configuration object for current player

 @discussion Default: default analytics values object like playerID for OOiqConfiguration
 */
@property (nonatomic, nonnull) OOIQConfiguration *iqConfiguration;
/**
 Show cue points for ads if this is set to YES; Default: YES
 */
@property (nonatomic) BOOL showCuePoints;
/**
 If set to YES, show the live content scrubber during live content playback (for live stream only).
 @discussion Default: @c YES
 */
@property (nonatomic) BOOL showLiveContentScrubber;
/**
 If set to YES, show ads controls (show the scrubber) during ad playback.
 @discussion Default: @c YES
 */
@property (nonatomic) BOOL showAdsControls;
/**
 If set to @c YES, load the content when the required information and authorization is available.If set to @c NO,
 load the content after the pre-roll (if a pre-roll is available).
 @discussion Default: @c YES
 */
@property (nonatomic) BOOL preloadContent;
/**
 If set to @c YES, show the promo image if a promo image is available.
 @discussion Default: @c NO
 */
@property (nonatomic) BOOL showPromoImage;
/**
 The timeout value for network requests.
 @discussion Default: 60.0 seconds
 */
@property (nonatomic) NSTimeInterval connectionTimeout;
/**
 Helper for signing URLs with provider's secret and API key.
 */
@property (nonatomic, nullable) id<OOSecureURLGenerator> secureURLGenerator;
/**
 Enables PiP mode for devices that support it.
 This does not activate PiP, it will only instantiate the necessary objects needed for PiP mode.
 @discussion Default: @c NO
 */
@property (nonatomic) BOOL enablePictureInPictureSupport;
/**
 The picture in picture delegate to receive PIP events
 */
@property (weak, nonatomic, nullable) id<AVPictureInPictureControllerDelegate> pipDelegate;
/**
 Bypass the check to ensure the provided PCode matches the asset's Pcode
 */
@property (nonatomic) BOOL bypassPCodeMatching;
/**
 The PlayerInfo used when making network requests to the Ooyala servers
 */
@property (nonatomic, nullable) id<OOPlayerInfo> playerInfo;
/**
 Disable the support of VAST and Ooyala Ads that is enabled in the SDK by default
 */
@property (nonatomic) BOOL disableVASTOoyalaAds;
/**
 Dynamic Filters to be sent to Azure
 */
@property (nonatomic, nullable) NSArray<NSString *> *dynamicFilters;
/**
 Will try to play the video using HEVC, if possible
 */
@property (nonatomic, getter=isHEVCEnabled) BOOL HEVCEnabled;
/**
 The initial playback speed rate. Default 1.0.
 @warning: Not working for live, Ad's and VR assets.
 */
@property (nonatomic) Float64 initialPlaybackSpeedRate;
/**
 Markers Inline to be added using an external file or with @c NSDictionary definiton
 */
@property (nonatomic, nullable) NSDictionary *markers;

/**
 Initialize an @c OOOptions object with the all properties with default values
 @return the initialized object
 */
- (nonnull instancetype)init;

/**
 Logs all properties that are part of this OOOptions.
 */
- (void)logProperties;

@end
