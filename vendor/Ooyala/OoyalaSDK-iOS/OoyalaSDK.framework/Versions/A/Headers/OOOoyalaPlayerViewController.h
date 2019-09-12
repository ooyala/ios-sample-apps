/**
 @class      OOOoyalaPlayerViewController OOOoyalaPlayerViewController.h "OOOoyalaPlayerViewController.h"
 @brief      OOOoyalaPlayerViewController
 @details    OOOoyalaPlayerViewController.h in OoyalaSDK
 @date       1/9/12
 @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#ifndef OOOoyalaPlayerViewController_h
#define OOOoyalaPlayerViewController_h

@import UIKit;

#import "OOOoyalaPlayerControllerDelegate.h"

extern NSString *const OOOoyalaPlayerViewControllerFullscreenEnter;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenExit;
extern NSString *const OOOoyalaPlayerViewControllerInlineViewVisible;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenViewVisible;

@class OOOoyalaPlayer;
@class OOControlsViewController;
@class OOClosedCaptionsStyle;

typedef NS_ENUM(NSInteger, OOOoyalaPlayerControlType) {
  /** an inline player, expandable to fullscreen */
  OOOoyalaPlayerControlTypeInline,
  /** a fullscreen player, not shrinkable to inline */
  OOOoyalaPlayerControlTypeFullScreen
};

/**
 Main ViewController class for Ooyala player.
 Implements a default skin as well as convenience methods for accesssing and initializing underlying OOOoyalaPlayer.
 */
@interface OOOoyalaPlayerViewController : UIViewController <OOOoyalaPlayerControllerDelegate>

@property (nonatomic, readonly) OOOoyalaPlayerControlType initialControlType; // initial state
@property (nonatomic) OOOoyalaPlayer *player;
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic) UIView *inlineOverlay;
@property (nonatomic) UIView *fullscreenOverlay;

@property (nonatomic) OOClosedCaptionsStyle *closedCaptionsStyle; /**< The OOClosedCaptionsStyle to use when displaying closed captions */

@property (nonatomic) BOOL autohideControls; /**< Property to decide if we want to enable or disable autohiding the controls after some time. Default: true */

/**
 Initialize the UI with an existing OOOoyalaPlayer object
 @param player Reference to OOOoyalaPlayer object
 */
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player;

/**
 * Initialize the UI with an existing OOOoyalaPlayer object and control type
 * @param player Reference to OOOoyalaPlayer object
 * @param controlType Selects inline or fullscreen only UI mode
 */
- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player
                   controlType:(OOOoyalaPlayerControlType)controlType;

/**
 Returns a dictionary of localization dictionaries. The keys are strings of locale codes. The values are dictionaries of localized strings
 example:
 @code
 { "en" : { @"LIVE": @"LIVE", @"Done": @"Done", ... },
   "es" : { @"LIVE": @"En vivo", @"Done": @"Hecho", ... },
    ...
 }
 @endcode
 @return the dictionary of available localization.
 */
+ (NSDictionary *)availableLocalizations;

/**
 Sets the available localizations for the OoyalaPlayer.
 The "en" key must exist, do not remove it, but you can update any of the values there.
 @param localizations the dictionary of translation dictionaries
 */
+ (void)setAvailableLocalizations:(NSDictionary *)localizations;

/**
 Loads a dictionary of language strings according to language settings in the device
 */
+ (void)loadDeviceLanguage;

/**
 Instructs the player to use given dictionary of language, regardless of localization
 */
+ (void)useLanguageStrings:(NSDictionary *)strings;

/**
 Returns a dictionary of language according to the given language string
 */
+ (NSDictionary *)getLanguageSettings:(NSString *)language;

/**
 Returns a dictionary of current language
 */
+ (NSDictionary *)currentLanguageSettings;

/**
 Returns the currently active controls
 */
- (OOControlsViewController *)controlsViewController;

/**
 Shows controls on the current player
 */
- (void)showControls;

/**
 Hides controls on the current player
 */
- (void)hideControls;

/**
 Disables and hides controls
 */
- (void)disableControls;

/**
 Enables and sets the normal behaviour for controls
 */
- (void)enableControls;

/**
 Sets visibility of full-screen button on inline player
 * @param showing True to show fullscreen button, false otherwise
 */
- (void)setFullScreenButtonShowing:(BOOL)showing;

/**
 Sets visibility of volume button on inline player
 @param showing True to show fullscreen button, false otherwise
 */
- (void)setVolumeButtonShowing:(BOOL)showing;

/**
 Sets the ViewController used to display controls in fullscreen mode
 @param controller the initialized ViewController to use
 */
- (void)setFullScreenViewController:(OOControlsViewController *)controller;

/**
 Sets the ViewController used to display controls in inline mode
 @param controller the initialized ViewController to use
 */
- (void)setInlineViewController:(OOControlsViewController *)controller;

@end

#endif
