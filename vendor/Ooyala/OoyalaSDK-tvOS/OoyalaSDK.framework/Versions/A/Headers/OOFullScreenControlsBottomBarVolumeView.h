//
//  OOFullScreenControlsBottomBarVolumeView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OOVolumeSliderView.h"
#import "OOAirPlayButton.h"


@interface OOFullScreenControlsBottomBarVolumeView : UIView

#pragma mark - Public properties

@property (nonatomic) OOVolumeSliderView *volumeSliderView;
@property (nonatomic) OOAirPlayButton *airPlayButton;
@property (nonatomic) BOOL airPlayButtonShowing;

@end
