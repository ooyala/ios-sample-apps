//
//  OOOoyalaPlayer+Internal.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 8/1/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

typedef NS_ENUM(NSUInteger, OOInitialPlayState) {
  OOInitialPlayStateNone, // neither preroll or content is played ever
  OOInitialPlayStatePluginQueried, // ad plugin is queried for initial play, but content is not played yet
  OOInitialPlayStateContentPlayed // preroll is played and content is played at least once
};

@interface OOOoyalaPlayer (Internal)

- (void)processExitAdModes:(OOAdMode)mode adsPlayed:(BOOL)played;
- (Class)playerClass:(Class)spotClass;

- (void)notifyStateChange:(OOStateNotifier *)sender old:(OOOoyalaPlayerState)oldState new:(OOOoyalaPlayerState)newState;
- (void)notifyTimeChange:(OOStateNotifier *)sender;
- (void)notifyAdsLoaded:(OOStateNotifier *)sender;
- (void)notifyAdSkipped:(OOStateNotifier *)sender;

- (BOOL)showingAdsWithHiddenControls;

@end