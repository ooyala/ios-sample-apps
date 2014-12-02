/**
 * @class      OOInlineControlsView OOInlineControlsView.h "OOInlineControlsView.h"
 * @brief      OOInlineControlsView
 * @details    OOInlineControlsView.h in OoyalaSDK
 * @date       1/13/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class OOUIProgressSlider;

@interface OOInlineControlsView : UIView

@property (nonatomic) OOUIProgressSlider *scrubberSlider;
@property (nonatomic) UIButton *playButton;
@property (nonatomic) UIButton *pauseButton;
@property (nonatomic) UIButton *fullscreenButton;
@property (nonatomic) UIButton *closedCaptionsButton;

@property (nonatomic) BOOL playButtonShowing;
@property (nonatomic) BOOL fullscreenButtonShowing;

@property (nonatomic) UIView *navigationBar;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

@end
