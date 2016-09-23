//
//  OOOfflineVideo.h
//  OoyalaSDK
//
//  Created on 8/30/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <OoyalaSDK/OoyalaSDK.h>

@interface OOOfflineVideo : OOUnbundledVideo

- (instancetype)init NS_UNAVAILABLE;

/**
 * Init an OOOfflineVideo with the location of a downloaded asset.
 *
 * @param location where the downloaded asset is located locally.
 */
- (instancetype)initWithFileLocation:(NSURL *)location NS_DESIGNATED_INITIALIZER;

/**
 * Class method that uses initWithFileLocation: initializer.
 *
 * @param location where the downloaded asset is located locally.
 */
+ (OOOfflineVideo *)videoWithFileLocation:(NSURL *)location;

@end
