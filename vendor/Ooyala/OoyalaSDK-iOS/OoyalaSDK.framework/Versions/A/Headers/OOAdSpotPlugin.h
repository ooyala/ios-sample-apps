//
//  OOAdSpotPlugin.h
//  OoyalaSDK
//
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

#import "OOAdPlugin.h"

@class OOAdSpot;
@class OOAdSpotManager;

@protocol OOAdSpotPluginDelegate

- (BOOL)playAd:(OOAdSpot *)ad;
- (void)onError;
- (void)skipAd;

@end

@interface OOAdSpotPlugin : NSObject <OOAdPlugin>

@property (nonatomic) Float64 lastAdModeTime;
@property (nonatomic, readonly) OOAdSpotManager *adSpotManager;
@property (nonatomic, weak) id<OOAdSpotPluginDelegate> delegate;

- (BOOL)playAdsBeforeTime;

@end
