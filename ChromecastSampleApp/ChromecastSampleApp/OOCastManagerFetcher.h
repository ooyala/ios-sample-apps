//
//  CastManagerFetcher.h
//  ChromecastSampleApp
//
//  Created on 7/31/15.
//  Copyright © 2015 Ooyala, Inc. All rights reserved.
//

@import Foundation;
@class OOCastManager;

@interface OOCastManagerFetcher : NSObject

+ (OOCastManager *)fetchCastManager;

@end
