//
//  OOInlineIOS7ControlsView.h
//  OoyalaSDK
//
//  Created by Liusha Huang on 8/22/13.
//  Copyright (c) 2013 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOUIProgressSlider.h"
@class OOUIProgressSliderIOS7;

@interface OOInlineIOS7ControlsView : UIView

@property (nonatomic) UIToolbar *navigationBar;
@property (nonatomic) OOUIProgressSliderIOS7 *scrubberSlider;
@property (nonatomic) UIBarButtonItem *playButton;
@property (nonatomic) UIBarButtonItem *pauseButton;
@property (nonatomic) UIBarButtonItem *fullscreenButton;
@property (nonatomic) UIBarButtonItem *closedCaptionsButton;

@property (nonatomic) BOOL playButtonShowing;
@property (nonatomic) BOOL fullscreenButtonShowing;
@property (nonatomic) BOOL closedCaptionsButtonShowing;

- (void) show;
- (void) hide;
@end
