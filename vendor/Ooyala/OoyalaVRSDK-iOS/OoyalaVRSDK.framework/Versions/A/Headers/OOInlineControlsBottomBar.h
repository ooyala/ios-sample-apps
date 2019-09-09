//
//  OOInlineControlsBottomBar.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OOPlayPauseButton;
@class OOFullscreenButton;
@class OOAirPlayButton;
@class OOClosedCaptionsButton;
@class OOProgressSliderView;
@class OOPiPButton;

@interface OOInlineControlsBottomBar : UIView

#pragma mark - Public properties

@property (nonatomic) OOPlayPauseButton *playPauseButton;
@property (nonatomic) OOFullscreenButton *fullscreenButton;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOClosedCaptionsButton *closedCaptionsButton;
@property (nonatomic) OOProgressSliderView *timeSlider;
@property (nonatomic) OOPiPButton *pipButton;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL fullscreenButtonShowing;
@property (nonatomic) BOOL airPlayButtonShowing;
@property (nonatomic) BOOL gravityFillButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;
@property (nonatomic) BOOL pipButtonShowing;

@end
