//
//  OOAssetDownloadStream.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOAssetDownloadStream : NSObject

@property (readonly) NSURL *stream;
@property (readonly) int bitrate;
@property (readonly) int height;
@property (readonly) int width;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDict:(NSDictionary *)data NS_DESIGNATED_INITIALIZER;

@end

