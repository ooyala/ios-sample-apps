/**
 * @file       OODiscoveryManager.h
 * @class      OODiscoveryManager OODiscoveryManager.h "OODiscoveryManager.h"
 * @brief      OODiscoveryManager
 * @details    OODiscoveryManager.h in OoyalaSDK
 * @date       05/15/15
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@class OOOoyalaError;
@class OODiscoveryOptions;

/**
 * The callback used for OODiscoveryManager to notify the discovery results
 * @param results the discovery results.
 * @param error an OOOoyalaError denoting what error occurred (nil if no error)
 */
typedef void(^OODiscoveryResultsCallback)(NSArray *results, OOOoyalaError *error);

@interface OODiscoveryManager : NSObject

/**
 * get the discovery results
 * @param options the discovery option;
 * @param embedCode the embed code for discovery type similar assets, ignored for other discovery types
 * @param pcode the pcode
 * @param parameters the parameters as key value pair
 *  for a detailed list and examples of valid parameters, please refer to
 *  http://support.ooyala.com/developers/documentation/concepts/content_discovery_summary_of_routes.html
 * @param callback the callback function that handles discovery results.the callback might not be called on the main thread.
 */
+ (void)getResults:(OODiscoveryOptions *)options
         embedCode:(NSString *)embedCode
             pcode:(NSString *)pcode
        parameters:(NSDictionary *)parameters
          callback:(OODiscoveryResultsCallback)callback;

/**
 * send discovery feedback impression when discovery is shown to user
 * @param options the discovery options
 * @param bucketInfo the bucket info id
 */
+ (void)sendImpression:(OODiscoveryOptions *)options
            bucketInfo:(NSString *)bucketInfo
                 pcode:(NSString *)pcode
            parameters:(NSDictionary *)parameters;

/**
 * send discovery feedback click when user clicks to play an item
 * @param bucketInfo the bucket info id
 * @param options the discovery options
 */
+ (void)sendClick:(OODiscoveryOptions *)options
       bucketInfo:(NSString *)bucketInfo
            pcode:(NSString *)pcode
       parameters:(NSDictionary *)parameters;

@end
