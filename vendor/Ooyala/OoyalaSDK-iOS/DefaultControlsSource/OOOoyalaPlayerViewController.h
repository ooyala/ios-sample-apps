/**
 * @class      OOOoyalaPlayerViewController OOOoyalaPlayerViewController.h "OOOoyalaPlayerViewController.h"
 * @brief      OOOoyalaPlayerViewController
 * @details    OOOoyalaPlayerViewController.h in OoyalaSDK
 * @date       1/9/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "OOOoyalaPlayer.h"
#import "OOEmbedTokenGenerator.h"

extern NSString *const OOOoyalaPlayerViewControllerFullscreenEnter;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenExit;
extern NSString *const OOOoyalaPlayerViewControllerInlineViewVisible;
extern NSString *const OOOoyalaPlayerViewControllerFullscreenViewVisible;

@class OOOoyalaAPIClient;
@class OOControlsViewController;
@class OOPlayerDomain;

/**
 * Main ViewController class for Ooyala player.
 * Implements a default skin as well as convenience methods for accesssing and initializing underlying OOOoyalaPlayer.
 */
@interface OOOoyalaPlayerViewController : UIViewController

typedef NS_ENUM(NSInteger, OOOoyalaPlayerControlType) {
  /** an inline player, expandable to fullscreen */
  OOOoyalaPlayerControlTypeInline,
  /** a fullscreen player, not shrinkable to inline */
  OOOoyalaPlayerControlTypeFullScreen
};

@property (nonatomic, readonly) OOOoyalaPlayerControlType initialControlType; // initial state
@property (nonatomic, strong) OOOoyalaPlayer *player;

@property (nonatomic, strong) UIView *inlineOverlay;
@property (nonatomic, strong) UIView *fullscreenOverlay;

/**
 * Get the fullscreen state
 * @returns true if in fullscreen mode, false if not
 */
- (BOOL)isFullscreen;

/**
 * Set the fullscreen state
 * @param[in] fullscreen whether the view should be fullscreened
 */
- (void)setFullscreen:(BOOL)fullscreen;

/**
 * Initialize the UI with an existing OOOoyalaPlayer object
 * @param[in] player Reference to OOOoyalaPlayer object
 */
- (id)initWithPlayer:(OOOoyalaPlayer *)player;

/**
 * Initialize the UI with an existing OOOoyalaPlayer object and control type
 * @param[in] player Reference to OOOoyalaPlayer object
 * @param[in] controlType Selects inline or fullscreen only UI mode
 */
- (id)initWithPlayer:(OOOoyalaPlayer *)player
         controlType:(OOOoyalaPlayerControlType)controlType;

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
- (OOControlsViewController *)getControls;

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
 * @param[in] showing True to show fullscreen button, false otherwise
 */
- (void)setFullScreenButtonShowing: (BOOL) showing;

/**
 * Sets the ViewController used to display controls in fullscreen mode
 * @param[in] controller the initialized ViewController to use
 */
- (void)setFullScreenViewController:(OOControlsViewController *)controller;
/**
 * Sets the ViewController used to display controls in inline mode
 * @param[in] controller the initialized ViewController to use
 */
- (void)setInlineViewController:(OOControlsViewController *)controller;

@end
