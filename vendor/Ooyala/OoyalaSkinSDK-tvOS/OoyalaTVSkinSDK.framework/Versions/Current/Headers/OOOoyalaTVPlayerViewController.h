#import <UIKit/UIKit.h>

@class OOOoyalaPlayer;

@interface OOOoyalaTVPlayerViewController : UIViewController
/**
The player that will playback the video supplied through this controller.
 */
@property (nonatomic) OOOoyalaPlayer *player;
/**
	@property	showsPlaybackControls
	@abstract	Whether or not the receiver shows playback controls. Default: YES.
	@discussion	Clients can set this property to NO when they don't want to have any playback controls on top of the visual content (e.g. when the player is an inline element, with sibling views).
 */
@property (nonatomic) BOOL playbackControlsEnabled;
/**
 @property progressTintColor
 @abstract The color that will be used to tint the player's progress bar.
 */
@property (nonatomic) UIColor *progressTintColor;

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

- (void)updatePlayheadWithSeekTime:(double)seekTime;

@end
