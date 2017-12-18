//
//  OOFullScreenViewController.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OOTimeSliderDelegate.h"
#import "OOControlsDelegate.h"
#import "OOVolumeSliderDelegate.h"
#import "OOControlsViewController.h"


@interface OOFullScreenViewController : OOControlsViewController <OOControlsDelegate, OOTimeSliderDelegate, OOVolumeSliderDelegate>

@property (nonatomic) BOOL isGravityFilled;

@end
