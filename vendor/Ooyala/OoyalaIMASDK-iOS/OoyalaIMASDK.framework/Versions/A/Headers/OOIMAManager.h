/**
 * @class      OOIMAManager OOIMAManager.h "OOIMAManager.h"
 * @copyright  Copyright © 2013 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

#ifdef OoyalaVRSDK_h
  #import <OoyalaVRSDK/OoyalaVRSDK.h>
#else
  #import "OOAdPlugin.h"
#endif


@protocol IMAAdPlaybackInfo;

@class OOStateNotifier;
@class OOOoyalaPlayer;
@class OOIMAConfiguration;
@class OOIMAAdPlayer;
@class OOAdSpotManager;

@class IMAAdsManager;
@class IMAAdsLoader;
@class IMAAdEvent;
@class IMAAdsLoadedData;
@class IMAAdDisplayContainer;

@protocol OOIMAManagerDelegate
- (void)adsReady;
- (void)onError;
@end

@protocol OOIMAAdsManagerDelegate
- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event;
- (void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager;
- (void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager;
- (void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData;
- (void)displayContainerUpdated:(IMAAdDisplayContainer *)adDisplayContainer;
@end

@interface OOIMAManager : NSObject<OOAdPlugin>

@property (nonatomic, weak) id<OOIMAManagerDelegate> delegate;
@property (nonatomic, readonly) id<IMAAdPlaybackInfo> adPlaybackInfo;
@property (nonatomic, readonly) IMAAdDisplayContainer *adDisplayContainer;
@property (readonly) OOStateNotifier *stateNotifier;

@property (nonatomic, weak) id<OOIMAAdsManagerDelegate> imaAdsManagerDelegate;

/**
 * Configure IMA ads from given URL.
 * You do not need to do this if a VAST URL is properly configured in Third Party Module Metadata.
 * It is not advised usage to manually load an IMA VAST URL while any IMA URL is configured in Third Party
 * Module Metadata.
 */
@property (nonatomic) NSString *adUrlOverride;

/**
 * Configure VAST load timeout in milliseconds for Google IMA AdRequests.
 * This parameter will override the default timeout set by Google IMA.
 */
@property (nonatomic) float vastLoadTimeout;

/**
 * Initialize a OOIMAManager using the OOOoyalaPlayer
 * @param player the OOOoyalaPlayer
 * @return the initialized OOIMAManager
 */
- (instancetype)initWithOoyalaPlayer:(OOOoyalaPlayer *)player;

/**
 * Initialize a OOIMAManager using the OOOoyalaPlayer and an Ooyala IMA Configuration
 * @param player the OOOoyalaPlayer
 * @param configuration the OOIMAConfiguration to configure the Ooyala IMA Integration. can be nil

 * @return the initialized OOIMAManager
 */
- (instancetype)initWithOoyalaPlayer:(OOOoyalaPlayer *)player
                       configuration:(OOIMAConfiguration *)configuration;

/**
 * Add a compnanionSlot to AdsPlayer
 * @param slot the UIView the user wants to use to hold the slot
 * NOTE: this UIView cannot be changed to fit the screen automatically so the companion slots 
 * may be located inappropriately when the orientation changed
 */
- (void)addCompanionSlot:(UIView *)slot;

/**
 * Add tag parameters to the end of the original URL for ads request.
 * The parameters will be overridden by the latest call if this method get called multiple times
 * @param adTagParameters A dictionary of the key-value pairs to be appended to the tag as query string parameters */
- (void)setAdTagParameters:(NSDictionary*)adTagParameters;

/**
 * Play, or queue up automatic playing of ads if they are still loading.
 * This is meant to be called only by the OOIMAAdPlayer.
 */
- (void)play;

/**
 * Pause currently playing ad.
 * This is meant to be called only by the OOIMAAdPlayer.
 */
- (void)pause;

/**
 * Parse all_ads metadata obtained in https://player.ooyala.com/player_api/v1/metadata/embed_code/
 * @param adsMetadata as NSMutableArray
 * @return ad spot as OOAdSpotManager
 */
- (OOAdSpotManager *)parseAllAdsMetadata:(NSMutableArray *)adsMetadata;

@end
