//
//  CastManagerFetcher.m
//  ChromecastSampleApp
//
//  Created on 7/31/15.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import "OOCastManagerFetcher.h"
#import <OoyalaCastSDK/OOCastManager.h>

@implementation OOCastManagerFetcher

+ (OOCastManager *)fetchCastManager {
  return [OOCastManager castManagerWithAppID:@"4172C76F"
                                   namespace:@"urn:x-cast:ooyala"];
}

@end
