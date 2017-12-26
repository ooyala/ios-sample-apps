/**
 * @file       OODiscoveryOptions.h
 * @class      OODiscoveryOptions OODiscoveryOptions.h "OODiscoveryOptions.h"
 * @brief      OODiscoveryOptions
 * @details    OODiscoveryOptions.h in OoyalaSDK
 * @date       05/15/15
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * The Dicovery types supported by discovery manager
 */
typedef NS_ENUM(NSUInteger, OODiscoveryType) {
  OODiscoveryTypeMomentum = 0,
  OODiscoveryTypePopular,
  OODiscoveryTypeSimilarAssets,
};


@interface OODiscoveryOptions : NSObject

@property OODiscoveryType type; /** the discovery type. Default: similar assets */
@property int limit; /** limit of discovery results */
@property NSTimeInterval timeout; /** the timeout value for http connections. Default: 60 seconds */

/**
 * Initialize an OODiscoveryOptions object with the all properties with default values
 * @returns the initialized OOOptions
 */
- (instancetype) init;

/**
 * Initialize an OODiscoveryOptions object with the given parameters
 * @returns the initialized OOOptions
 */
- (instancetype) initWithType:(OODiscoveryType)type
                        limit:(int)limit
                      timeout:(NSTimeInterval)timeout;

@end
