//
//  OOAssetLoaderDelegate.h
//  OoyalaSDK
//
//  Created by Zhihui Chen on 1/25/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "OOSecureURLGenerator.h"

@class OOStream;
@protocol OOFairplayContentKeyDelegate;

@interface OOAssetLoaderDelegate : NSObject<AVAssetResourceLoaderDelegate>
-(instancetype) init NS_UNAVAILABLE;

-(instancetype) initWithAsset:(AVURLAsset *)asset
                        pcode:(NSString *)pcode
                    authToken:(NSString *)authToken
           secureURLGenerator:(id<OOSecureURLGenerator>)secureURLGenerator
                      timeout:(NSTimeInterval)timeout NS_DESIGNATED_INITIALIZER;

/**
 * This initializer is helpful for DTO and v2 APIs from Access
 */
- (instancetype)initWithAsset:(AVURLAsset *)asset
                       stream:(OOStream *)stream
                        pcode:(NSString *)pcode
                    authToken:(NSString *)authToken
                      timeout:(NSTimeInterval)timeout;

@property (nonatomic, weak) id<OOFairplayContentKeyDelegate> delegate;

/**
 * For offline playback, this property tells where the fairplay key is stored in the device.
 * It should be nil for regular stream assets.
 */
@property (nonatomic) NSURL *fairplayKeyURL;
@end
