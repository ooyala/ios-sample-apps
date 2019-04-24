/**
 * @class      OOOoyalaPlayerViewController OOOoyalaPlayerViewController.h "OOOoyalaPlayerViewController.h"
 * @brief      OOOoyalaPlayerViewController
 * @details    OOOoyalaPlayerViewController.h in OoyalaSDK
 * @date       1/9/12
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

#import <SceneKit/SceneKit.h>
#import <UIKit/UIKit.h>
#import "OOEmbedTokenGenerator.h"

extern NSString *const OOOoyalaPlayerViewControllerFullscreenEnter;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenExit;
extern NSString *const OOOoyalaPlayerViewControllerInlineViewVisible;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenViewVisible;

@class OOOoyalaAPIClient;
@class OOControlsViewController;
@class OOPlayerDomain;
@class OOClosedCaptionsStyle;
@protocol OOMotionManagement;
@class OOCameraPanGestureRecognizer;
@class OOOoyalaPlayerViewController;
@class OOOoyalaPlayer;

typedef NS_ENUM(NSInteger, OOOoyalaPlayerControlType) {
  /** an inline player, expandable to fullscreen */
  OOOoyalaPlayerControlTypeInline,
  /** a fullscreen player, not shrinkable to inline */
  OOOoyalaPlayerControlTypeFullScreen
};


/**
 * Main ViewController class for Ooyala player.
 * Implements a default skin as well as convenience methods for accesssing and initializing underlying OOOoyalaPlayer.
 */
@interface OOOoyalaPlayerViewController : UIViewController

@property (nonatomic, readonly) OOOoyalaPlayerControlType initialControlType; // initial state
@property (nonatomic, strong) OOOoyalaPlayer *player;

@property (nonatomic, strong) UIView *inlineOverlay;
@property (nonatomic, strong) UIView *fullscreenOverlay;

@property(nonatomic, strong) OOClosedCaptionsStyle *closedCaptionsStyle; /**< The OOClosedCaptionsStyle to use when displaying closed captions */

@property (nonatomic) BOOL autohideControls; /**< Property to decide if we want to enable or disable autohiding the controls after some time. Default: true */



/**
 * Get the fullscreen state
 * @return true if in fullscreen mode, false if not
 */
- (BOOL)isFullscreen;

/**
 * Set the fullscreen state
 * @param fullscreen whether the view should be fullscreened
 */
- (void)setFullscreen:(BOOL)fullscreen;

/**
 * Initialize the UI with an existing OOOoyalaPlayer object
 * @param player Reference to OOOoyalaPlayer object
 */
- (id)initWithPlayer:(OOOoyalaPlayer *)player;

/**
 * Initialize the UI with an existing OOOoyalaPlayer object and control type
 * @param player Reference to OOOoyalaPlayer object
 * @param controlType Selects inline or fullscreen only UI mode
 */
- (id)initWithPlayer:(OOOoyalaPlayer *)player
         controlType:(OOOoyalaPlayerControlType)controlType;

/**
 * Returns a dictionary of localization dictionaries. The keys are strings of locale codes.  the values are dictionaries of localized strings
 * example:
 * { "en" : { @"LIVE": @"LIVE", @"Done": @"Done", ... },
 *   "es" : { @"LIVE": @"En vivo", @"Done": @"Hecho", ... },
 *    ...
 * }
 * @return the dictionary of available localization.
 */
+ (NSDictionary *)availableLocalizations;

/**
 * Sets the available localizations for the OoyalaPlayer.
 * The "en" key must exist, do not remove it, but you can update any of the values there.
 * @param localizations the dictionary of translation dictionaries
 */
+ (void)setAvailableLocalizations:(NSDictionary *)localizations;

/**
 * Loads a dictionary of language strings according to language settings in the device
 */
+ (void)loadDeviceLanguage;

/**
 *  Instructs the player to use given dictionary of language, regardless of localization
 */
+ (void)useLanguageStrings:(NSDictionary *)strings;

/**
 * Returns a dictionary of language according to the given language string
 */
+ (NSDictionary*)getLanguageSettings:(NSString *)language;

/**
 * Returns a dictionary of current language
 */
+ (NSDictionary*)currentLanguageSettings;

/**
 * Returns the currently active controls
 */
- (OOControlsViewController *)controlsViewController;

/**
 * Shows controls on the current player
 */
- (void)showControls;

/**
 * Hides controls on the current player
 */
- (void)hideControls;

/**
 * Sets visibility of full-screen button on inline player
 * @param showing True to show fullscreen button, false otherwise
 */
- (void)setFullScreenButtonShowing: (BOOL) showing;

/**
 * Sets visibility of volume button on inline player
 * @param showing True to show fullscreen button, false otherwise
 */
- (void)setVolumeButtonShowing: (BOOL) showing;

/**
 * Sets the ViewController used to display controls in fullscreen mode
 * @param controller the initialized ViewController to use
 */
- (void)setFullScreenViewController:(OOControlsViewController *)controller;
/**
 * Sets the ViewController used to display controls in inline mode
 * @param controller the initialized ViewController to use
 */
- (void)setInlineViewController:(OOControlsViewController *)controller;

/**
 * update closed caption view position
 * @param bottomControlsRect the bottom controls rect
 * @param hidden YES if the bottom control is hidden, NO if it is not hidden
 */
- (void)updateClosedCaptionsViewPosition:(CGRect)bottomControlsRect withControlsHide:(BOOL)hidden;

@end
