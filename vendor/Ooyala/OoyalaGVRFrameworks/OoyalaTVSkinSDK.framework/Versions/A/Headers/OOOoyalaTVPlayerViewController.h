#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;

@interface OOOoyalaTVPlayerViewController : UIViewController

/*!
  @property player
  @abstract The player that will playback the video supplied through this controller.
 */
@property (strong, nonatomic) OOOoyalaPlayer *player;

/*!
	@property	showsPlaybackControls
	@abstract	Whether or not the receiver shows playback controls. Default: YES.
	@discussion	Clients can set this property to NO when they don't want to have any playback controls on top of the visual content (e.g. when the player is an inline element, with sibling views).
 */
@property (nonatomic) BOOL playbackControlsEnabled;

- (instancetype)initWithPlayer:(OOOoyalaPlayer *)player;

/**
 * Show progress bar;
 */
- (void)showProgressBar;

/**
 * Hide progress bar;
 */
- (void)hideProgressBar;

- (NSArray *)availableOptions;

- (BOOL)closedCaptionMenuDisplayed;

- (void)setupClosedCaptionsMenu;

- (void)addClosedCaptionsView;

- (void)removeClosedCaptionsMenu;

@end
