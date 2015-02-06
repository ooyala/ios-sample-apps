/**
 * @class      OOOoyalaAPIHelper OOOoyalaAPIHelper.h "OOOoyalaAPIHelper.h"
 * @brief      OOOoyalaAPIHelper
 * @details    OOOoyalaAPIHelper.h in OoyalaSDK
 * @date       11/22/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "OOSecureURLGenerator.h"
#import "OOSignatureGenerator.h"

@interface OOOoyalaAPIHelper : NSObject

/**
 * Fetch the json associated with the API URL/params specified (for use with unsigned player API)
 * @param[in] host the API Host ( including http:// or https:// )
 * @param[in] uri the API URL
 * @param[in] params an NSDictionary containing the params to pass to the API
 * @param[in] timeout the timeout for network connection in second
 * @returns an NSData object containing the raw bytes of the JSON response
 */
+ (NSData *)jsonForAPI:(NSString *)host uri:(NSString *)uri params:(NSDictionary *)params timeout:(NSTimeInterval)timeout;

/**
 * Fetch the json associated with the NSURL specified (for use with unsigned player API)
 * @param[in] url the NSURL representing the API
 * @param[in] timeout the timeout for network connection in second
 * @returns an NSData object containing the raw bytes of the JSON response
 */
+ (NSData *)jsonForAPI:(NSURL *)url timeout:(NSTimeInterval)timeout;

/**
 * Fetch the object associated with the API URL/params specified (for use with unsigned player API)
 * @param[in] host the API Host ( including http:// or https:// )
 * @param[in] uri the API URI
 * @param[in] params an NSDictionary containing the params to pass to the API
 * @param[in] timeout the timeout for network connection in second
 * @returns either an NSDictionary or an NSArray with the JSON response converted to object form
 */
+ (NSObject *)objectForAPI:(NSString *)host uri:(NSString *)uri params:(NSDictionary *)params timeout:(NSTimeInterval)timeout;

@end
