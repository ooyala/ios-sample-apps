//
//  OOFullScreenControlsBottomBarMainControlsView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OOPlayPauseButton;
@class OONextButton;
@class OOPreviousButton;
@class OOAirPlayButton;
@class OOVolumeSliderView;
@class OOPiPButton;

@interface OOFullScreenControlsBottomBarMainControlsView : UIView

#pragma mark - Public properties

@property (nonatomic) OOPlayPauseButton *playPauseButton;
@property (nonatomic) OONextButton *nextButton;
@property (nonatomic) OOPreviousButton *previousButton;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOPiPButton *pipButton;
@property (nonatomic) OOVolumeSliderView *volumeSliderView;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL airPlayButtonShowing;
@property (nonatomic) BOOL pipButtonShowing;

@end
