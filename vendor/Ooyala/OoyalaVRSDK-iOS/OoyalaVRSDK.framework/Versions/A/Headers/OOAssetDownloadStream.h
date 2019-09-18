//
//  OOAssetDownloadStream.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import Foundation;

extern NSString *const OO_KEY_EMBED_CODE;   /**< The JSON dictionary key for embed_code */
extern NSString *const OO_KEY_MANIFEST_URL; /**< The JSON dictionary key for manifest URL */
extern NSString *const OO_KEY_STREAM_URL;   /**< The JSON dictionary key for stream URL */
extern NSString *const OO_KEY_STREAM_INFO;  /**< The JSON dictionary key for stream information */

@interface OOAssetDownloadStream : NSObject

@property (readonly) NSURL *stream;
@property (readonly) int bitrate;
@property (readonly) int height;
@property (readonly) int width;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDict:(NSDictionary *)data NS_DESIGNATED_INITIALIZER;

@end

