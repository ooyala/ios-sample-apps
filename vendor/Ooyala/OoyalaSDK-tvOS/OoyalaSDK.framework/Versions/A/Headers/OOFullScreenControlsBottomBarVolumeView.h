//
//  OOFullScreenControlsBottomBarVolumeView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOVolumeSliderView.h"
#import "OOAirPlayButton.h"
#import "OOPipButton.h"


@interface OOFullScreenControlsBottomBarVolumeView : UIView

#pragma mark - Public properties

@property (nonatomic) OOVolumeSliderView *volumeSliderView;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOPiPButton *pipButton;
@property (nonatomic) BOOL airPlayButtonShowing;
@property (nonatomic) BOOL pipButtonShowing;

@end
