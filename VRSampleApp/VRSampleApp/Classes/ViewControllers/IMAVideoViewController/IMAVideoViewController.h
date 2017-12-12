//
//  IMAVideoViewController.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerSelectionOption.h"


@interface IMAVideoViewController : UIViewController

- (void)configureWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled;

@end
