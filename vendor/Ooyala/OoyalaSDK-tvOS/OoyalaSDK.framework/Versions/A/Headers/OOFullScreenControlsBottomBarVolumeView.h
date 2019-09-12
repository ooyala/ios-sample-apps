//
//  OOFullScreenControlsBottomBarVolumeView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class OOVolumeSliderView;
@class OOAirPlayButton;
@class OOPiPButton;

@interface OOFullScreenControlsBottomBarVolumeView : UIView

#pragma mark - Public properties

@property (nonatomic) OOVolumeSliderView *volumeSliderView;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) OOPiPButton *pipButton;
@property (nonatomic) BOOL airPlayButtonShowing;
@property (nonatomic) BOOL pipButtonShowing;

@end
