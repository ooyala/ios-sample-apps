//
//  OOInlineControlsView.h
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

@interface OOInlineControlsView : UIView <OOControls, OOTimeSliderProtocol, OOVolumeSliderProtocol>

#pragma mark - Public properties

@property (nonatomic, weak) id<OOControlsDelegate> controlsDelegate;
@property (nonatomic, weak) id<OOTimeSliderDelegate> timeSliderDelegate;

@property (nonatomic) CGRect bottomBarFrame;
@property (nonatomic) BOOL isPiPActive;

@end
