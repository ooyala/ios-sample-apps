//
//  OOUnbundledVideo.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "OOVideo.h"

@class OOPlayerAPIClient;

static NSString *const OO_UNBUNDLED_EMBED_CODE = @"UNBUNDLED";

@interface OOUnbundledVideo : NSObject

@property (nonatomic, readonly) NSArray *streams; /**< contains OOStreams. */
@property (nonatomic, readonly) NSArray *ads; /**< contains OOManagedAdSpots. */

/**
 * Initialize a OOUnbundledVideo using the specified data (subclasses should override this)
 * @param streams NSArray containing OOStreams.
 */
- (instancetype)initWithUnbundledStreams:(NSArray *)streams;

/**
 * Initialize a OOUnbundledVideo using the specified data (subclasses should override this)
 * @param streams NSArray containing OOStreams.
 * @param ads NSArray containing OOManagedAdSpots.
 */
- (instancetype)initWithUnbundledStreams:(NSArray *)streams ads:(NSArray *)ads;

@end
