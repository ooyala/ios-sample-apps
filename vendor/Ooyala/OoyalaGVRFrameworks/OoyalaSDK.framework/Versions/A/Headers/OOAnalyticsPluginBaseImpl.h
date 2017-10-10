/**
 * @file       OOAnalyticsPluginBaseImpl.h
 * @brief      A class that implements empty methods for the entire Analytics plugin interface
 * @details    Implement your plugin by extending this, and whenever the Analytics Plugin Interface is modified,
 * your integration will be unaffected, and continue to compile and be usable
 *
 * Your Analytics plugin may require more functionality than is reported here.  If this is the case
 * you can additionally observe OoyalaPlayer, and report any other metrics through the observation chain
 * @copyright Copyright (c) 2016 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOAnalyticsPluginProtocol.h"

@interface OOAnalyticsPluginBaseImpl : NSObject<OOAnalyticsPluginProtocol>

@end
