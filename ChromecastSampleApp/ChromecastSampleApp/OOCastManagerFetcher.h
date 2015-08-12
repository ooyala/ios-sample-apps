//
//  CastManagerFetcher.h
//  ChromecastSampleApp
//
//  Created by Jon Slenk on 7/31/15.
//  Copyright (c) 2015 Liusha Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OOCastManager;
@interface OOCastManagerFetcher : NSObject
+(OOCastManager*) fetchCastManager;
@end
