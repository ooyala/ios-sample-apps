/**
@class      OONielsenPlugin OONielsenPlugin.h "OONielsenPlugin.h"
@brief      OONielsenPlugin
@details    OONielsenPlugin.h in OoyalaNielsenSDK
@date       11/13/14
@copyright  Copyright © 2014 Ooyala, Inc. All rights reserved.
*/

@import Foundation;

@class OOOoyalaPlayer;
@class NielsenAppApi;
/**
 Ooyala Nielson analytics plugin implementation.
 */
@interface OONielsenPlugin : NSObject
/**
 Initializes the ID3Meter metering framework.
 @param player the ooyala player the plugin associate with
 @param appId appId provided by Nielsen
 @param appVersion the app version
 @param appName the app name
 @param sfcode the sfcode
 @param otherParameters such as longitude, latitude, dma or cccode
 @return the initialized nielsen plugin object
 */
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
                         appId:(NSString *)appId
                    appVersion:(NSString *)appVersion
                       appName:(NSString *)appName
                        sfcode:(NSString *)sfcode
                    parameters:(NSDictionary *)otherParameters;

/**
 Get the underlying nielsen app api
 @return the nielsenAppApi instance
 */
- (NielsenAppApi *)getNielsenAppApi;

/** cutomer metadata that overrides server values */
@property (nonatomic) NSDictionary *customMetadata;

@end
