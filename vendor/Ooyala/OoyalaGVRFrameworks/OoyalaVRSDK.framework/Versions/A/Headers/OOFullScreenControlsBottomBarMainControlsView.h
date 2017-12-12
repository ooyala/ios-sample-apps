//
//  OOFullScreenControlsBottomBarMainControlsView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOPlayPauseButton.h"
#import "OONextButton.h"
#import "OOPreviousButton.h"
#import "OOFullscreenButton.h"
#import "OOVolumeButton.h"
#import "OOAirPlayButton.h"
#import "OOClosedCaptionsButton.h"
#import "OOVolumeSliderView.h"


@interface OOFullScreenControlsBottomBarMainControlsView : UIView

#pragma mark - Public properties

@property (nonatomic) OOPlayPauseButton *playPauseButton;
@property (nonatomic) OONextButton *nextButton;
@property (nonatomic) OOPreviousButton *previousButton;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOVolumeSliderView *volumeSliderView;

@property (nonatomic) BOOL playingStatus;
@property (nonatomic) BOOL airPlayButtonShowing;

@end
