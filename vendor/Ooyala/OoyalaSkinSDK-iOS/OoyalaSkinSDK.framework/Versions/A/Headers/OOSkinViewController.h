//
//  OOSkinViewController.h
//  OoyalaSkin
//
//

#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;
@class OOSkinOptions;
@class OOClosedCaptionsStyle;
@class OOReactBridge;

/**
 * The primary class for the Skin UI
 * Use it to display the Ooyala Skin UI alongside the OOOoyalaPlayer
 */
@interface OOSkinViewController : UIViewController

@property (nonatomic, readonly) OOOoyalaPlayer *player;
@property (nonatomic, readonly) OOSkinOptions *skinOptions;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) OOClosedCaptionsStyle *closedCaptionsDeviceStyle;

/**
 Programatically change the fullscreen mode of the player.
 */
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;

// notifications
extern NSString *const OOSkinViewControllerFullscreenChangedNotification; /* Fires when player goes FullScreen  */


- (instancetype) init __attribute__((unavailable("init not available")));
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
                   skinOptions:(OOSkinOptions *)jsCodeLocation
                        parent:(UIView *)parentView
                 launchOptions:(NSDictionary *)options;

- (void)ccStyleChanged:(NSNotification *) notification;

- (void)sendBridgeEventWithName:(NSString *)eventName body:(id)body;

@end
