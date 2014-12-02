/**
 * @class      OOFullScreenControlsView OOFullScreenControlsView.h "OOFullScreenControlsView.h"
 * @brief      OOFullScreenControlsView
 * @details    OOFullScreenControlsView.h in OoyalaSDK
 * @date       1/10/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class OOUIProgressSlider;
@class OOVolumeView;

@interface OOFullScreenControlsView : UIView

//Navigation Bar
@property (nonatomic) OOUIProgressSlider *scrubberSlider;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *videoGravityFillButton;
@property (nonatomic) UIBarButtonItem *videoGravityFitButton;

//Buttons
@property (nonatomic) UIBarButtonItem *playButton;
@property (nonatomic) UIBarButtonItem *pauseButton;
@property (nonatomic) UIBarButtonItem *nextButton;
@property (nonatomic) UIBarButtonItem *previousButton;
@property (nonatomic) UIBarButtonItem *closedCaptionsButton;
@property (nonatomic) OOVolumeView *volumeView;

@property (nonatomic) BOOL playButtonShowing;
@property (nonatomic) BOOL videoGravityFillButtonShowing;

@property (nonatomic) BOOL closedCaptionsButtonShowing;
@end
