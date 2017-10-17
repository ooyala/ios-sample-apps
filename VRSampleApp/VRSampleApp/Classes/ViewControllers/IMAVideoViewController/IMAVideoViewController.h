//
//  IMAVideoViewController.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import "VideoViewController.h"
#import "PlayerSelectionOption.h"


@interface IMAVideoViewController : VideoViewController

- (void)configureWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled;

@end
