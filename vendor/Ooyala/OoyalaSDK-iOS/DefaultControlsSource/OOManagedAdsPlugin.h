//
//  OOManagedPlugin.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 8/4/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import "OOAdSpotPlugin.h"
#import "OOOoyalaPlayer.h"

@interface OOManagedAdsPlugin : OOAdSpotPlugin<OOAdSpotPluginDelegate>

- (void)insertAd:(OOManagedAdSpot *)ad;

@end
