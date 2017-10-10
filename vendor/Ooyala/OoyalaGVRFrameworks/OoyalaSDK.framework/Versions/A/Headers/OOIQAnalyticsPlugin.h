/**
 * @file  OOIQAnalytics.h
 * @brief The plugin for IQ Analytics
 *
 * @copyright Copyright (c) 2016 Ooyala, Inc. All rights reserved.
 */

#import "OOAnalyticsPluginProtocol.h"
@class OOIQConfiguration;
@class OOOoyalaPlayer;

@interface OOIQAnalyticsPlugin : NSObject<OOAnalyticsPluginProtocol>

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player iqConfiguration:(OOIQConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

@end
