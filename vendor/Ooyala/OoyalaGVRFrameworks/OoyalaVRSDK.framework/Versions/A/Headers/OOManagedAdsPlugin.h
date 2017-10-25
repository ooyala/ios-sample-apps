//
//  OOManagedPlugin.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOAdSpotPlugin.h"
#import "OOOoyalaPlayer.h"

@interface OOManagedAdsPlugin : OOAdSpotPlugin<OOAdSpotPluginDelegate>

- (void)insertAd:(OOManagedAdSpot *)ad;

@end
