//
//  OOOfflineVideo.h
//  OoyalaSDK
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "OOUnbundledVideo.h"

@interface OOOfflineVideo : OOUnbundledVideo

@property (nonatomic, readonly) NSURL *keyLocation;

- (instancetype)init NS_UNAVAILABLE;

/**
 * Init an OOOfflineVideo with the location of a downloaded asset.
 * Use this for Clear (non protected) HLS assets.
 *
 * @param location where the downloaded asset is located locally.
 */
- (instancetype)initWithVideoLocation:(NSURL *)location NS_DESIGNATED_INITIALIZER;

/**
 * Init an OOOfflineVideo with the location of a downloaded asset.
 * Use this for Fairplay HLS assets.
 *
 * @param location where the downloaded asset is located locally.
 * @param keyLocation where the Fairplay key is stored.
 */
- (instancetype)initWithVideoLocation:(NSURL *)location fairplayKeyLocation:(NSURL *)keyLocation;

/**
 * Class method that uses initWithFileLocation: initializer.
 *
 * @param location where the downloaded asset is located locally.
 */
+ (OOOfflineVideo *)videoWithVideoLocation:(NSURL *)location;

/**
 * Class method that uses initWithFileLocation:keyLocation: initializer.
 *
 * @param location where the downloaded asset is located locally.
 * @param keyLocation where the Fairplay key is stored.
 */
+ (OOOfflineVideo *)videoWithVideoLocation:(NSURL *)location fairplayKeyLocation:(NSURL *)keyLocation;
@end
