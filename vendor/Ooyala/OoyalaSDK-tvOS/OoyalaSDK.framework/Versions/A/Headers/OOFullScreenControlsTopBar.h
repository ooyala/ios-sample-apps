//
//  OOFullScreenControlsTopBar.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OOClosedCaptionsButton;
@class OOVideoGravityButton;
@class OOProgressSliderView;

@interface OOFullScreenControlsTopBar : UIView

#pragma mark - Public properties

@property (nonatomic) UIButton *doneButton;
@property (nonatomic) OOProgressSliderView *scrubberSlider;
@property (nonatomic) OOClosedCaptionsButton *closedCaptionsButton;
@property (nonatomic) OOVideoGravityButton *videoGravityButton;

@property (nonatomic) BOOL closedCaptionsButtonShowing;
@property (nonatomic) BOOL gravityButtonShowing;
@property (nonatomic) BOOL gravityFillShowing;

#pragma mark - Public methods

- (void)updateDoneButtonLanguage;

@end
