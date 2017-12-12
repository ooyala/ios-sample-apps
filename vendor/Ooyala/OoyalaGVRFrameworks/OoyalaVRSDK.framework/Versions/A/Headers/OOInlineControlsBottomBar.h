//
//  OOInlineControlsBottomBar.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOProgressSliderView.h"
#import "OOPlayPauseButton.h"
#import "OOFullscreenButton.h"
#import "OOVolumeButton.h"
#import "OOAirPlayButton.h"
#import "OOClosedCaptionsButton.h"
#import "OOProgressSliderView.h"


@interface OOInlineControlsBottomBar : UIView

#pragma mark - Public properties

@property (nonatomic) OOPlayPauseButton *playPauseButton;
@property (nonatomic) OOFullscreenButton *fullscreenButton;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOClosedCaptionsButton *closedCaptionsButton;
@property (nonatomic) OOProgressSliderView *timeSlider;

@property (nonatomic) BOOL isPlayingStatus;
@property (nonatomic) BOOL fullscreenButtonShowing;
@property (nonatomic) BOOL airPlayButtonShowing;
@property (nonatomic) BOOL gravityFillButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

@end
