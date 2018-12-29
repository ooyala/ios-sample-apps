//
//  OOCastManager.h
//  OoyalaSDK
//
//  Created on 8/29/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OOCastManagerProtocol.h>
#import <GoogleCast/GCKDevice.h>
#import <OoyalaSDK/OOPlayerProtocol.h>

@class OOCastPlayer;
@class OOOoyalaPlayer;
@class OOCastManager;
@protocol OOCastMiniControllerProtocol;

@protocol OOCastManagerDelegate

/**
 Fires when a OOCastManager disconnects from chromecast device

 @param manager OOCastManager instance
 */
- (void)castManagerDidEnterCastMode:(nonnull OOCastManager *)manager;
/**
 Fires when enter cast mode

 @param manager OOCastManager instance
 */
- (void)castManagerDidExitCastMode:(nonnull OOCastManager *)manager;
/**
 Fires when exit cast mode

 @param manager OOCastManager instance
 */
- (void)castManagerDidDisconnect:(nonnull OOCastManager *)manager;
/**
 Fires to report Cast errors

 @param manager OOCastManager instance
 @param error error occured
 */
- (void)castManager:(nonnull OOCastManager *)manager
   didFailWithError:(nonnull NSError *)error
          andExtras:(nullable NSDictionary *)extras;

@end


@interface OOCastManager : UIViewController <OOCastManagerProtocol>

@property (nonatomic, readonly, nullable) GCKDevice *selectedDevice;
@property (nonatomic, weak, nullable) id<OOCastManagerDelegate> delegate;
@property (nonatomic, readonly) OOOoyalaPlayerState state;

/**
 * Initiate and get a singleton OOCastManager with the given reveiverAppID and nameSpace
 * @param receiverAppID identifier of receiever's application
 * @param namespace application namespace
 */
+ (nonnull OOCastManager *)castManagerWithAppID:(nonnull NSString *)receiverAppID
                                      namespace:(nonnull NSString *)appNamespace;

- (void)registerMiniController:(nullable id<OOCastMiniControllerProtocol>)miniController;

/**
 * Disconnect the OOCastManager from ooyalaPlayer
 */
- (void)disconnectFromOoyalaPlayer;

/**
 * Return the cast button
 */
- (nonnull UIButton *)castButton;

/**
 * Set the videoView to be displayed on ooyalaPlayer during casting
 */
- (void)setCastModeVideoView:(nonnull UIView *)castView;

/**
 * Provide key-value pairs that will be passed to the Receiver upon Cast Playback. Anything
 * added to this will overwrite anything set by default in the init.
 */
- (void)setAdditionalInitParams:(nullable NSDictionary *)params;

@end
