//
//  OOStateNotifier.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOAdPodInfo.h"

@class OOSsaiAdsMetadata;

@interface OOStateNotifier : NSObject

@property OOOoyalaPlayerState state;

- (void)notifyPlayheadChange;
- (void)notifyAdsLoaded;
- (void)notifyAdSkipped;
- (void)notifyAdStarted;
- (void)notifyAdCompleted;
/**
 * Notifies the player the ads metadata has been received.
 * Used for SSAI ads.
 * @param adsMetadata metadata returned by SSAI endpoint
 */
- (void)notifySSAIAdsMetadataReceived:(OOSsaiAdsMetadata *)adsMetadata;

/**
 * Notifies the player a when an SSAI ad break has started
 * @param adPodInfo ad metadata to display in adScreen
 */
- (void)notifySSAIAdPlaying:(OOAdPodInfo *)adPodInfo;

/**
 * Notifies the player a when an SSAI ad break has ended
 */
- (void)notifySSAIAdPlayed;

@end
