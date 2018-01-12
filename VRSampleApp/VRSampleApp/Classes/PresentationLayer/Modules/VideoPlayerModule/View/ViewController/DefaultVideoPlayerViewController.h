//
//  DefaultVideoPlayerViewController.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "VideoPlayerViewModel.h"
#import <OoyalaVRSDK/OoyalaVRSDK.h>
#import <OoyalaSkinSDK/OoyalaSkinSDK.h>


@interface DefaultVideoPlayerViewController : UIViewController

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) VideoPlayerViewModel *viewModel;
@property (nonatomic) AppDelegate *appDelegate;

@end
