//
//  OOCastManager.h
//  OoyalaSDK
//
//  Created on 8/29/14.
//  Copyright © 2014 Ooyala, Inc. All rights reserved.
//

@import Foundation;
@import GoogleCast.GCKDevice;
@import GoogleCast.GCKError;

#import <OoyalaSDK/OOCastManagerProtocol.h>
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOCastModeOptions.h>

@class UIButton;
@class UIView;
@class OOCastPlayer;
@class OOOoyalaPlayer;
@class OOCastManager;
@protocol OOCastMiniControllerProtocol;

@protocol OOCastManagerDelegate
/**
 Fires when a @c OOCastManager disconnects from chromecast device

 @param manager @c OOCastManager instance
 */
- (void)castManagerDidEnterCastMode:(nonnull OOCastManager *)manager;
/**
 Fires when enter cast mode

 @param manager @c OOCastManager instance
 */
- (void)castManagerDidExitCastMode:(nonnull OOCastManager *)manager;
/**
 Fires when exit cast mode

 @param manager @c OOCastManager instance
 */
- (void)castManagerDidDisconnect:(nonnull OOCastManager *)manager;

/**
 Indicates that cast manager has failed to start session

 @param manager @c OOCastManager instance
 @param error a corresponding @c NSError
 */
- (void)castManager:(nonnull OOCastManager *)manager
 didFailToStartSessionWithError:(nonnull NSError *)error;

/**
 Indicates that cast manager has ended session with error

 @param manager a @c OOCastManager instance
 @param error a corresponding @c NSError
 */
- (void)castManager:(nonnull OOCastManager *)manager
didEndSessionWithError:(nonnull NSError *)error;

/**
 Indicates that a cast request has failed

 @param manager @c OOCastManager instance
 @param requestId id of a @c GCKRequest
 @param error a @c GCKError occured
 */
- (void)castManager:(nonnull OOCastManager *)manager
 castRequestWithtId:(NSInteger)requestId
   didFailWithError:(nonnull GCKError *)error;

@end


@interface OOCastManager : NSObject <OOCastManagerProtocol, OOCastManageable>

@property (nonatomic, readonly, nullable) GCKDevice *selectedDevice;
@property (nonatomic, nullable, weak) id<OOCastManagerDelegate> delegate;
@property (nonatomic, readonly) OOOoyalaPlayerState state;
@property (nonatomic, nullable, weak) id<OOCastNotifiable> notifyDelegate;

/**
 Initiate and get a singleton OOCastManager with the given reveiverAppID and nameSpace
 @param receiverAppID identifier of receiever's application
 @param namespace application namespace
 */
+ (nonnull OOCastManager *)castManagerWithAppID:(nonnull NSString *)receiverAppID
                                      namespace:(nonnull NSString *)appNamespace;

- (void)registerMiniController:(nullable id<OOCastMiniControllerProtocol>)miniController;

/**
 Disconnect the OOCastManager from ooyalaPlayer
 */
- (void)disconnectFromOoyalaPlayer;

/**
 Disconnect from current Chromecast device if any
 */
- (void)disconnectFromCurrentDevice;

/**
 Return the cast button
 */
- (nonnull UIButton *)castButton;

/**
 Set the videoView to be displayed on ooyalaPlayer during casting
 */
- (void)setCastModeVideoView:(nonnull UIView *)castView;

/**
 Provide key-value pairs that will be passed to the Receiver upon Cast Playback. Anything
 added to this will overwrite anything set by default in the init.
 */
- (void)setAdditionalInitParams:(nullable NSDictionary *)params;

@end
