//
//  OOSsaiPlugin.h
//  OoyalaSSAISDK
//
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OOSsaiPlugin_h
#define OOSsaiPlugin_h

#import <OoyalaSDK/OoyalaSDK.h>

@class OOOoyalaPlayer;

/**
 Ooyala SSAI plugin implementation.
 */
@interface OOSsaiPlugin : NSObject<OOAdPlugin>

/**
 Initializes the SSAI framework.
 @return the initialized SSAI plugin object
 */
- (instancetype)init;

/**
 Initializes the SSAI framework.
 @param ssaiParams the parameters for the player
 @return the initialized ssai plugin object
 */
- (instancetype)initWithParams:(NSString *)ssaiParams;

/**
 Register the player to the plugin.
 @param player the player to register
 */
- (void)registerPlayer:(OOOoyalaPlayer *)player;

/**
 Deregister the player to the plugin.
 @param player the player to deregister
 */
- (void)deregisterPlayer:(OOOoyalaPlayer *)player;

/**
 Set the SSAI params
 @param ssaiParams the parameters for override SSAI parameters
 @return YES if the parameters are correct, otherwise NO
 */
- (BOOL)setParams:(NSString *)ssaiParams;

@end

#endif
