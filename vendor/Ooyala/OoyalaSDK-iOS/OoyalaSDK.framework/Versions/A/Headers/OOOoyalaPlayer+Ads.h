//
//  OOOoyalaPlayer+Ads.h
//  OoyalaSDK
//
//  Created on 10/31/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"
#import "OOAdPluginManagerProtocol.h"

#ifndef OOOoyalaPlayer_Ads_h
#define OOOoyalaPlayer_Ads_h

typedef NS_ENUM(NSUInteger, OOOoyalaPlayerJsonType) {
  OOOoyalaPlayerJsonNone = 0,
  OOOoyalaPlayerJsonId3,
  OOOoyalaPlayerJsonChannelInfo,
  OOOoyalaPlayerJsonMetadata
};


typedef NS_ENUM(NSUInteger, OOAdType) {
  OOAdTypeContent = 0,
  OOAdTypePreroll,
  OOAdTypeMidroll,
  OOAdTypePostroll
};

@interface OOOoyalaPlayer (Ads)

- (BOOL)needPlayAdsOnInitialContentPlay;
- (BOOL)needPlayAds:(OOAdMode)mode withParameter:(NSNumber *)parameter;

- (void)switchToContent;
- (OOAdType)adType;
- (void)processExitAdModes:(OOAdMode)mode adsPlayed:(BOOL)played;

/**
 * Called when an icon is clicked
 * @param index the index of the icon
 */
- (void)onAdIconClicked:(NSInteger)index;

/**
 * Called when an ad overlay is clicked
 * @param clickUrl the url of the overlay
 */
- (void)onAdOverlayClicked:(NSString *)clickUrl;

/**
 * Insert VAST ads to the managed ad plugin
 * @param ads the ads to be inserted
 */
- (void)insertAds:(NSMutableArray *)ads;

/**
 * Click on the currently playing ad
 */
- (void)clickAd;

/**
 * Reset the state of ad plays. Calling this will cause all ads which have been played to play again.
 */
- (void)resetAds;

/**
 * Skips the currently playing ad (if one is playing. does nothing if not)
 */
- (void)skipAd;

@end

#endif /* OOOoyalaPlayer_Ads_h */
