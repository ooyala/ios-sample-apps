//
//  OODefaultAdsPlugin.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OOAdPlugin.h"
#import "OOAdSpotManager.h"

#define PLUGIN_INIT -2
#define CONTENT_CHANGED -1

@protocol OOAdSpotPluginDelegate

- (BOOL)playAd:(OOAdSpot *)ad;

@end

@interface OOAdSpotPlugin : NSObject<OOAdPlugin>

@property (readonly) Float64 lastAdModeTime;
@property (readonly) OOAdSpotManager *adSpotManager;
@property (nonatomic, weak) id<OOAdSpotPluginDelegate> delegate;

- (BOOL)playAdsBeforeTime;

@end
