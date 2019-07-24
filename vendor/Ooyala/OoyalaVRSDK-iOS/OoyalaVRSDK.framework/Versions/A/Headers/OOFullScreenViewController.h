//
//  OOFullScreenViewController.h
//  OoyalaSDK
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

#import "OOControlsViewController.h"

#import "OOControlsDelegate.h"
#import "OOVolumeSliderDelegate.h"

@interface OOFullScreenViewController : OOControlsViewController <OOControlsDelegate, OOVolumeSliderDelegate>

@property (nonatomic) BOOL isGravityFilled;

@property (nonatomic, readonly) BOOL prefersHomeIndicatorAutoHidden; // Hide Home Screen button for iPhone X, iPhone XR and iPhone XS

@end
