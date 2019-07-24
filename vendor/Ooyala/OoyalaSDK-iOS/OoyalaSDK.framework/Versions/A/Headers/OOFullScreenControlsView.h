//
//  OOFullScreenControlsView.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

#import "OOControls.h"
#import "OOTimeSliderProtocol.h"
#import "OOVolumeSliderProtocol.h"

@protocol OOControlsDelegate;
@protocol OOTimeSliderDelegate;
@protocol OOVolumeSliderDelegate;

@interface OOFullScreenControlsView : UIView <OOControls, OOTimeSliderProtocol, OOVolumeSliderProtocol>

#pragma mark - Public properties

@property (nonatomic, weak) id<OOControlsDelegate> controlsDelegate;
@property (nonatomic, weak) id<OOTimeSliderDelegate> timeSliderDelegate;
@property (nonatomic, weak) id<OOVolumeSliderDelegate> volumeSliderDelegate;

@property (nonatomic) CGRect bottomBarFrame;
@property (nonatomic) BOOL isPiPActive;

- (void)updateDoneButtonLanguage;

@end
