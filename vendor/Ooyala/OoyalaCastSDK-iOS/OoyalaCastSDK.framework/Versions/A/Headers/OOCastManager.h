//
//  OOCastManager.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/29/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OoyalaSDK/OOCastManagerProtocol.h>


@class OOCastPlayer, OOOoyalaPlayer, GCKDevice;


@protocol OOCastManagerDelegate

- (UIViewController *)currentTopUIViewController;

@end


extern NSString *const OOCastManagerDidDisconnectNotification; /**< Fires when a OOCastManager disconnects from chromecast device*/
extern NSString *const OOCastEnterCastModeNotification; /**< Fires when enter cast mode*/
extern NSString *const OOCastExitCastModeNotification; /**< Fires when exit cast mode*/
extern NSString *const OOCastMiniControllerClickedNotification; /**< Fires when a mini controller is clicked*/
extern NSString *const OOCastErrorNotification; /**< Fires to report Cast errors*/


@interface OOCastManager : UIViewController <OOCastManagerProtocol>

@property (nonatomic, readonly) GCKDevice *selectedDevice;
@property (nonatomic, weak) id<OOCastManagerDelegate> delegate;

/**
 * Initiate and get a singleton OOCastManager with the given reveiverAppID and nameSpace
 * @param receiverAppID identifier of receiever's application
 * @param namespace application namespace
 */
+ (OOCastManager *)castManagerWithAppID:(NSString *)receiverAppID namespace:(NSString *)appNamespace;

/**
 * Disconnect the OOCastManager from ooyalaPlayer
 */
- (void)disconnectFromOoyalaPlayer;

/**
 * Return the cast button
 */
- (UIButton *)castButton;

/**
 * Set the videoView to be displayed on ooyalaPlayer during casting
 */
- (void)setCastModeVideoView:(UIView *)castView;

/**
 * Provide key-value pairs that will be passed to the Receiver upon Cast Playback. Anything
 * added to this will overwrite anything set by default in the init.
 */
- (void)setAdditionalInitParams:(NSDictionary *)params;

@end
