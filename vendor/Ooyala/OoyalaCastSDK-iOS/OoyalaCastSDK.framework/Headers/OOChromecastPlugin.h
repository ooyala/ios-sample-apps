//
//  OOChromecastPlugin.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/29/14.
//  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleCast/GoogleCast.h>
#import <OoyalaSDK/OOPlayerProtocol.h>
#import <OoyalaSDK/OOCastManagerProtocol.h>

@class OOChromecastPlayer, OOOoyalaPlayer;

@protocol OOCastPluginDelegate
- (UIViewController *) currentTopUIViewController;
@end


extern NSString *const OOChromecastPluginFailToConnectNotification; /**< Fires when a ChromecastPlugin fails to connect to a chromecast device*/
extern NSString *const OOChromecastDeviceLostNotification; /**< Fires when a chromecast device lost*/
extern NSString *const OOChromecastPluginDidDisconnectNotification; /**< Fires when a cast plugin disconnects from chromecast device*/
extern NSString *const OOChromecastEnterCastModeNotification; /**< Fires when enter cast mode*/
extern NSString *const OOChromecastExitCastModeNotification; /**< Fires when exit cast mode*/
extern NSString *const OOChromecastMiniControllerClickedNotification; /**< Fires when a mini controller is clicked*/

@interface OOChromecastPlugin : UIViewController<OOCastManagerProtocol, GCKDeviceScannerListener,GCKDeviceManagerDelegate,GCKMediaControlChannelDelegate, UIActionSheetDelegate>

@property(nonatomic, strong) GCKDeviceScanner* deviceScanner;

@property(nonatomic, strong) GCKDevice *selectedDevice;

@property(nonatomic, strong) OOChromecastPlayer *castPlayer;

@property(nonatomic, readonly) BOOL isInCastMode;

@property(nonatomic, weak) id<OOCastPluginDelegate> delegate;

/**
 * Initiate and get a singleton ChromeCastPlugin with the given reveiverAppID and nameSpace
 */
+ (OOChromecastPlugin *)getCastPluginWithAppID:(NSString *)receiverAppID namespace:(NSString *)appNamespace;

/**
 * Disconnect the plugin from ooyalaPlayer
 */
- (void)disconnectFromOoyalaPlayer;

/**
 * Return the cast button
 */
- (UIButton *)getCastButton;

/**
 *  Return the castPlayer related to this ChromeCastPlugin
 */
- (OOChromecastPlayer *)getCastPlayer;

/**
 * Set the videoView to be displayed on ooyalaPlayer during casting
 */
- (void)setCastModeVideoView:(UIView *)castView;
@end
