//
//  OOSkinViewController.h
//  OoyalaSkin
//

@import UIKit;

@class OOOoyalaPlayer;
@class OOSkinOptions;
@class OOClosedCaptionsStyle;
@protocol OOCastNotifiable;
@protocol OOCastManageable;

/**
 * The primary class for the Skin UI
 * Use it to display the Ooyala Skin UI alongside the OOOoyalaPlayer
 */
@interface OOSkinViewController : UIViewController

// Notifications
extern NSString *const _Nonnull OOSkinViewControllerFullscreenChangedNotification; /* Fires when player goes FullScreen  */

@property (nonatomic, nonnull, readonly) OOOoyalaPlayer *player;
@property (nonatomic, nonnull, readonly) OOSkinOptions *skinOptions;
@property (nonatomic, nonnull, readonly) NSString *version;
@property (nonatomic, nullable, readonly) OOClosedCaptionsStyle *closedCaptionsDeviceStyle;
@property (nonatomic, nonnull, readonly) id<OOCastNotifiable> castNotifyHandler;

/**
 Programatically change the fullscreen mode of the player.
 */
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;

/**
 Auto enter/exit full screen mode when device orientation changed. Default NO.
 @warning Doesn't work in VR mode.
 */
@property (nonatomic, getter=isAutoFullscreenWithRotatedEnabled) BOOL autoFullscreenWithRotatedEnabled __TVOS_PROHIBITED;

- (nonnull instancetype)init __attribute__((unavailable("init not available")));
- (nonnull instancetype)initWithPlayer:(nonnull OOOoyalaPlayer *)player
                           skinOptions:(nonnull OOSkinOptions *)jsCodeLocation
                                parent:(nonnull UIView *)parentView;

- (void)ccStyleChanged:(nonnull NSNotification *)notification;
- (void)setCastManageableHandler:(nonnull id<OOCastManageable>)castManageableHandler;

@end
