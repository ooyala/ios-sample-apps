/**
 * @class      OOControlsViewController OOControlsViewController.h "OOControlsViewController.h"
 * @brief      OOControlsViewController
 * @details    OOControlsViewController.h in OoyalaSDK
 * @date       2/23/12
 * @copyright Copyright © 2015 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

#import "OOOoyalaPlayerViewController.h"
#import "OOPlayerState.h"
#import "OOEnums.h"
#import "OOOoyalaPlayerDelegate.h"
#import "OOTimeSliderDelegate.h"

@class OOOoyalaPlayer;

static const double CONTROLS_HIDE_TIMEOUT = 5.37;

@interface OOControlsViewController : UIViewController <OOOoyalaPlayerDelegate, OOTimeSliderDelegate> {
  @protected
  BOOL seeking;
  BOOL inAdMode;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) OOOoyalaPlayer *player;
@property (nonatomic, weak) UIView *overlay;
@property (nonatomic) UIActivityIndicatorView *activityView;
@property (nonatomic) UIView *controls;
@property (nonatomic) BOOL isVisible;
@property (nonatomic) NSTimer *hideControlsTimer;
@property (nonatomic) BOOL autohideControls;

- (instancetype)initWithControlsType:(OOOoyalaPlayerControlType)controlsType
                              player:(OOOoyalaPlayer *)player
                             overlay:(UIView *)overlay
                            delegate:(id)theDelegate;

- (void)showControls;
- (void)hideControls;
- (void)syncUIWithState:(OOOoyalaPlayerState)state;

//Hide and show the full screen button on the inline view
- (void)setFullScreenButtonShowing:(BOOL)isShowing;

//Hide and show the volume button on the inline view
- (void)setVolumeButtonShowing:(BOOL)isShowing;

- (OOUIProgressSliderMode)sliderMode;

// Change the language of controls when close caption changed
- (void)changeButtonLanguage:(NSString *)language;

// Switch the gravity for full screen mode.
- (void)switchVideoGravity;

- (void)updateClosedCaptionsPosition;

// calculate and set visibility of CC button.
- (void)updateClosedCaptionsButton;

// toggle the control buttons.
- (void)toggleControls;

@end
