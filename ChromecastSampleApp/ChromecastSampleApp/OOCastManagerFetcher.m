//
//  CastManagerFetcher.m
//  ChromecastSampleApp
//
//  Created by Jon Slenk on 7/31/15.
//  Copyright (c) 2015 Liusha Huang. All rights reserved.
//

#import "OOCastManagerFetcher.h"
#import <OoyalaCastSDK/OOCastManager.h>

@implementation OOCastManagerFetcher
+(OOCastManager*) fetchCastManager {
  return [OOCastManager getCastManagerWithAppID:@"D4C7BD4A" namespace:@"urn:x-cast:ooyala"];
}
@end
