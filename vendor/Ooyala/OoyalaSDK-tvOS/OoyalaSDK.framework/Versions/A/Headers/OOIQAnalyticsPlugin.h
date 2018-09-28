/**
 * @file  OOIQAnalytics.h
 * @brief The plugin for IQ Analytics
 *
 * @copyright Copyright (c) 2016 Ooyala, Inc. All rights reserved.
 */

#import "OOAnalyticsPluginProtocol.h"
@class OOIQConfiguration;
@class OOOoyalaPlayer;
@class OOSsaiAdsMetadata;
@class OOSsaiAdBreak;

@interface OOIQAnalyticsPlugin : NSObject<OOAnalyticsPluginProtocol>

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player iqConfiguration:(OOIQConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 Availability of the network using the network configuration for IQ
 @returns YES if the network is available
 */
- (BOOL)isNetworkAvailable;

/**
 Returns the actions for the specific file
 @param[in] embedCode of the file
 @returns an string with all the actions registered in the file
 */
+ (NSString *)dataFromFile:(NSString *)embedCode;

@end
