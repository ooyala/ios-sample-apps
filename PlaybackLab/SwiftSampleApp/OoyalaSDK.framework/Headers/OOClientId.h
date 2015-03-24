/**
 * @file       OOClientId.h
 * @headerfile OOClientId.h "OOClientId.h"
 * @brief      OOClientId
 * @details    OOClientId.h in OoyalaSDK
 * @date       7/29/14
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface OOClientId : NSObject
/**
 * Get a client ID
 * @returns the UUID that persists across launch
 */
+ (NSString *)getId;

/**
 * Set the id that overrides the default value
 * Ooyala WILL NOT persist this id so user needs to call this
 * every time the app is launched
 * @param[in] clientId the id string customer like to use
 */
+ (void)setId:(NSString *)clientId;

/**
 * Clear the id.
 * When getId is called, a new id will be generated
 */
+ (void)resetId;

@end
