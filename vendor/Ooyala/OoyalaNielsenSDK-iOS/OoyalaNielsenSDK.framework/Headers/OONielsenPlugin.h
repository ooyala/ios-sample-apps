/**
* @class      OONielsenPlugin OONielsenPlugin.h "OONielsenPlugin.h"
* @brief      OONielsenPlugin
* @details    OONielsenPlugin.h in OoyalaNielsenSDK
* @date       11/13/14
* @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
*/

#import <Foundation/Foundation.h>

@class OOOoyalaPlayer;
@class NielsenAppApi;
/**
 * Ooyala Nielson analytics plugin implementation.
 */
@interface OONielsenPlugin : NSObject

/**
 Initializes the ID3Meter metering framework.
 @param[in] player the ooyala player the plugin associate with
 @param[in] appId appId provided by Nielsen
 @param[in] appVersion the app version
 @param[in] appName the app name
 @param[in] sfcode the sfcode
 @param[in] otherParameters such as longitude, latitude, dma or cccode
 @returns the initialized nielsen plugin object
 */
- (id)initWithPlayer:(OOOoyalaPlayer *)player appId:(NSString *)appId appVersion:(NSString *)appVersion appName:(NSString *)appName sfcode:(NSString *)sfcode parameters:(NSDictionary *)otherParameters;

/**
 Get the underlying nielsen app api
 @returns the nielsenAppApi instance
 */
- (NielsenAppApi *)getNielsenAppApi;

/** cutomer metadata that overrides server values */
@property (nonatomic, retain) NSDictionary *customMetadata;

@end
