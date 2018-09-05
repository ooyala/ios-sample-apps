/**
 * @class      OOIMAManager OOIMAManager.h "OOIMAManager.h"
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef OoyalaVRSDK_h
  #import <OoyalaVRSDK/OoyalaVRSDK.h>
#else
  #import <OoyalaSDK/OOAdPlugin.h>
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
-(void)adsReady;
-(void)onError;
@end

@protocol OOIMAAdsManagerDelegate
-(void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event;
-(void)adsManagerDidRequestContentResume:(IMAAdsManager *)adsManager;
-(void)adsManagerDidRequestContentPause:(IMAAdsManager *)adsManager;
-(void)adsLoader:(IMAAdsLoader *)loader adsLoadedWithData:(IMAAdsLoadedData *)adsLoadedData;
-(void)displayContainerUpdated:(IMAAdDisplayContainer *)adDisplayContainer;
@end

@interface OOIMAManager : NSObject<OOAdPlugin>

@property(nonatomic, weak) id<OOIMAManagerDelegate> delegate;
@property(nonatomic, readonly) id<IMAAdPlaybackInfo> adPlaybackInfo;
@property(readonly) IMAAdDisplayContainer *adDisplayContainer;
@property(readonly) OOStateNotifier *stateNotifier;
@property(readonly, nonatomic) NSMutableArray *externalAds;
@property(nonatomic, weak) id<OOIMAAdsManagerDelegate> imaAdsManagerDelegate;

/**
 * Configure IMA ads from given URL.
 * You do not need to do this if a VAST URL is properly configured in Third Party Module Metadata.
 * It is not advised usage to manually load an IMA VAST URL while any IMA URL is configured in Third Party
 * Module Metadata.
 */
@property(nonatomic) NSString *adUrlOverride;

/**
 * Configure VAST load timeout in milliseconds for Google IMA AdRequests.
 * This parameter will override the default timeout set by Google IMA.
 */
@property(nonatomic) float vastLoadTimeout;

/**
 * Initialize a OOIMAManager using the OOOoyalaPlayer
 * @param[in] player the OOOoyalaPlayer
 * @returns the initialized OOIMAManager
 */
- (instancetype)initWithOoyalaPlayer:(OOOoyalaPlayer *)player;

/**
 * Initialize a OOIMAManager using the OOOoyalaPlayer and an Ooyala IMA Configuration
 * @param[in] player the OOOoyalaPlayer
 * @param[in] configuration the OOIMAConfiguration to configure the Ooyala IMA Integration. can be nil

 * @returns the initialized OOIMAManager
 */
- (instancetype)initWithOoyalaPlayer:(OOOoyalaPlayer *)player configuration:(OOIMAConfiguration *)configuration;

/**
 * Add a compnanionSlot to AdsPlayer
 * @param[in] slot the UIView the user wants to use to hold the slot
 * NOTE: this UIView cannot be changed to fit the screen automatically so the companion slots 
 * may be located inappropriately when the orientation changed
 */
- (void)addCompanionSlot:(UIView *)slot;

/**
 * Add tag parameters to the end of the original URL for ads request.
 * The parameters will be overridden by the latest call if this method get called multiple times
 * @param[in] adTagParameters A dictionary of the key-value pairs to be appended to the tag as query string parameters */
- (void)setAdTagParameters:(NSDictionary*)adTagParameters;

/**
 * Play, or queue up automatic playing of ads if they are still loading.
 * This is meant to be called only by the OOIMAAdPlayer.
 */
-(void)play;

/**
 * Pause currently playing ad.
 * This is meant to be called only by the OOIMAAdPlayer.
 */
-(void)pause;


/**
 * Parse the JSON array corresponding to the "all_ads" field in the metadata and extract this
 * data into an Array with data about position and the ad tag URL
 *
 */
- (OOAdSpotManager *)parseAllAdsMetadata:(NSMutableArray *)adsMetadata;

@end
