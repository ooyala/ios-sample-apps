//
//  OOOoyalaPlayer+Internal.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

typedef NS_ENUM(NSUInteger, OOOoyalaPlayerJsonType) {
  OOOoyalaPlayerJsonNone = 0,
  OOOoyalaPlayerJsonId3,
  OOOoyalaPlayerJsonChannelInfo,
  OOOoyalaPlayerJsonMetadata
};

typedef NS_ENUM(NSUInteger, OOInitialPlayState) {
  OOInitialPlayStateNone, // neither preroll or content is played ever
  OOInitialPlayStatePluginQueried, // ad plugin is queried for initial play, but content is not played yet
  OOInitialPlayStateContentPlayed // preroll is played and content is played at least once
};

typedef NS_ENUM(NSUInteger, OOAdType) {
  OOAdTypeContent,
  OOAdTypePreroll,
  OOAdTypeMidroll,
  OOAdTypePostroll
};

extern NSString *const OOOoyalaPlayerJsonReceivedNotification; /**< Fires when received a json string, userinfo contains the key and value of the json string*/

@interface OOOoyalaPlayer (Internal)

- (void)processExitAdModes:(OOAdMode)mode adsPlayed:(BOOL)played;
- (Class)playerClass:(Class)spotClass;

- (void)notifyStateChange:(OOStateNotifier *)sender old:(OOOoyalaPlayerState)oldState new:(OOOoyalaPlayerState)newState;
- (void)notifyTimeChange:(OOStateNotifier *)sender;
- (void)notifyAdsLoaded:(OOStateNotifier *)sender;
- (void)notifyAdSkipped:(OOStateNotifier *)sender;

- (BOOL)showingAdsWithHiddenControls;
- (OOAdType)adType;

@end