/**
 * @class      OOIMAManager OOIMAManager.h "OOIMAManager.h"
 * @copyright  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import <OoyalaSDK/OOAdPlugin.h>
#import "IMAAd.h"
#import "IMAAdEvent.h"
#import "IMAAdsLoader.h"

@class OOOoyalaPlayerViewController;
@class OOStateNotifier;

@protocol OOIMAManagerDelegate
-(void)adsReady;
-(void)playStarted; // as opposed to the play being queued up for later.
-(void)onError;
@end

@interface OOIMAManager : NSObject<OOAdPlugin>

@property(nonatomic, weak) id<OOIMAManagerDelegate> delegate;
@property(nonatomic, readonly) id<IMAAdPlaybackInfo> adPlaybackInfo;
@property(nonatomic, readonly) UIView *imaAdView;
@property(readonly) OOStateNotifier *stateNotifier;

/**
 * Configure IMA ads from given URL.
 * You do not need to do this if a VAST URL is properly configured in Third Party Module Metadata.
 * It is not advised usage to manually load an IMA VAST URL while any IMA URL is configured in Third Party
 * Module Metadata.
 */
@property(nonatomic) NSString *adUrlOverride;

/**
 * Initialize a OOIMAManager using the OOOoyalaPlayerViewController
 * @param[in] viewController the OOOoylaPlayerViewController control the OOOoyalaPlayer's View
 * @returns the initialized OOIMAManager
 */
- (id)initWithOoyalaPlayerViewController:(OOOoyalaPlayerViewController *)viewController;

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

/*
 * Use the default browser like Safari on the mobile device instead of browsing in the native app.
 */
-(void)setUseDefaultBrowser:(BOOL)useDefaultBrowser;

/**
 * Pause currently playing ad.
 * This is meant to be called only by the OOIMAAdPlayer.
 */
-(void)pause;

@end
