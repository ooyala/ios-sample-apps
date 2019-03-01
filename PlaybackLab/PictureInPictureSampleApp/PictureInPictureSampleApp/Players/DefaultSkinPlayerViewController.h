//
//  MasterViewController.h
//  OoyalaSkin
//
//  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

@import UIKit;
@import AVKit.AVPictureInPictureController;
#import "SampleAppPlayerViewController.h"

@interface DefaultSkinPlayerViewController : SampleAppPlayerViewController <AVPictureInPictureControllerDelegate>

@property (nonatomic, retain) IBOutlet UIView *videoView;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;

@end
