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
 * Return YES if it is reasonable to show a minicontroller. NO means
 * that the UI should not show / should hide any minicontrollers because
 * the underlying Casting state cannot support it. Do not cache the
 * result of this call but poll it when needed.
 */
@property(nonatomic, readonly) BOOL isMiniControllerInteractionAvailable;

/**
 * get and set device volume
 */
@property(nonatomic) float deviceVolume;

/**
 * Enter cast mode with given OOCastModeOptions object
 */
- (void)enterCastModeWithOptions:(OOCastModeOptions *)options;

/**
 * Force casting to forget the asset (i.e. embed code), so the next
 * play will re-init the receiver.
 */
-(void) forceAssetRejoin;

@end
