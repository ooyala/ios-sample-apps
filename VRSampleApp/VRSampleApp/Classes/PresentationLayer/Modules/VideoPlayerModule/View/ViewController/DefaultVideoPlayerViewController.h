//
//  DefaultVideoPlayerViewController.h
//  VRSampleApp
//
//  Copyright © 2017 Ooyala Inc. All rights reserved.
//

@import UIKit;

@class OOSkinViewController;
@class VideoPlayerViewModel;
@class AppDelegate;

@interface DefaultVideoPlayerViewController : UIViewController

@property (nonatomic) OOSkinViewController *skinController;
@property (nonatomic) VideoPlayerViewModel *viewModel;
@property (nonatomic) AppDelegate *appDelegate;

@end
