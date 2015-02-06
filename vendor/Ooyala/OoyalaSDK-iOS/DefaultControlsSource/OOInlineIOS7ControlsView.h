//
//  OOInlineIOS7ControlsView.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOUIProgressSliderIOS7.h"
#import <MediaPlayer/MediaPlayer.h>
#import "OOPlayPauseButton.h"
#import "OOClosedCaptionsButton.h"
#import "OOFullscreenButton.h"


@interface OOInlineIOS7ControlsView : UIView

//Navigation Bar
@property (nonatomic) UIToolbar *navigationBar;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *slider;
@property (nonatomic) OOUIProgressSliderIOS7 *scrubberSlider;
@property (nonatomic) OOFullscreenButton *fullscreenButton;
@property (nonatomic) OOClosedCaptionsButton *closedCaptionsButton;
@property (nonatomic) UIBarButtonItem *videoGravityFillButton;
@property (nonatomic) UIBarButtonItem *videoGravityFitButton;


@property (nonatomic) UIToolbar *bottomBarBackground;
@property (nonatomic) OOPlayPauseButton *playButton;
@property (nonatomic) MPVolumeView *volumeButton;
@property (nonatomic) MPVolumeView *airPlayButton;

@property (nonatomic) BOOL fullscreenButtonShowing;
@property (nonatomic) BOOL showsAirPlayButton;
@property (nonatomic) BOOL gravityFillButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

- (void)setIsPlayShowing:(BOOL)showing;

- (void)hide;
- (void)show;
- (void)changeDoneButtonLanguage:(NSString*)language;
@end
