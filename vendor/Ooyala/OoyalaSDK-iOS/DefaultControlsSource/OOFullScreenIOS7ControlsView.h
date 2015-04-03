//
//  OOFullScreenIOS7ControlsView.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "OOClosedCaptionsButton.h"
#import "OOPlayPauseButton.h"
#import "OOVideoGravityButton.h"

@class OOUIProgressSliderIOS7;
@class OOVolumeView;

@interface OOFullScreenIOS7ControlsView : UIView

//Navigation Bar
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *slider;
@property (nonatomic) OOUIProgressSliderIOS7 *scrubberSlider;
@property (nonatomic) OOClosedCaptionsButton *closedCaptionsButton;
@property (nonatomic) OOVideoGravityButton *videoGravityButton;


@property (nonatomic) UIToolbar *bottomBarBackground;
@property (nonatomic) OOPlayPauseButton *playButton;
@property (nonatomic) UIBarButtonItem *nextButton;
@property (nonatomic) UIBarButtonItem *previousButton;
@property (nonatomic) MPVolumeView *volumeButton;
@property (nonatomic) MPVolumeView *airPlayButton;

@property (nonatomic) BOOL playButtonShowing;
@property (nonatomic) BOOL showsAirPlayButton;
@property (nonatomic) BOOL isGravityFilled;
@property (nonatomic) BOOL videoGravityButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

- (void)hide;
- (void)show;
- (void)changeDoneButtonLanguage:(NSString*)language;
@end
