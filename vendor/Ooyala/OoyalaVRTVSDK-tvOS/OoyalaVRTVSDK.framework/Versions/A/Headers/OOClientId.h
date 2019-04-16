/**
 @file       OOClientId.h
 @headerfile OOClientId.h "OOClientId.h"
 @brief      OOClientId
 @details    OOClientId.h in OoyalaSDK
 @date       7/29/14
 @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@interface OOClientId : NSObject
/**
 Get a client ID
 @return the UUID that persists across launch
 */
+ (nonnull NSString *)uniqueId;
/**
 Set the id that overrides the default value

 Ooyala WILL NOT persist this id so user needs to call this
 every time the app is launched
 @param uniqueId the id string customer like to use
 */
+ (void)setUniqueId:(nullable NSString *)uniqueId;
/**
 Clear the uniqueId.

 When uniqueId is called, a new uniqueId will be generated
 */
+ (void)resetUniqueId;

@end
