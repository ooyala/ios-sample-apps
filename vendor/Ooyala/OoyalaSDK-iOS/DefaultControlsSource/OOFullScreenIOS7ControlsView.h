//
//  OOFullScreenIOS7ControlsView.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class OOUIProgressSliderIOS7;
@class OOVolumeView;

@interface OOFullScreenIOS7ControlsView : UIView

//Navigation Bar
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *slider;
@property (nonatomic) OOUIProgressSliderIOS7 *scrubberSlider;
@property (nonatomic) UIBarButtonItem *closedCaptionsButton;
@property (nonatomic) UIBarButtonItem *videoGravityFillButton;
@property (nonatomic) UIBarButtonItem *videoGravityFitButton;


@property (nonatomic) UIToolbar *bottomBarBackground;
@property (nonatomic) UIBarButtonItem *playButton;
@property (nonatomic) UIBarButtonItem *pauseButton;
@property (nonatomic) UIBarButtonItem *nextButton;
@property (nonatomic) UIBarButtonItem *previousButton;
@property (nonatomic) MPVolumeView *volumeButton;
@property (nonatomic) MPVolumeView *airPlayButton;

@property (nonatomic) BOOL playButtonShowing;
@property (nonatomic) BOOL showsAirPlayButton;
@property (nonatomic) BOOL gravityFillButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

- (void)hide;
- (void)show;
- (void)changeDoneButtonLanguage:(NSString*)language;
@end
