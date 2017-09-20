/**
 * @file       OODiscoveryManager.h
 * @class      OODiscoveryManager OODiscoveryManager.h "OODiscoveryManager.h"
 * @brief      OODiscoveryManager
 * @details    OODiscoveryManager.h in OoyalaSDK
 * @date       05/15/15
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOEmbedTokenGenerator.h"
#import "OOOoyalaError.h"
#import "OODiscoveryOptions.h"

/**
 * The callback used for OODiscoveryManager to notify the discovery results
 * @param[in] results the discovery results.
 * @param[in] error an OOOoyalaError denoting what error occurred (nil if no error)
 */
typedef void(^OODiscoveryResultsCallback)(NSArray *results, OOOoyalaError *error);

@interface OODiscoveryManager : NSObject

/**
 * get the discovery results
 * @param[in] option the discovery option;
 * @param[in] embedCode the embed code for discovery type similar assets, ignored for other discovery types
 * @param[in] pcode the pcode
 * @param[in] parameters the parameters as key value pair
 *  for a detailed list and examples of valid parameters, please refer to
 *  http://support.ooyala.com/developers/documentation/concepts/content_discovery_summary_of_routes.html
 * @param[in] callback the callback function that handles discovery results.the callback might not be called on the main thread.
 */
+ (void)getResults:(OODiscoveryOptions *)options
         embedCode:(NSString *)embedCode
             pcode:(NSString *)pcode
        parameters:(NSDictionary *)parameters
          callback:(OODiscoveryResultsCallback)callback;

/**
 * send discovery feedback impression when discovery is shown to user
 * @param[in] options the discovery options
 * @param[in] bucketInfo the bucket info id
 */
+ (void)sendImpression:(OODiscoveryOptions *)options
            bucketInfo:(NSString *)bucketInfo
                 pcode:(NSString *)pcode
            parameters:(NSDictionary *)parameters;

/**
 * send discovery feedback click when user clicks to play an item
 * @param[in] bucketInfo the bucket info id
 * @param[in] options the discovery options
 */
+ (void)sendClick:(OODiscoveryOptions *)options
       bucketInfo:(NSString *)bucketInfo
            pcode:(NSString *)pcode
       parameters:(NSDictionary *)parameters;

@end
