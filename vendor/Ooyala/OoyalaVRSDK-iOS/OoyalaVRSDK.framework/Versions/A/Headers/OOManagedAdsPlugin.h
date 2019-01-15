//
//  OOManagedPlugin.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import "OOAdSpotPlugin.h"

#ifndef OOManagedAdsPlugin_h
#define OOManagedAdsPlugin_h

@interface OOManagedAdsPlugin : OOAdSpotPlugin<OOAdSpotPluginDelegate>

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)p;
- (void)insertAd:(OOManagedAdSpot *)ad;

@end

#endif /* OOManagedAdsPlugin_h */
