//
//  OOUnbundledVideo.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOStream.h"
#import "OOVideo.h"

@class OOPlayerAPIClient;

#define OO_UNBUNDLED_EMBED_CODE @"UNBUNDLED"

@interface OOUnbundledVideo : NSObject

@property(nonatomic, readonly) NSArray *streams; /**< contains OOStreams. */
@property(nonatomic, readonly) NSArray *ads; /**< contains OOManagedAdSpots. */

/**
 * Initialize a OOUnbundledVideo using the specified data (subclasses should override this)
 * @param[in] streams NSArray containing OOStreams.
 */
- (id)initWithUnbundledStreams:(NSArray*)streams;

/**
 * Initialize a OOUnbundledVideo using the specified data (subclasses should override this)
 * @param[in] streams NSArray containing OOStreams.
 * @param[in] theAds NSArray containing OOManagedAdSpots.
 */
- (id)initWithUnbundledStreams:(NSArray*)streams ads:(NSArray*)ads;

@end
