//
//  OOCastManager
//  OoyalaSDK
//
//  Created by Liusha Huang on 3/27/15.
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OOOoyalaPlayer;
@class OOCastPlayer;
@protocol OOEmbedTokenGenerator;
@class OOCastModeOptions;

@protocol OOCastManagerProtocol <NSObject>

/**
 * Return YES if the OOCastManager is connected to a cast device
 */
- (BOOL)isConnectedToChromecast;

/**
 *  Return the castPlayer related to this OOCastManager
 */
@property (nonatomic, readonly) OOCastPlayer *castPlayer;

/**
 * Register the OOCastManager to ooyalaPlayer
 */
- (void)registerWithOoyalaPlayer:(OOOoyalaPlayer *)ooyalaPlayer;

/**
 * Return YES if is in castMode
 */
@property(nonatomic, readonly) BOOL isInCastMode;

/**
 * Enter cast mode with given OOCastModeOptions object
 */
- (void)enterCastModeWithOptions:(OOCastModeOptions *)options;

@end
